part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class LoginEvent extends AuthEvent {
  final FirebaseAuth auth;
  final String email;
  final String password;

  LoginEvent({
    required this.auth,
    required this.email,
    required this.password,
  });
}

class RegisterEvent extends AuthEvent {
  final FirebaseAuth auth;
  final String email;
  final String password;

  RegisterEvent({
    required this.auth,
    required this.email,
    required this.password,
  });
}
