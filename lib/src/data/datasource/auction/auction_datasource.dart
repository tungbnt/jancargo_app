import 'dart:io';

import 'package:dio/dio.dart' as dios;
import 'package:injectable/injectable.dart';

import '../../../core/exception.dart';
import '../../../domain/dtos/auction/category_home/category_home_dto.dart';
import '../../../domain/dtos/auction/category_product/category_product_dto.dart';
import '../../../domain/dtos/auction/price/price_dto.dart';
import '../../../domain/dtos/flash_sale/amazon_js/amazon_js_dto.dart';
import '../../../domain/dtos/search/search_popular/search_popular_dto.dart';
import '../../../domain/dtos/user/tran_dto/tran_dto.dart';
import '../../object_request_api/auction/auction_off/auction_off_request.dart';
import '../../object_request_api/auction/price_auction/price_auction_request.dart';
import '../../remote/api-endpoint.dart';
import '../../remote/api_endpoint/api_end_point_factory.dart';
import '../../remote/middle-handler/error-handler.dart';
import '../base/base_datasource.dart';

@Singleton()
class AuctionDataSource extends BaseDateSource {
  Future<PriceDto> getAuctionPrice({required PriceRequest request}) async {
    var response = await appClient
        .dioAuth(getLocalAccessToken().accessToken!)
        .post(
          ApiEndPointFactory.jancargoServerEndPoint
              .getUrlQueryApi(AppPath.calculatePrice),
          data: request.toJson(),
        )
        .onError((dios.DioError error, stackTrace) =>
            ErrorMiddleHandler.handleDioError(error));
    ErrorMiddleHandler.log(response);

    if (response.statusCode == HttpStatus.ok) {
       PriceDto dto = PriceDto.fromJson(response.data);
      return dto;
    }

    throw ServerException();
  }

  Future<TranDto> getTran() async {
    var response = await appClient
        .dioAuth(getLocalAccessToken().accessToken!)
        .get(
          ApiEndPointFactory.jancargoServerEndPoint
              .getUrlQueryApi(AppPath.getTran),
        )
        .onError((dios.DioError error, stackTrace) =>
            ErrorMiddleHandler.handleDioError(error));
    ErrorMiddleHandler.log(response);

    if (response.statusCode == HttpStatus.ok) {
      TranDto dto = TranDto.fromJson(response.data["data"]);
      return dto;
    }

    throw ServerException();
  }

  Future<int> getPriceAuction(String idPro) async {
    var response = await appClient
        .dioAuth(getLocalAccessToken().accessToken!)
        .get(
      ApiEndPointFactory.jancargoServerEndPoint
          .getUrlQueryApi('${AppPath.getPriceAuction}/$idPro'),

    )
        .onError((dios.DioError error, stackTrace) =>
        ErrorMiddleHandler.handleDioError(error));
    ErrorMiddleHandler.log(response);

    if (response.statusCode == HttpStatus.ok) {
      int dto = response.data["data"]["price"];
      return dto;
    }

    throw ServerException();
  }
  Future<int> getPriceAuctionNow(String idPro) async {
    var response = await appClient
        .dioAuth(getLocalAccessToken().accessToken!)
        .get(
      ApiEndPointFactory.jancargoServerEndPoint
          .getUrlQueryApi('${AppPath.getPriceAuction}/$idPro'),

    )
        .onError((dios.DioError error, stackTrace) =>
        ErrorMiddleHandler.handleDioError(error));
    ErrorMiddleHandler.log(response);

    if (response.statusCode == HttpStatus.ok) {
      int dto = response.data["data"]["price_buy"];
      return dto;
    }

    throw ServerException();
  }

  Future<String> auctionOff(AuctionOffRequest request) async {
    var response = await appClient
        .dioAuth(getLocalAccessToken().accessToken!)
        .post(
          ApiEndPointFactory.jancargoServerEndPoint
              .getUrlQueryApi(AppPath.auctionOff),
          data: request,
        )
        .onError((dios.DioError error, stackTrace) =>
            ErrorMiddleHandler.handleDioError(error));
    ErrorMiddleHandler.log(response);

    if (response.statusCode == HttpStatus.ok) {
      String text = response.data["message"];
      return text;
    }

    throw ServerException();
  }

  Future<SearchPopularDto> searchPopular() async {
    var response = await appClient
        .dioAuth(getLocalAccessToken().accessToken!)
        .get(
      ApiEndPointFactory.jancargoServerEndPoint
          .getUrlQueryApi(AppPath.searchPopular),
      queryParameters: {"type": "auction", "size": 20},
    ).onError((dios.DioError error, stackTrace) =>
            ErrorMiddleHandler.handleDioError(error));
    ErrorMiddleHandler.log(response);

    if (response.statusCode == HttpStatus.ok) {
      SearchPopularDto dto = SearchPopularDto.fromJson(response.data["data"]);
      return dto;
    }

    throw ServerException();
  }

  Future<CategoryHomeDto> categoryHome() async {
    var response = await appClient
        .dioAuth(getLocalAccessToken().accessToken!)
        .get(
      ApiEndPointFactory.jancargoServerEndPoint
          .getUrlQueryApi(AppPath.categoryHome),
      queryParameters: {"page": "1", "main": true, "type_code": "auction"},
    ).onError((dios.DioError error, stackTrace) =>
            ErrorMiddleHandler.handleDioError(error));
    ErrorMiddleHandler.log(response);

    if (response.statusCode == HttpStatus.ok) {
      CategoryHomeDto dto = CategoryHomeDto.fromJson(response.data);
      return dto;
    }

    throw ServerException();
  }

  Future<AmazonJsFlashSaleDto> amazonFlashSale() async {
    var response = await appClient
        .dioAuth(getLocalAccessToken().accessToken!)
        .get(
      ApiEndPointFactory.jancargoServerEndPoint
          .getUrlQueryApi(AppPath.amazonJsFlashSale),
      queryParameters: {"language": "ja_JP", "country": "jp", },
    ).onError((dios.DioError error, stackTrace) =>
            ErrorMiddleHandler.handleDioError(error));
    ErrorMiddleHandler.log(response);

    if (response.statusCode == HttpStatus.ok) {
      AmazonJsFlashSaleDto dto = AmazonJsFlashSaleDto.fromJson(response.data);
      return dto;
    }

    throw ServerException();
  }

  Future<SearchPopularDto> categorySearch() async {
    var response = await appClient
        .dioAuth(getLocalAccessToken().accessToken!)
        .get(
      ApiEndPointFactory.jancargoServerEndPoint
          .getUrlQueryApi(AppPath.categoryHome),
      queryParameters: {"type": "auction", "size": 20},
    ).onError((dios.DioError error, stackTrace) =>
            ErrorMiddleHandler.handleDioError(error));
    ErrorMiddleHandler.log(response);

    if (response.statusCode == HttpStatus.ok) {
      SearchPopularDto dto = SearchPopularDto.fromJson(response.data["data"]);
      return dto;
    }

    throw ServerException();
  }

  Future<CategoryDto> auctionProducts() async {
    var response = await appClient
        .dioAuth(getLocalAccessToken().accessToken!)
        .get(
      ApiEndPointFactory.jancargoServerEndPoint
          .getUrlQueryApi('${AppPath.auctionProducts}?categories=23260&categories=2084044777&categories=2084008364&categories=25180&categories=2084005069'),

    ).onError((dios.DioError error, stackTrace) =>
            ErrorMiddleHandler.handleDioError(error));
    ErrorMiddleHandler.log(response);

    if (response.statusCode == HttpStatus.ok) {
      CategoryDto dto = CategoryDto.fromJson(response.data);
      return dto;
    }

    throw ServerException();
  }

  Future<bool> activeVip(String code) async {
    var response = await appClient
        .dioAuth(getLocalAccessToken().accessToken!)
        .post(
      ApiEndPointFactory.jancargoServerEndPoint
          .getUrlQueryApi(AppPath.activeVip),
     data: {"code":code},
    ).onError((dios.DioError error, stackTrace) =>
        ErrorMiddleHandler.handleDioError(error));
    ErrorMiddleHandler.log(response);

    if (response.statusCode == HttpStatus.ok) {
      bool dto = response.data['message'] == 'Kích hoạt VIP không thành công' ? false : true;
      return dto;
    }

    throw ServerException();
  }
}
