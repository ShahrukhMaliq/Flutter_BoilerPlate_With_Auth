// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

part of 'router.dart';

class _$AppRouter extends RootStackRouter {
  _$AppRouter([GlobalKey<NavigatorState>? navigatorKey]) : super(navigatorKey);

  @override
  final Map<String, PageFactory> pagesMap = {
    AuthenticationViewRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: AuthenticationViewPage(),
      );
    },
    LoginRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: LoginPage(),
      );
    },
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig(
          AuthenticationViewRoute.name,
          path: '/',
        ),
        RouteConfig(
          LoginRoute.name,
          path: '/login',
        ),
      ];
}

/// generated route for
/// [AuthenticationViewPage]
class AuthenticationViewRoute extends PageRouteInfo<void> {
  const AuthenticationViewRoute()
      : super(
          AuthenticationViewRoute.name,
          path: '/',
        );

  static const String name = 'AuthenticationViewRoute';
}

/// generated route for
/// [LoginPage]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute()
      : super(
          LoginRoute.name,
          path: '/login',
        );

  static const String name = 'LoginRoute';
}
