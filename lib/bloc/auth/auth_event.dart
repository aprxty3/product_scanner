part of 'auth_bloc.dart';

abstract class AuthEvent {}

class AuthEventLogin extends AuthEvent {
  String? email;
  String? password;
  AuthEventLogin({this.email, this.password});
}

class AuthEventLogout extends AuthEvent {}
