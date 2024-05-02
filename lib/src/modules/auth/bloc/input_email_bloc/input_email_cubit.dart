import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../../../domain/services/utils/validation.dart';

part 'input_email_state.dart';

class InputEmailCubit extends Cubit<InputEmailState> {
  InputEmailCubit() : super(InputEmailInitial());
  final TextEditingController inputEmail = TextEditingController();

  void validateEmail({String? email}) {
    late final RegExp _numberRegex = RegExp(r'\d+');

    if (email == null || email.isEmpty) {
      emit(InputEmailInitial());
      return;
    }
    if (email.contains(_numberRegex) == true) {
      var textValidate = Validation.validatorPhone( email);
        emit(InputEmailFailed(textValidate!));
        return;

    }
    if(!email.contains(_numberRegex)){
      var textValidate = Validation.validateEmail(email: email);
      emit(InputEmailFailed(textValidate!));
      return;
    }

    emit(InputEmailCorrect());
  }
}
