part of 'login_bloc.dart';

class LoginState extends Equatable {
  LoginState({this.isPreparing = false, this.authenticationFailed});

  final bool? isPreparing;
  final bool? authenticationFailed;

  LoginState copyWith({bool? isPreparing, bool? authenticationFailed}) {
    return LoginState(isPreparing: isPreparing ?? this.isPreparing, authenticationFailed: authenticationFailed);
  }

  @override
  List<Object?> get props => [isPreparing, authenticationFailed];
}
