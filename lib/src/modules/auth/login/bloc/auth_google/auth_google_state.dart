part of 'auth_google_cubit.dart';

@immutable
abstract class AuthGoogleState {
  AuthGoogleState({required AuthGoogleState? state}) {
    message = state?.message;
  }

  String? message;
  copy(AuthGoogleState state) {

  }
}

class AuthGoogleInitial extends AuthGoogleState {
  AuthGoogleInitial({required super.state});
}
class AuthGoogleLoading extends AuthGoogleState {
  AuthGoogleLoading({required super.state});
}class AuthGoogleSuccess extends AuthGoogleState {
  AuthGoogleSuccess({required super.state});
}
class AuthGoogleFailed extends AuthGoogleState {
  AuthGoogleFailed({required super.state});
}
