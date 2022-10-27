import 'package:flutter/material.dart';

class AuthenticationExternalConfig {
  AuthenticationExternalConfig(
      {@required this.title,
      @required this.authorizationAuthorizationEndpoint,
      @required this.authorizationTokenEndpoint,
      @required this.authorizationAppIdentifier,
      @required this.authorizationAppSecret,
      @required this.authorizationRedirectUrl,
      @required this.logoutUrl});

  final String? title;
  final String? authorizationAuthorizationEndpoint;
  final String? authorizationTokenEndpoint;
  final String? authorizationAppIdentifier;
  final String? authorizationAppSecret;
  final String? authorizationRedirectUrl;
  final String? logoutUrl;
}
