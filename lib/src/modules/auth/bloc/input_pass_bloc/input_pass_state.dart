part of 'input_pass_cubit.dart';

@immutable
abstract class InputPasswordState {}

class InputPasswordInitial extends InputPasswordState {}

class InputPasswordFailed extends InputPasswordState {
  final String message;

  InputPasswordFailed(this.message);
}

class InputPasswordCorrect extends InputPasswordState {}