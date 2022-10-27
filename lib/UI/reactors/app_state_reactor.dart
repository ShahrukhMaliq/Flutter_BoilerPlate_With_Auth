import 'package:Flutter_BoilerPlate_With_Auth/core/utils/toast_utils.dart';
import 'package:Flutter_BoilerPlate_With_Auth/domain/BLoC/application/application_bloc.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';

class AppStateReactor extends StatelessWidget {
  final Widget? child;

  AppStateReactor({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext buildContext) {
    return BlocListener<ApplicationBloc, ApplicationState>(
        listenWhen: (previous, current) {
          var hadConnection = previous.connectivity == ConnectivityResult.wifi ||
              previous.connectivity == ConnectivityResult.mobile;
          var noConnectionNow = current.connectivity == ConnectivityResult.none;
          return hadConnection && noConnectionNow;
        },
        listener: (context, state) {
          ToastUtils.showToast("device not connected");
        },
        child: ResponsiveWrapper.builder(child,
            maxWidth: 1920,
            minWidth: 480,
            defaultScale: true,
            breakpoints: [
              ResponsiveBreakpoint.resize(480, name: MOBILE),
              ResponsiveBreakpoint.resize(800, name: TABLET),
              ResponsiveBreakpoint.resize(1366, name: DESKTOP),
            ],
            background: Container(color: Color(0xFFF5F5F5))));
  }
}
