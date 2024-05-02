import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../../../../data/object_request_api/login_request.dart';
import '../../../../domain/dtos/auth-model/access-token-dto.dart';
import '../../../../domain/repositories/auth/login/base_user_res/base_user.dart';
import '../../../../domain/repositories/auth/save-access-token.dart';
import '../../../../general/constants/app_constants.dart';

part 'login_state.dart';
@singleton
class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  final TextEditingController inputEmail = TextEditingController();
  final TextEditingController inputPass = TextEditingController();
  final formKey = GlobalKey<FormState>();



  final AuthRepo authRepo = AuthRepo();

  void forgotPassword() {}

  Future<void> login() async {
    emit(LoginLoading(state));
    authRepo
        .loginEmail(
        loginRequest: LoginRequest(
          username: inputEmail.text,
          password: inputPass.text,
          grantType: 'password',
            scopes: 'openid profile full_access offline_access',
          clientId: 'jancargo-client-mobile-web',
          clientSecret: 'jancargo@12354\$',
        ))
        .then(
          (value) => value.fold(
            (left) {
             return emit(LoginFailed(state));
            },
            (right) async {
         await _saveToken(right.accessToken!,right.refreshToken!);
          return emit(LoginSuccess(state));
        },
      ),
    );
  }

  void logout() {}

  Future<void> _saveToken(String token,String refresh) async {
    await SaveAccessToken().put(AccessTokenDto(token));
    Box hiveBox = Hive.box(AppConstants.APP_NAME_ID);
    hiveBox.put(AppConstants.REFRESH_TOKEN, refresh);
  }


  void register() {
    // TODO: implement register
  }
  void disableButton() {
    emit(DisableButton(state));
  }
  void showButton() {
    emit(ShowButton(state));
  }

}
