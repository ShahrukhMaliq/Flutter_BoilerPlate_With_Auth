import 'package:Flutter_BoilerPlate_With_Auth/UI/authentication.dart';
import 'package:Flutter_BoilerPlate_With_Auth/UI/pages/login/login_page.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
part 'router.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: AuthenticationViewPage, initial: true),
    AutoRoute(path: '/login', page: LoginPage),
  ],
)
// extend the generated private router
class AppRouter extends _$AppRouter {}
