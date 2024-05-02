import 'dart:convert' as convert;
import 'dart:io';

import 'package:dio/dio.dart' as dios;
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:jancargo_app/src/data/object_request_api/register/register_request.dart';

import '../../../core/exception.dart';
import '../../../domain/dtos/auth-model/access-token-dto.dart';
import '../../../domain/dtos/auth/base_user/base_user_dto.dart';
import '../../../domain/dtos/auth/verify_otp/verify_otp_dto.dart';
import '../../../general/constants/app_constants.dart';
import '../../object_request_api/login/login_by_google_request.dart';
import '../../object_request_api/login_request.dart';
import '../../object_request_api/request_change/request_change_pass.dart';
import '../../remote/api-endpoint.dart';
import '../../remote/api_endpoint/api_end_point_factory.dart';
import '../../remote/middle-handler/error-handler.dart';
import '../base/base_datasource.dart';

@Singleton()
class AuthSource extends BaseDateSource {
  @override
  void saveAccessToken(AccessTokenDto accessToken) {
    hiveBox.put(AppConstants.ACCESS_TOKEN, accessToken.accessToken);
  }

  void deleteLocalAccessToken() {
    hiveBox.delete(AppConstants.ACCESS_TOKEN);
  }

  Map<String, dynamic> formMap = {
    "name": "confirmPassword",
    "surname": "confirmPassword",
    "mail": "confirmPassword",
    "password": "confirmPassword",
    "birth": "confirmPassword",
    "phone": "confirmPassword",
    "confirmPassword": "confirmPassword"
  };

  Future<BaseUserDto> loginToken({required LoginRequest loginRequest}) async {
    var response = await appClient
        .dioNonAuth()
        .post("https://id.jancargo.com/${AppPath.login}",
            data: loginRequest.toJson(),
            options: dios.Options(headers: {
              'Content-Type': 'application/x-www-form-urlencoded',
            }))
        .onError((dios.DioError error, stackTrace) =>
            ErrorMiddleHandler.handleDioError(error));
    ErrorMiddleHandler.log(response);

    if (response.statusCode == HttpStatus.ok) {
      BaseUserDto baseUserDto = BaseUserDto.fromJson(response.data);
      return baseUserDto;
    }

    throw ServerException();
  }

  Future<bool> loginByGoogle(
      {LoginByGoogleRequest? loginByGoogleRequest}) async {
    if (loginByGoogleRequest == null) {
      throw ServerException();
    }
    var response = await appClient
        .dioNonAuth()
        .post(
      ApiEndPointFactory.jancargoServerEndPoint
          .getUrlQueryApi(AppPath.loginSocial),
      data: loginByGoogleRequest.toJson(),
    )
        .onError((dios.DioError error, stackTrace) =>
        ErrorMiddleHandler.handleDioError(error));
    ErrorMiddleHandler.log(response);

    if (response.statusCode == HttpStatus.ok) {
      return true;
    }

    throw ServerException();
  }


  Future<BaseUserDto> refreshToken() async {
    Box hiveBox = Hive.box(AppConstants.APP_NAME_ID);
    final refresh = hiveBox.get(AppConstants.REFRESH_TOKEN);
    var response = await appClient
        .dioNonAuth()
        .post("https://id.jancargo.com/${AppPath.login}",
        data: {"client_id": "jancargo-client-mobile-web","grant_type": "refresh_token","refresh_token":refresh,"client_secret": "jancargo@12354\$"},

        options: dios.Options(headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        }))
        .onError((dios.DioError error, stackTrace) =>
        ErrorMiddleHandler.handleDioError(error));
    ErrorMiddleHandler.log(response);

    if (response.statusCode == HttpStatus.ok) {
      BaseUserDto baseUserDto = BaseUserDto.fromJson(response.data);
      return baseUserDto;
    }

    throw ServerException();
  }

  Future<BaseUserDto> register(
      {required RegisterRequest registerRequest}) async {
    var response = await appClient
        .dioNonAuth()
        .post("https://id.jancargo.com/${AppPath.login}",
            data: registerRequest.toJson())
        .onError((dios.DioError error, stackTrace) =>
            ErrorMiddleHandler.handleDioError(error));
    ErrorMiddleHandler.log(response);

    if (response.statusCode == HttpStatus.ok) {
      BaseUserDto baseUserDto = BaseUserDto.fromJson(response.data);
      return baseUserDto;
    }

    throw ServerException();
  }

  //forget pass
  Future<bool> getOtp({required RequestForgetPass request}) async {
    var response = await appClient
        .dioNonAuth()
        .post("https://id.jancargo.com/${AppPath.requestChangePass}",
            data: request.toJson())
        .onError((dios.DioError error, stackTrace) =>
            ErrorMiddleHandler.handleDioError(error));
    ErrorMiddleHandler.log(response);

    if (response.statusCode == HttpStatus.ok) {
      var isSuccess = response.data["message"] == null ? true : false;
      return isSuccess;
    }
    throw ServerException();
  }

  Future<bool> resetPass(
      String phoneOrEmail, String securityCode, String newPassword) async {
    var response = await appClient
        .dioNonAuth()
        .post("https://id.jancargo.com/${AppPath.resetPass}", data: {
      "phoneOrEmail": phoneOrEmail,
      "securityCode": securityCode,
      "newPassword": newPassword
    }).onError((dios.DioError error, stackTrace) =>
            ErrorMiddleHandler.handleDioError(error));
    ErrorMiddleHandler.log(response);

    if (response.statusCode == HttpStatus.ok) {
      var isSuccess = response.data["message"] == null ? true : false;
      return isSuccess;
    }
    throw ServerException();
  }

  Future<VerifyOtpDto> verifyOtp(String phoneOrEmail, String otp) async {
    var response = await appClient
        .dioNonAuth()
        .post("https://id.jancargo.com/${AppPath.verifyOtp}", data: {
      "phoneOrEmail": phoneOrEmail,
      "otp": otp
    }).onError((dios.DioError error, stackTrace) =>
            ErrorMiddleHandler.handleDioError(error));
    ErrorMiddleHandler.log(response);

    if (response.statusCode == HttpStatus.ok) {
      var dto = VerifyOtpDto.fromJson(response.data);
      return dto;
    }
    throw ServerException();
  }
}
