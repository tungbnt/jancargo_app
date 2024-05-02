part of 'login_cubit.dart';

@immutable
abstract class LoginState {
  const LoginState();


  copy(LoginState state) {

  }
}

class LoginInitial extends LoginState {}
class LoginLoading extends LoginState {
  LoginLoading(LoginState state) {
    super.copy(state);
  }
}
class LoginSuccess extends LoginState {
  LoginSuccess(LoginState state) {
    super.copy(state);
  }
}
class LoginFailed extends LoginState {
  LoginFailed(LoginState state) {
    super.copy(state);
  }
}
class DisableButton extends LoginState{
  DisableButton(LoginState state) {
    super.copy(state);
  }
}
class ShowButton extends LoginState{
  ShowButton(LoginState state) {
    super.copy(state);
  }
}