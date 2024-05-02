import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:jancargo_app/src/domain/dtos/meta/base_dto.dart';
import 'package:jancargo_app/src/domain/services/navigator/route_service.dart';
import '../../../core/exception.dart';

abstract class ErrorMiddleHandler {
  static handleDioError(DioError error, {StackTrace? stackTrace}) {
    print(stackTrace);
    _log(error);
    if (error.response == null) {
      print('response is nul');
      throw ServerException(message: 'Server Error');
    }
    switch (error.response!.statusCode) {
      case 400:
        {
          throw RequestException(message: BaseDto.fromJson(error.response!.data).message);
        }
      case 401:
        {
          throw UnauthorizedException(message: BaseDto.fromJson(error.response!.data).message);
        }
      case 403:
        {
          var data = error.response is Map ? error.response : json.decode(error.response.toString());

            throw ServerException();

        }
      case 404:
        {
          throw NotFoundException(message: BaseDto.fromJson(error.response!.data).message);
        }
      case 408:
        {
          throw TimeoutException(message: BaseDto.fromJson(error.response!.data).message);
        }
      case 500:
        {
          throw ServerException(message: BaseDto.fromJson(error.response!.data).message);
        }
    }
    throw ServerException(message: BaseDto.fromJson(error.response!.data).message);
  }

  static _log(DioError error) {
    print('-E-------------');
    print(error.requestOptions.uri);
    print(error.requestOptions.requestEncoder);
    print(error.requestOptions.data);
    print(error.requestOptions.headers['authorization']);
    print(error.message);
    print(error.response?.toString());
    print('---------------');
  }

  static log(Response<dynamic> res) {
    print('-R-------------');
    print(res.requestOptions.sendTimeout);
    print(res.requestOptions.uri);
    print(res.requestOptions.data);
    print(res.requestOptions.headers['authorization']);
    print(res.data);
    print(res.statusCode);
    print('---------------');
  }
}
