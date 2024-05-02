import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

import '../../../../domain/services/utils/validation.dart';

part 'input_pass_state.dart';

class InputPasswordCubit extends Cubit<InputPasswordState> {
  InputPasswordCubit() : super(InputPasswordInitial());
  final TextEditingController inputPassword = TextEditingController();

  void validatePassword({String? password}) {
    if (password == null || password.isEmpty) {
      emit(InputPasswordInitial());
      return;
    }
    // if (!Validation.validateEmail(email: password)) {
    //   emit(InputPasswordFailed('Mật khẩu phải từ 6 đến 30 kí tự'));
    //   return;
    // }
    emit(InputPasswordCorrect());
  }
}
