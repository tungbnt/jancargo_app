import 'dart:io';

import 'package:dio/dio.dart' as dios;
import 'package:injectable/injectable.dart';
import 'package:jancargo_app/src/domain/dtos/user/deleted_account/deleted_account_dto.dart';

import '../../../../core/exception.dart';
import '../../../../domain/dtos/oder_management/oder_management_dto.dart';
import '../../../../domain/dtos/user/bidding_user/bidding_user_dto.dart';
import '../../../../domain/dtos/user/exchange_price/exchange_price_dto.dart';
import '../../../../domain/dtos/user/session/session_dto.dart';
import '../../../object_request_api/oder_management/oder_management_request.dart';
import '../../../remote/api-endpoint.dart';
import '../../../remote/api_endpoint/api_end_point_factory.dart';
import '../../../remote/middle-handler/error-handler.dart';
import '../../base/base_datasource.dart';

@Singleton()
class OderManagementSource extends BaseDateSource {

  Future<ManagementDto> oderManagement({required OderManagementRequest request}) async {
    var response = await appClient.dioAuth(getLocalAccessToken().accessToken!)
        .get(
      ApiEndPointFactory.jancargoServerEndPoint.getUrlQueryApi(
          AppPath.oderManagement),
      queryParameters: request.toJson()..removeWhere((key, value) => value == null),
    )
        .onError((dios.DioError error, stackTrace) =>
        ErrorMiddleHandler.handleDioError(error));
    ErrorMiddleHandler.log(response);

    if (response.statusCode == HttpStatus.ok) {
      ManagementDto dto = ManagementDto.fromJson(response.data);
      return dto;
    }

    throw ServerException();
  }

  Future<BiddingDto> userBidding() async {
    var response = await appClient.dioAuth(getLocalAccessToken().accessToken!)
        .get(
      ApiEndPointFactory.jancargoServerEndPoint.getUrlQueryApi(
          AppPath.bidding),
    )
        .onError((dios.DioError error, stackTrace) =>
        ErrorMiddleHandler.handleDioError(error));
    ErrorMiddleHandler.log(response);

    if (response.statusCode == HttpStatus.ok) {
      BiddingDto dto = BiddingDto.fromJson(response.data);
      return dto;
    }

    throw ServerException();
  }
  Future<ExchangeDto> exchangePrice() async {
    var response = await appClient.dioAuth(getLocalAccessToken().accessToken!)
        .get(
      ApiEndPointFactory.jancargoServerEndPoint.getUrlQueryApi(
          AppPath.exchangePrice),
    )
        .onError((dios.DioError error, stackTrace) =>
        ErrorMiddleHandler.handleDioError(error));
    ErrorMiddleHandler.log(response);

    if (response.statusCode == HttpStatus.ok) {
      ExchangeDto dto = ExchangeDto.fromJson(response.data);
      return dto;
    }

    throw ServerException();
  }

  Future<SessionDto> sessionUser() async {
    var response = await appClient.dioAuth(getLocalAccessToken().accessToken!)
        .get(
      ApiEndPointFactory.jancargoServerEndPoint.getUrlQueryApi(
          AppPath.session),
    )
        .onError((dios.DioError error, stackTrace) =>
        ErrorMiddleHandler.handleDioError(error));
    ErrorMiddleHandler.log(response);

    if (response.statusCode == HttpStatus.ok) {
      SessionDto dto = SessionDto.fromJson(response.data);
      return dto;
    }

    throw ServerException();
  }
  Future<DeletedAccountDto> deletedMyAccount() async {
    var response = await appClient.dioAuth(getLocalAccessToken().accessToken!)
        .delete(
      ApiEndPointFactory.jancargoServerEndPoint.getUrlQueryApi(
          AppPath.deletedMyAccount),
    )
        .onError((dios.DioError error, stackTrace) =>
        ErrorMiddleHandler.handleDioError(error));
    ErrorMiddleHandler.log(response);

    if (response.statusCode == HttpStatus.ok) {
      DeletedAccountDto dto = DeletedAccountDto.fromJson(response.data);
      return dto;
    }

    throw ServerException();
  }
}