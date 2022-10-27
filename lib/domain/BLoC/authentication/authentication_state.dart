part of 'authentication_bloc.dart';

class AuthenticationState extends Equatable {
  AuthenticationState({this.status, this.user});
  AuthenticationState._({this.status = AuthenticationStatus.unknown, this.user});

  AuthenticationState.unknown() : this._();

  AuthenticationState.authenticated(User user)
      : this._(status: AuthenticationStatus.authenticated, user: user);

  AuthenticationState.authenticating() : this._(status: AuthenticationStatus.authenticating);

  AuthenticationState.unauthenticated() : this._(status: AuthenticationStatus.unauthenticated);

  final AuthenticationStatus? status;
  final User? user;

  @override
  List<Object?> get props => [status, user];
}
