part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthSuccessState extends AuthState {}

class AuthLogoutState extends AuthState {}

class AuthFailedState extends AuthState {
  final String? message;
  final int? code;

  AuthFailedState({this.message, this.code});
}
