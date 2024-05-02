import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../../../../data/object_request_api/request_change/request_change_pass.dart';
import '../../../../domain/dtos/auth/verify_otp/verify_otp_dto.dart';
import '../../../../domain/repositories/auth/login/base_user_res/base_user.dart';

part 'forget_pass_state.dart';

@singleton
class ForgetPassCubit extends Cubit<ForgetPassState> {
  ForgetPassCubit() : super(ForgetPassInitial(state: null));
  final PageController pageController = PageController(initialPage: 0);
  final TextEditingController pinController = TextEditingController();
  final TextEditingController inputEmail = TextEditingController();
  final TextEditingController inputPass = TextEditingController();
  final TextEditingController inputPassAgain = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final formKeyInput = GlobalKey<FormState>();
  final focusNode = FocusNode();

  String tokenOtp = '';

  final AuthRepo authRepo = AuthRepo();

  Future<void> getOtp() async {
    emit(ForgetPassLoading(state: null));
    authRepo.getOtp(request: RequestForgetPass(phoneOrEmail: inputEmail.text, step: 'request_code',))
        .then((value) => value.fold(
            (left) => emit(ForgetPassFailed(state: null)),
            (right) async {
              emit(ForgetPassSuccess(state: null));
            },
          ),
        );
  }

  Future<void> resendOtp() async {
    emit(ForgetPassLoading(state: null));
    authRepo.getOtp(request: RequestForgetPass(phoneOrEmail: inputEmail.text, step: 'request_code',))
        .then((value) => value.fold(
            (left) => emit(ForgetPassFailed(state: null)),
            (right) async {
              emit(ForgetPassResendOtpSuccess(state: null));
            },
          ),
        );
  }
  Future<void> verifyOtp() async {
    emit(ForgetPassLoading(state: null));
    authRepo.verifyOtp(inputEmail.text,pinController.text,)
        .then((value) => value.fold(
          (left) => emit(ForgetPassFailed(state: null)),
          (right) async {
            if(right.success == false){
              return emit(ForgetPassFailed(state: null));
            }
            //
            tokenOtp = right.token;
        emit(ForgetPassVerifyOtpSuccess(state: state)..dto = right);
      },
    ),
    );
  }
  Future<void> resetPass() async {
    emit(ForgetPassLoading(state: null));
    authRepo.resetPass(inputEmail.text,tokenOtp,inputPassAgain.text)
        .then((value) => value.fold(
          (left) => emit(ForgetPassFailed(state: null)),
          (right) async {
        emit(ForgetPassSuccessPassOtpSuccess(state: null));
      },
    ),
    );
  }
}
