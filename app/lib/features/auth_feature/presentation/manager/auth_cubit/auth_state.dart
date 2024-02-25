part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}


class LoginInitial extends AuthState {}

class LoginSuccess extends AuthState {}

class LoginLoading extends AuthState {}

class LoginFailure extends AuthState {
  final String errorMsg;

  LoginFailure({required this.errorMsg});
}

class RegisterInitial extends AuthState {}

class RegisterSuccess extends AuthState {}

class RegisterLoading extends AuthState {}

class RegisterFailure extends AuthState {
  final String errorMsg;

  RegisterFailure({required this.errorMsg});
}

class LogoutInitial extends AuthState {}

class LogoutSuccess extends AuthState {}

class LogoutLoading extends AuthState {}

class LogoutFailure extends AuthState {
  final String errorMsg;

  LogoutFailure({required this.errorMsg});
}
