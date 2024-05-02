part of 'input_email_cubit.dart';

@immutable
abstract class InputEmailState {}

class InputEmailInitial extends InputEmailState {}

class InputEmailFailed extends InputEmailState {
  final String message;

  InputEmailFailed(this.message);
}

class InputEmailCorrect extends InputEmailState {}