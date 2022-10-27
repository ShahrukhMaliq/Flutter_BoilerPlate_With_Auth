// ignore_for_file: body_might_complete_normally_nullable

import 'dart:async';
import 'dart:convert';

import 'package:Flutter_BoilerPlate_With_Auth/core/app/authentication_context.dart';
import 'package:Flutter_BoilerPlate_With_Auth/core/app/flavor_config.dart';
import 'package:Flutter_BoilerPlate_With_Auth/core/base/api_client.dart';
import 'package:Flutter_BoilerPlate_With_Auth/core/enums/authentication_status.dart';
import 'package:Flutter_BoilerPlate_With_Auth/core/models/authentication/user.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:oauth2/oauth2.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends HydratedBloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationContext _authenticationContext = AuthenticationContext();
  Credentials? credentials;
  Client? client;
  StreamSubscription<AuthenticationStatus>? _authenticationStatusSubscription;
  AuthenticationBloc() : super(AuthenticationState.unauthenticated()) {
    _authenticationStatusSubscription =
        _authenticationContext.status.listen((status) => add(AuthenticationStatusChanged(status)));
  }
  AuthenticationState fromJson(Map<String, dynamic> json) {
    User restoreuser;
    AuthenticationStatus restorestatus =
        AuthenticationStatus.values.firstWhere((e) => e.toString() == json['status']);
    if (restorestatus == AuthenticationStatus.authenticated && !FlavorConfig.isDemo()) {
      var jsonResult = jsonDecode(json['credentials']);
      credentials = Credentials(jsonResult['accessToken'].toString(),
          refreshToken: jsonResult['refreshToken'].toString(),
          tokenEndpoint: Uri.parse(ApiClient.getFullUrl('api/Auth/RefreshToken')),
          expiration: DateTime.now().add(Duration(days: 1)));
      client = new Client(credentials!);
      _authenticationContext.oauth2Client = client;
    }
    if (json['user'] == null) {
      restoreuser = new User();
    } else {
      restoreuser = User.fromJson(json['user']);
    }

    return AuthenticationState(status: restorestatus, user: restoreuser);
  }

  @override
  Map<String, dynamic>? toJson(AuthenticationState instance) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (instance.user != null &&
        instance.status != null &&
        instance.status == AuthenticationStatus.authenticated) {
      data['status'] = instance.status.toString();
      data['user'] = instance.user;

      if (instance.status == AuthenticationStatus.authenticated)
        data['credentials'] = _authenticationContext.oauth2Client?.credentials;
      return data;
    }
  }

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AuthenticationStatusChanged) {
      yield await _mapAuthenticationStatusChangedToState(event);
    }
  }

  Future<AuthenticationState> _mapAuthenticationStatusChangedToState(
    AuthenticationStatusChanged event,
  ) async {
    switch (event.status) {
      case AuthenticationStatus.unauthenticated:
        return AuthenticationState.unauthenticated();
      case AuthenticationStatus.authenticating:
        return AuthenticationState.authenticating();
      case AuthenticationStatus.authenticated:
        final user = _authenticationContext.user;

        return AuthenticationState.authenticated(user!);
      default:
        return AuthenticationState.unknown();
    }
  }

  @override
  Future<void> close() {
    _authenticationStatusSubscription!.cancel();
    return super.close();
  }
}
