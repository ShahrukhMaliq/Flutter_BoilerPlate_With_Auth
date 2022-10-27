import 'dart:async';
import 'dart:ui';

import 'package:Flutter_BoilerPlate_With_Auth/core/app/app_lifecycle_context.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity/connectivity.dart';

part 'application_event.dart';
part 'application_state.dart';

class ApplicationBloc extends Bloc<ApplicationEvent, ApplicationState> {
  StreamSubscription<ConnectivityResult>? _connectivityResultStream;
  AppLifecycleContext appLifecycleContext = AppLifecycleContext();

  ApplicationBloc() : super(ApplicationState()) {
    _init();
    this.appLifecycleContext = appLifecycleContext;
  }

  void _init() {
    var connectivity = Connectivity();

    _connectivityResultStream =
        connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      add(ConnectivityChangedEvent(result));
    });
  }

  @override
  Stream<ApplicationState> mapEventToState(ApplicationEvent event) async* {
    if (event is ConnectivityChangedEvent) {
      yield* _mapConnectivityChangedEvent(event, state);
    } else if (event is AppLifecycleChangedEvent) {
      yield* _mapAppLifecycleChangedEventToState(event, state);
    }
  }

  Stream<ApplicationState> _mapConnectivityChangedEvent(
      ConnectivityChangedEvent event, ApplicationState state) async* {
    yield state.copyWith(connectivity: event.connectivityResult);
  }

  Stream<ApplicationState> _mapAppLifecycleChangedEventToState(
      AppLifecycleChangedEvent event, ApplicationState state) async* {
    appLifecycleContext.add(event.lifecycleState);

    if (event.lifecycleState == AppLifecycleState.inactive ||
        event.lifecycleState == AppLifecycleState.paused) {
      //await authenticationContext.persistClient();
    }

    yield state.copyWith(lifecycleState: event.lifecycleState);
  }

  void dispose() {
    _connectivityResultStream?.cancel();
  }
}
