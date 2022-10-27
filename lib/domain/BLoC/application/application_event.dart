part of 'application_bloc.dart';

abstract class ApplicationEvent extends Equatable {
  const ApplicationEvent();

  @override
  List<Object> get props => [];
}

class ConnectivityChangedEvent extends ApplicationEvent {
  const ConnectivityChangedEvent(this.connectivityResult);

  final ConnectivityResult connectivityResult;

  @override
  List<Object> get props => [connectivityResult];
}

class AppLifecycleChangedEvent extends ApplicationEvent {
  const AppLifecycleChangedEvent(this.lifecycleState);

  final AppLifecycleState lifecycleState;

  @override
  List<Object> get props => [lifecycleState];
}
