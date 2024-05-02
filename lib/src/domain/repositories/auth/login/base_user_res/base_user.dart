import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../../data/datasource/auth/auth_source.dart';
import '../../../../../data/object_request_api/login/login_by_google_request.dart';
import '../../../../../data/object_request_api/login_request.dart';
import '../../../../../data/object_request_api/register/register_request.dart';
import '../../../../../data/object_request_api/request_change/request_change_pass.dart';
import '../../../../../data/remote/middle-handler/failure.dart';
import '../../../../../data/remote/middle-handler/result-handler.dart';
import '../../../../../general/inject_dependencies/inject_dependencies.dart';
import '../../../../dtos/auth/base_user/base_user_dto.dart';
import '../../../../dtos/auth/verify_otp/verify_otp_dto.dart';

@Singleton()
class AuthRepo {
  AuthSource get _dataSource => getIt<AuthSource>();

  Future<Either<Failure, BaseUserDto>> loginEmail(
      {required LoginRequest loginRequest}) async {
    return ResultMiddleHandler.checkResult(() async {
      return await _dataSource.loginToken(loginRequest: loginRequest);
    });
  }

  Future<Either<Failure, bool>> loginByGoogle(
      {LoginByGoogleRequest? loginByGoogleRequest}) async {
    return await ResultMiddleHandler.checkResult(() async {
      return await _dataSource.loginByGoogle(
          loginByGoogleRequest: loginByGoogleRequest);
    });
  }

  Future<Either<Failure, BaseUserDto>> refreshToken(
     ) async {
    return ResultMiddleHandler.checkResult(() async {
      return await _dataSource.refreshToken();
    });
  }

  Future<Either<Failure, BaseUserDto>> register(
      {required RegisterRequest registerRequest}) async {
    return ResultMiddleHandler.checkResult(() async {
      return await _dataSource.register(registerRequest: registerRequest);
    });
  }

  Future<Either<Failure, bool>> getOtp(
      {required RequestForgetPass request}) async {
    return ResultMiddleHandler.checkResult(() async {
      return await _dataSource.getOtp(request: request);
    });
  }
  Future<Either<Failure, bool>> resetPass(
      String phoneOrEmail,String securityCode,String newPassword) async {
    return ResultMiddleHandler.checkResult(() async {
      return await _dataSource.resetPass( phoneOrEmail, securityCode, newPassword);
    });
  }
  Future<Either<Failure, VerifyOtpDto>> verifyOtp(
      String phoneOrEmail,String otp) async {
    return ResultMiddleHandler.checkResult(() async {
      return await _dataSource.verifyOtp(phoneOrEmail,otp);
    });
  }
}
