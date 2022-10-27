import 'package:Flutter_BoilerPlate_With_Auth/core/app/authentication_credentials_config.dart';
import 'package:Flutter_BoilerPlate_With_Auth/core/app/authentication_external_config.dart';
import 'package:Flutter_BoilerPlate_With_Auth/core/app/flavor_config.dart';
import 'package:Flutter_BoilerPlate_With_Auth/core/app/theme_config.dart';
import 'package:Flutter_BoilerPlate_With_Auth/core/enums/language.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'UI/app.dart';

void main() async {
  FlavorConfig(
      flavor: Flavor.PRODUCTION,
      envColor: Colors.redAccent.shade100,
      supportedLanguages: [Language.DE, Language.EN, Language.FR, Language.IT],
      values: FlavorValues(
          baseUrl: "", //please provide baseUrl
          authenticationExternalConfig: AuthenticationExternalConfig(
              title: 'Login IDP',
              authorizationAuthorizationEndpoint: "",
              authorizationTokenEndpoint: "",
              authorizationAppIdentifier: "",
              authorizationAppSecret: "",
              authorizationRedirectUrl: "",
              logoutUrl: ""), //please provide External Authorization endpoint
          privacyNoticeUrl: "https://dev.to",
          contactInfoUrl: "https://dev.to",
          themeConfig: ThemeConfig(),
          logo: "assets/images/logo.png")); //logo in assets

  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb ? HydratedStorage.webStorageDirectory : await getTemporaryDirectory(),
  );
  runApp(MyApp());
}
