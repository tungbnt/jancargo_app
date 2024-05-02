import 'dart:io';

import 'package:dio/dio.dart' as dios;
import 'package:injectable/injectable.dart';
import 'package:jancargo_app/src/data/object_request_api/auction_manager/auction_manager_request.dart';
import 'package:jancargo_app/src/domain/dtos/auction_manager/auction_manager_dto.dart';
import 'package:jancargo_app/src/domain/dtos/detail_product/detail/detail_dto.dart';

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
class AuctionManagementSource extends BaseDateSource {

  Future<AuctionManagerDto> oderManagement({required AuctionManagementRequest request}) async {
    var response = await appClient.dioAuth(getLocalAccessToken().accessToken!)
        .get(
      ApiEndPointFactory.jancargoServerEndPoint.getUrlQueryApi(
          AppPath.auctionManagement),
      queryParameters: request.toJson()..removeWhere((key, value) => value == null),
    )
        .onError((dios.DioError error, stackTrace) =>
        ErrorMiddleHandler.handleDioError(error));
    ErrorMiddleHandler.log(response);

    if (response.statusCode == HttpStatus.ok) {
      AuctionManagerDto dto = AuctionManagerDto.fromJson(response.data);
      return dto;
    }

    throw ServerException();
  }
  Future<DetailDto> updateItemAuction(String code) async {
    var response = await appClient.dioNonAuth()
        .get(
      ApiEndPointFactory.jancargoServerEndPoint.getUrlQueryApi(
          "${AppPath.infoProductAuction}$code"),
    )
        .onError((dios.DioError error, stackTrace) =>
        ErrorMiddleHandler.handleDioError(error));
    ErrorMiddleHandler.log(response);

    if (response.statusCode == HttpStatus.ok) {
      DetailDto dto = DetailDto.fromJson(response.data["data"]);
      return dto;
    }

    throw ServerException();
  }

}