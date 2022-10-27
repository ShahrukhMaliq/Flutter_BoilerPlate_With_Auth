import 'package:Flutter_BoilerPlate_With_Auth/core/app/authentication_credentials_config.dart';
import 'package:Flutter_BoilerPlate_With_Auth/core/app/flavor_config.dart';
import 'package:Flutter_BoilerPlate_With_Auth/core/app/theme_config.dart';
import 'package:Flutter_BoilerPlate_With_Auth/core/enums/language.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'UI/app.dart';

Future<void> main() async {
  FlavorConfig(
      flavor: Flavor.LIVEDEMO,
      envColor: Colors.redAccent.shade100,
      supportedLanguages: [Language.DE, Language.EN, Language.FR, Language.IT],
      values: FlavorValues(
          baseUrl: "", //please provide base URL
          authenticationCredentialsConfig: AuthenticationCredentialsConfig(
              title: 'Login', authorizationEndpoint: ''), //please provide Authorization endpoint
          privacyNoticeUrl: "https://dev.to",
          contactInfoUrl: "https://dev.to",
          themeConfig: ThemeConfig(),
          logo: "assets/images/logo.png"));
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb ? HydratedStorage.webStorageDirectory : await getTemporaryDirectory(),
  );
  runApp(const MyApp());
}
