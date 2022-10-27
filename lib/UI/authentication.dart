import 'package:Flutter_BoilerPlate_With_Auth/UI/pages/common/view/splash_page.dart';
import 'package:Flutter_BoilerPlate_With_Auth/UI/reactors/app_authentication_reactor.dart';
import 'package:Flutter_BoilerPlate_With_Auth/UI/reactors/app_state_reactor.dart';
import 'package:flutter/material.dart';

class AuthenticationViewPage extends StatefulWidget {
  @override
  _AuthenticationViewPageState createState() => _AuthenticationViewPageState();

  static _AuthenticationViewPageState? getAppViewState(BuildContext context) =>
      context.findAncestorStateOfType<_AuthenticationViewPageState>();
}

class _AuthenticationViewPageState extends State<AuthenticationViewPage> {
  bool _isInitializing = true;

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
  }

  @override
  Widget build(BuildContext context) {
    if (_isInitializing) {
      return SplashPage();
    }

    return AppStateReactor(child: AppAuthenticationReactor());
  }
}
