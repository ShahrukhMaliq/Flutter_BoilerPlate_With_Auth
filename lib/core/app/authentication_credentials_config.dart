import 'package:flutter/material.dart';

class AuthenticationCredentialsConfig {
  AuthenticationCredentialsConfig({@required this.title, @required this.authorizationEndpoint});

  final String? title;
  final String? authorizationEndpoint;
}
