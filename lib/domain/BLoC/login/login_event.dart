part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

/// Event fired when user clicks on 'Credentials Login' in Welcome page
class CredentialsLoginEvent extends LoginEvent {
  CredentialsLoginEvent(this.login, this.password);

  final String login;
  final String password;

  @override
  List<Object> get props => [this.login, this.password];
}

class LogOutEvent extends LoginEvent {
  const LogOutEvent();
}
