import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';

import '../../../../../data/object_request_api/login/login_by_google_request.dart';
import '../../../../../data/object_request_api/login_request.dart';
import '../../../../../domain/dtos/auth-model/access-token-dto.dart';
import '../../../../../domain/dtos/auth/base_user/base_user_dto.dart';
import '../../../../../domain/repositories/auth/login/base_user_res/base_user.dart';
import '../../../../../domain/repositories/auth/save-access-token.dart';
import '../../../../../domain/services/firebase_services/social_login_service.dart';
import '../../../../../general/constants/app_constants.dart';
import '../../../../../general/constants/app_enum.dart';
import '../../../../../general/constants/google_config.dart';

part 'auth_google_state.dart';

class AuthGoogleCubit extends Cubit<AuthGoogleState> {
  AuthGoogleCubit() : super(AuthGoogleInitial(state: null));

  final AuthRepo authRepo = AuthRepo();
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: GoogleConfig.scopes);

  GoogleSignInAccount? _currentUser;

  void forgotPassword() {
    // TODO: implement forgotPassword
  }

  void login() async {
    emit(AuthGoogleLoading(state: state));
    try {
      _googleSignIn.signIn().then((value) {
        _currentUser = value;
        return value?.authentication.then((googleKey) {
          final LoginByGoogleRequest loginByGoogleRequest =
              LoginByGoogleRequest(
            googleId: googleKey.idToken,
            googleToken: googleKey.idToken,
            oAuthEnum: 'google:android',
            email: _currentUser!.email,
            url: "https://jancargo.com/",
            typeMode: "jancargo",
            next: "/account",
          );
          emit(AuthGoogleLoading(state: state));
          authRepo
              .loginByGoogle(loginByGoogleRequest: loginByGoogleRequest)
              .then(
                (value) => value.fold(
                  (left) => emit(
                      AuthGoogleFailed(state: state)..message = left.message),
                  (right) async {
                    print('vào 3');
                    authRepo
                        .loginEmail(
                            loginRequest: LoginRequest(
                          username: _currentUser!.email,
                          grantType: 'password',
                          scopes: 'openid profile full_access offline_access',
                          clientId: 'jancargo-client-mobile-web',
                          clientSecret: 'jancargo@12354\$',
                          provider: 'google',
                          tokenId: googleKey.idToken,
                        ))
                        .then(
                          (value) => value.fold(
                            (left) {
                              return emit(AuthGoogleFailed(state: state));
                            },
                            (right) async {
                              _saveToken(right);
                              emit(AuthGoogleSuccess(state: state));
                            },
                          ),
                        );
                  },
                ),
              );
        });
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'unknown') {}
    } catch (e) {
      emit(AuthGoogleFailed(state: state)
        ..message = 'Đăng nhập bằng Google thất bại.');
    }
  }


  void _saveToken(BaseUserDto dto)async{
    await SaveAccessToken()
        .put(AccessTokenDto(dto.accessToken));
    Box hiveBox = Hive.box(AppConstants.APP_NAME_ID);
    hiveBox.put(AppConstants.REFRESH_TOKEN, dto.refreshToken);
  }
  void logout() {
    _googleSignIn.disconnect();
    _googleSignIn.signOut();
    _currentUser = null;
  }

  void register() {
    emit(AuthGoogleLoading(state: state));
    _googleSignIn.signIn().asStream().listen((event) {
      _currentUser = event;
    }).onDone(() async {
      if (_currentUser != null) {
        GoogleSignInAuthentication googleSignInAuthentication =
            await _currentUser!.authentication;
        String? googleToken = googleSignInAuthentication.accessToken;
        final LoginByGoogleRequest loginByGoogleRequest = LoginByGoogleRequest(
          googleId: _currentUser!.id,
          googleToken: googleToken,
          // oAuthEnum: OAuthEnum.google,
          email: _currentUser!.email,
        );
        emit(AuthGoogleLoading(state: null));
        // authRepo.loginByGoogle(loginByGoogleRequest: loginByGoogleRequest).then(
        //       (value) => value.fold(
        //         (left) => emit(AuthGoogleFailed(state: state)..message = left.message),
        //         (right) => emit(AuthGoogleSuccess(state: null)),
        //   ),
        // );
      } else {
        emit(AuthGoogleFailed(state: state)
          ..message = 'Đăng ký bằng Google thất bại.');
      }
    });
  }

  void resetState() {
    _googleSignIn.disconnect();
    _googleSignIn.signOut();
    _currentUser = null;
    emit(AuthGoogleInitial(state: null));
  }
}
