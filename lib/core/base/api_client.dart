import 'dart:async';
import 'dart:convert';

import 'package:Flutter_BoilerPlate_With_Auth/core/app/authentication_context.dart';
import 'package:Flutter_BoilerPlate_With_Auth/core/app/flavor_config.dart';

class ApiClient {
  static const int TIMEOUT_SECONDS = 30;
  static final String baseUrl = FlavorConfig.instance.values.baseUrl!;
  final AuthenticationContext authenticationContext = AuthenticationContext();
  Future<dynamic> getJson(String url) async {
    try {
      url = combineUrls(baseUrl, url);

      final response = await authenticationContext.oauth2Client?.get(Uri.parse(url), headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "Access-Control-Allow-Origin": "*"
      }).timeout(const Duration(seconds: TIMEOUT_SECONDS));

      if (response?.statusCode == 204) {
        return null;
      }

      final responseJson = json.decode(response!.body);

      return responseJson;
    } catch (err) {
      throw err;
    }
  }

  Future<dynamic> post(String url, String data) async {
    try {
      url = combineUrls(baseUrl, url);
      final response = await authenticationContext.oauth2Client?.post(Uri.parse(url),
          body: data,
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json'
          }).timeout(const Duration(seconds: TIMEOUT_SECONDS));

      return response?.statusCode;
    } catch (err) {
      throw err;
    }
  }

  Future<String?> getBase64(String url) async {
    try {
      url = getFullUrl(url);
      final response = await authenticationContext.oauth2Client
          ?.get(Uri.parse(url))
          .timeout(const Duration(seconds: TIMEOUT_SECONDS));

      if (response?.statusCode != 200) {
        return null;
      }

      var base64String = base64.encode(response!.bodyBytes);
      return base64String;
    } catch (err) {
      throw err;
    }
  }

  static String getFullUrl(String path) {
    return combineUrls(baseUrl, path);
  }

  static String combineUrls(String baseUrl, String path) {
    if (path.startsWith('http://') || path.startsWith('https://')) {
      return path;
    }

    if (!baseUrl.endsWith('/')) {
      baseUrl = baseUrl + '/';
    }

    if (path.startsWith('/')) {
      path = path.substring(1);
    }

    var result = baseUrl + path;
    return result;
  }

  Map<String, String> getAuthenticationHeaders() {
    final Map<String, String> map = {};

    if (authenticationContext.oauth2Client?.credentials.accessToken != null) {
      map["Authorization"] =
          "Bearer " + authenticationContext.oauth2Client!.credentials.accessToken;
    }

    return map;
  }
}
