import 'package:Flutter_BoilerPlate_With_Auth/core/app/authentication_context.dart';
import 'package:Flutter_BoilerPlate_With_Auth/core/app/flavor_config.dart';
import 'package:Flutter_BoilerPlate_With_Auth/core/helpers/language_helper.dart';
import 'package:Flutter_BoilerPlate_With_Auth/domain/BLoC/application/application_bloc.dart';
import 'package:Flutter_BoilerPlate_With_Auth/domain/BLoC/authentication/authentication_bloc.dart';
import 'package:Flutter_BoilerPlate_With_Auth/domain/BLoC/login/login_bloc.dart';
import 'package:Flutter_BoilerPlate_With_Auth/routing/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<ApplicationBloc>(lazy: false, create: (context) => ApplicationBloc()),
      BlocProvider<AuthenticationBloc>(lazy: false, create: (context) => AuthenticationBloc()),
      BlocProvider<LoginBloc>(lazy: false, create: (context) => LoginBloc()),
    ], child: AppView());
  }
}

class AppView extends StatefulWidget {
  @override
  _AppViewState createState() => _AppViewState();

  static _AppViewState? getAppViewState(BuildContext context) =>
      context.findAncestorStateOfType<_AppViewState>();
}

class _AppViewState extends State<AppView> {
  final AuthenticationContext authenticationContext = AuthenticationContext();
  final _appRouter = AppRouter();
  bool _isInitializing = true;
  Locale? _locale;

  void setLocale(Locale value) {
    setState(() {
      _locale = value;
    });
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() async {
    // await refreshLocale();

    this.setState(() {
      _isInitializing = false;
    });

    /*await Future<void>.delayed(
        const Duration(milliseconds: 100)); //delay so state can be properly updated
    await authenticationContext.restoreCurrentUser();*/
  }

  @override
  Widget build(BuildContext context) {
    var themeConfig = FlavorConfig.instance.values.themeConfig;
    var supportedLanguages = FlavorConfig.instance.supportedLanguages;
    var supportedLocales =
        supportedLanguages.map((e) => LanguageHelper.getLocaleForLanguage(e)).toList();

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.grey[800]?.withOpacity(0.75),
        statusBarIconBrightness: Brightness.light));
    return MaterialApp.router(
      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
      debugShowCheckedModeBanner: false,
      theme: themeConfig?.getThemeData(),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: supportedLocales,
      locale: _locale,
    );
  }
}
