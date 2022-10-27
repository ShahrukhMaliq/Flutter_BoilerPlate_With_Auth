part of 'application_bloc.dart';

class ApplicationState extends Equatable {
  const ApplicationState({this.connectivity, this.lifecycleState});

  final ConnectivityResult? connectivity;
  final AppLifecycleState? lifecycleState;

  ApplicationState copyWith({ConnectivityResult? connectivity, AppLifecycleState? lifecycleState}) {
    return ApplicationState(
        connectivity: connectivity ?? this.connectivity,
        lifecycleState: lifecycleState ?? this.lifecycleState);
  }

  @override
  List<Object?> get props => [this.connectivity, this.lifecycleState];
}
