part of 'auth_bloc.dart';

abstract class AuthState {}

final class AuthInitial extends AuthState {}

final class LoginLoadingState extends AuthState {}

final class LoginSuccessState extends AuthState {}

final class LoginFailureState extends AuthState {
  final String err;

  LoginFailureState({required this.err});
}

final class RegisterLoadingState extends AuthState {}

final class RegisterSuccessState extends AuthState {}

final class RegisterFailureState extends AuthState {
  final String err;

  RegisterFailureState({required this.err});
}

final class SignOutLoadingState extends AuthState {}

final class SignOutSuccessState extends AuthState {}
