import 'dart:async';

import 'package:Flutter_BoilerPlate_With_Auth/core/app/authentication_context.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationContext _authenticationContext = AuthenticationContext();

  LoginBloc() : super(LoginState());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is CredentialsLoginEvent) {
      yield* _mapCredentialsLoginEventToState(event, state);
    } else if (event is LogOutEvent) {
      yield* _mapLogOutEventToState(event, state);
    }
  }

  Stream<LoginState> _mapCredentialsLoginEventToState(
      CredentialsLoginEvent event, LoginState state) async* {
    try {
      await _authenticationContext.credentialsLogIn(event.login, event.password);
    } catch (err) {
      yield state.copyWith(authenticationFailed: true);
    }
  }

  Stream<LoginState> _mapLogOutEventToState(LogOutEvent event, LoginState state) async* {
    await _authenticationContext.logOut();
  }
}
