import 'package:Flutter_BoilerPlate_With_Auth/core/app/authentication_credentials_config.dart';
import 'package:Flutter_BoilerPlate_With_Auth/core/app/authentication_external_config.dart';
import 'package:Flutter_BoilerPlate_With_Auth/core/app/theme_config.dart';
import 'package:Flutter_BoilerPlate_With_Auth/core/enums/language.dart';
import 'package:Flutter_BoilerPlate_With_Auth/core/utils/string_utils.dart';
import 'package:flutter/material.dart';

enum Flavor { DEV, DEMO, LIVEDEMO, QA, PRODUCTION }

class FlavorValues {
  FlavorValues(
      {@required this.baseUrl,
      this.authenticationExternalConfig,
      this.authenticationCredentialsConfig,
      @required this.privacyNoticeUrl,
      @required this.contactInfoUrl,
      @required this.themeConfig,
      @required this.logo});

  final String? baseUrl;
  final AuthenticationExternalConfig? authenticationExternalConfig;
  final AuthenticationCredentialsConfig? authenticationCredentialsConfig;
  final String? privacyNoticeUrl;
  final String? contactInfoUrl;
  final ThemeConfig? themeConfig;
  final String? logo;
}

class FlavorConfig {
  final Flavor flavor;
  final String envName;
  final Color envColor;
  final List<Language> supportedLanguages;
  final FlavorValues values;

  static FlavorConfig _instance = FlavorConfig._instance;

  factory FlavorConfig(
      {required Flavor flavor,
      Color envColor: Colors.blue,
      required List<Language> supportedLanguages,
      required FlavorValues values}) {
    _instance = FlavorConfig._internal(
        flavor, StringUtils.enumName(flavor.toString()), envColor, supportedLanguages, values);
    return _instance;
  }

  FlavorConfig._internal(
      this.flavor, this.envName, this.envColor, this.supportedLanguages, this.values);

  static FlavorConfig get instance {
    return _instance;
  }

  static bool isProduction() => _instance.flavor == Flavor.PRODUCTION;

  static bool isDevelopment() => _instance.flavor == Flavor.DEV;

  static bool isDemo() => _instance.flavor == Flavor.DEMO;

  static bool isQA() => _instance.flavor == Flavor.QA;
}
