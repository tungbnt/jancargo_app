import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:jancargo_app/src/data/object_request_api/register/register_request.dart';
import 'package:meta/meta.dart';

import '../../../../domain/dtos/auth-model/access-token-dto.dart';
import '../../../../domain/repositories/auth/login/base_user_res/base_user.dart';
import '../../../../domain/repositories/auth/save-access-token.dart';

part 'sign_u_state.dart';

@singleton
class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());

  final TextEditingController inputName = TextEditingController();
  final TextEditingController inputEmail = TextEditingController();
  final TextEditingController inputPhone = TextEditingController();
  final TextEditingController inputPass = TextEditingController();
  final TextEditingController inputPassAgain = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final AuthRepo authRepo = AuthRepo();


  // Future<void> login() async {
  //   emit(SignUpLoading(state));
  //   authRepo
  //       .register(
  //       registerRequest: RegisterRequest(
  //        shortName: inputName.text,
  //         email: inputEmail.text,
  //         phone: inputPhone.text,
  //         password: inputPass.text,
  //         confirmPassword: inputPassAgain.text,
  //         typeMode: 'jancargo',
  //         captcha: ''
  //       ))
  //       .then(
  //         (value) => value.fold(
  //           (left) => emit(SignUpFailed(state)),
  //           (right) async {
  //         _saveToken(right.accessToken!);
  //         emit(SignUpSuccess(state));
  //       },
  //     ),
  //   );
  // }

  void _saveToken(String token) async {
    await SaveAccessToken().put(AccessTokenDto(token));
  }
  void clear(){
    inputName.clear();
    inputEmail.clear();
    inputPhone.clear();
    inputPass.clear();
    inputPassAgain.clear();
  }

}
