part of 'auth_bloc.dart';

abstract class AuthState {
}

class AuthInitial extends AuthState {
}

class LoginSuccessfully extends AuthState {
}

class LoginError extends AuthState {
  final String error;
  LoginError(this.error);
}

class Loading extends AuthState {
}
