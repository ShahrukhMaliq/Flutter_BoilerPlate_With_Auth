import 'dart:async';
import 'dart:convert';

import 'package:Flutter_BoilerPlate_With_Auth/_dev/json/user_demo.dart';
import 'package:Flutter_BoilerPlate_With_Auth/core/base/api_client.dart';
import 'package:Flutter_BoilerPlate_With_Auth/core/enums/authentication_status.dart';
import 'package:Flutter_BoilerPlate_With_Auth/core/models/authentication/credentials_login_response.dart';
import 'package:Flutter_BoilerPlate_With_Auth/core/models/authentication/user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';

import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:oauth2/oauth2.dart';
import 'package:http/http.dart' as http;

import 'flavor_config.dart';

/// Globally accessible AuthenticationContext.
class AuthenticationContext {
  static final AuthenticationContext _instance = AuthenticationContext._internal();
  factory AuthenticationContext() => _instance;
  AuthenticationContext._internal();

  final _secureStorage = new FlutterSecureStorage();
  final _credentialsKey = "AUTH_CREDENTIALS";
  User? _user;
  final _authenticationStatusController =
      StreamController<AuthenticationStatus>.broadcast(sync: false);

  oauth2.Client? oauth2Client;

  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    //yield AuthenticationStatus.unauthenticated;
    yield* _authenticationStatusController.stream;
  }

  User? get user => _user;
  void users(User u) {
    _user = u;
  }

  Future<void> externalLogIn() async {
    if (await checkDummyLoginAvailableAndLogin()) {
      return;
    }

    try {
      _authenticationStatusController.add(AuthenticationStatus.authenticating);

      var externalAuthConfig = FlavorConfig.instance.values.authenticationExternalConfig;
      final authorizationEndpoint =
          Uri.parse(externalAuthConfig!.authorizationAuthorizationEndpoint!);
      final tokenEndpoint = Uri.parse(externalAuthConfig.authorizationTokenEndpoint!);
      final identifier = externalAuthConfig.authorizationAppIdentifier;
      final secret = externalAuthConfig.authorizationAppSecret;
      final redirectUrl = externalAuthConfig.authorizationRedirectUrl;

      var grant = oauth2.AuthorizationCodeGrant(identifier!, authorizationEndpoint, tokenEndpoint,
          secret: secret);
      var authorizationUrl = grant.getAuthorizationUrl(Uri.parse(redirectUrl!));

      final authorizeUrl = authorizationUrl.toString();
      final callbackUrl = redirectUrl.toString();
      final callbackUrlScheme = Uri.parse(callbackUrl).scheme;

      var receivedCallback = await FlutterWebAuth.authenticate(
          url: authorizeUrl, callbackUrlScheme: callbackUrlScheme);

      if (receivedCallback.startsWith(redirectUrl)) {
        var responseUrl = Uri.parse(receivedCallback);
        var client = await grant.handleAuthorizationResponse(responseUrl.queryParameters);
        var user = await _tryGetUser(client);

        await _finalizeLogin(client, user);
      } else if (receivedCallback.startsWith(callbackUrlScheme) &&
          receivedCallback.trim().endsWith("ACCESS_ALLOWED")) {
        await new Future.delayed(const Duration(seconds: 5));
        await externalLogIn();
      } else {
        _authenticationStatusController.add(AuthenticationStatus.unauthenticated);
      }
    } catch (ex) {
      _authenticationStatusController.add(AuthenticationStatus.unauthenticated);
      throw ex;
    }
  }

  Future<void> credentialsLogIn(String login, String password) async {
    if (await checkDummyLoginAvailableAndLogin()) {
      return;
    }
    try {
      _authenticationStatusController.add(AuthenticationStatus.authenticating);
      var credentialsAuthEndpoint =
          FlavorConfig.instance.values.authenticationCredentialsConfig?.authorizationEndpoint;
      var loginData = jsonEncode(<String, String>{'login': login, 'password': password});
      var loginResultResponse = await http.post(Uri.parse(credentialsAuthEndpoint.toString()),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: loginData);
      var loginResultJson = json.decode(loginResultResponse.body);
      var loginResult = CredentialsLoginResponse.fromJson(loginResultJson);
      var credentials = Credentials(loginResult.accessToken.toString(),
          refreshToken: loginResult.refreshToken,
          tokenEndpoint: Uri.parse(ApiClient.getFullUrl('api/Auth/RefreshToken')),
          expiration: DateTime.now().add(Duration(seconds: loginResult.expiresIn!.toInt())));

      var client = oauth2.Client(credentials);

      await handleSuccessfulLogin(client);
    } catch (ex) {
      _authenticationStatusController.add(AuthenticationStatus.unauthenticated);

      throw ex;
    }
  }

  Future<void> persistClient() async {
    if (oauth2Client == null) {
      return;
    }

    try {
      _secureStorage.write(key: _credentialsKey, value: oauth2Client?.credentials.toJson());
    } catch (err) {
      //ignore for now

      throw err;
    }
  }

  Future<void> restoreCurrentUser() async {
    try {
      _authenticationStatusController.add(AuthenticationStatus.authenticating);

      var credentialsJson = await _secureStorage.read(key: _credentialsKey);
      if (credentialsJson == null) {
        _authenticationStatusController.add(AuthenticationStatus.unauthenticated);
        return;
      }
      if (await checkDummyLoginAvailableAndLogin()) {
        return;
      }
      try {
        var credentials = oauth2.Credentials.fromJson(credentialsJson);

        var credentialsAuthEndpoint = FlavorConfig.instance.values.authenticationCredentialsConfig;

        if (credentialsAuthEndpoint != null) {
          var client = oauth2.Client(credentials);
          await handleSuccessfulLogin(client);
        }
      } catch (_) {
        try {
          _secureStorage.delete(key: _credentialsKey);
        } catch (_) {
          //ignore any error
        }
        _authenticationStatusController.add(AuthenticationStatus.unauthenticated);
      }
    } catch (ex) {
      _authenticationStatusController.add(AuthenticationStatus.unauthenticated);

      throw ex;
    }
  }

  Future<void> handleSuccessfulLogin(oauth2.Client client) async {
    //make a request to retrieve current user to make sure accessToken/refreshToken is not expired
    var user = await _tryGetUser(client);

    await _finalizeLogin(client, user);
  }

  Future<bool> checkDummyLoginAvailableAndLogin() async {
    if (FlavorConfig.isDemo()) {
      await _finalizeLogin(null, UserDemo.getDemoUser());
      return true;
    }

    return false;
  }

  Future<void> _finalizeLogin(oauth2.Client? client, User user) async {
    _user = user;
    oauth2Client = client;
    _authenticationStatusController.add(AuthenticationStatus.authenticated);
  }

  Future<User> _tryGetUser(oauth2.Client client) async {
    try {
      var getUserUrl = ApiClient.getFullUrl('api/Category/AM/user');
      var userResponse = await client.get(Uri.parse(getUserUrl));
      var userJson = json.decode(userResponse.body);
      var user = User.fromJson(userJson);

      return user;
    } catch (err) {
      throw err;
    }
  }

  Future<void> logOut() async {
    await _secureStorage.deleteAll();

    _authenticationStatusController.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _authenticationStatusController.close();
}
