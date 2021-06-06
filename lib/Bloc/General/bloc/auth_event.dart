part of 'auth_bloc.dart';

abstract class AuthEvent {
}


class Login extends AuthEvent {
  final String username, password;
  Login(this.username, this.password);
}
