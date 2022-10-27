import 'package:Flutter_BoilerPlate_With_Auth/UI/app_consts.dart';
import 'package:Flutter_BoilerPlate_With_Auth/UI/pages/login/login_page.dart';
import 'package:Flutter_BoilerPlate_With_Auth/core/app/authentication_context.dart';
import 'package:Flutter_BoilerPlate_With_Auth/core/enums/authentication_status.dart';
import 'package:Flutter_BoilerPlate_With_Auth/domain/BLoC/authentication/authentication_bloc.dart';
import 'package:Flutter_BoilerPlate_With_Auth/routing/router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppAuthenticationReactor extends StatelessWidget {
  final Widget? child;
  AppAuthenticationReactor({Key? key, this.child}) : super(key: key);
  get language => null;

  @override
  Widget build(BuildContext buildContext) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) async {
          switch (state.status) {
            case AuthenticationStatus.authenticated:
              break;
            case AuthenticationStatus.unauthenticated:
              AutoRouter.of(context).push(LoginRoute());
              break;
            default:
              break;
          }
        },
        child: LoginPage());
  }
}
