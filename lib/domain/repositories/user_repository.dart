import 'dart:async';
import 'package:Flutter_BoilerPlate_With_Auth/core/app/flavor_config.dart';
import 'package:Flutter_BoilerPlate_With_Auth/core/base/api_client.dart';
import 'package:Flutter_BoilerPlate_With_Auth/core/models/authentication/user.dart';

/// Globally accessible UserRepository.
class UserRepository {
  ApiClient _apiClient = ApiClient();

  static final UserRepository _instance = UserRepository._internal();

  factory UserRepository() => _instance;

  UserRepository._internal();

  Future<User> getUser() async {
    if (FlavorConfig.isDemo()) {
      return User(login: "test_user");
    }

    String url = 'api/myapi/user'; //endpoint for authenticating user
    var responseJson = await _apiClient.getJson(url);
    var result = User.fromJson(responseJson);

    return result;
  }
}
