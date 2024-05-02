import 'dart:io';

import 'package:dio/dio.dart' as dios;
import 'package:injectable/injectable.dart';

import '../../../core/exception.dart';
import '../../../domain/dtos/dashboard/auction/auction_dto.dart';
import '../../../domain/dtos/dashboard/banner_slider/banner_slider_dto.dart';
import '../../../domain/dtos/dashboard/flash_sale/flash_sale_dto.dart';
import '../../../domain/dtos/dashboard/quick/quick_dto.dart';
import '../../../domain/dtos/dashboard/recently_viewed/recently_viewed_dto.dart';
import '../../../domain/dtos/dashboard/top_shop/top_shop_dto.dart';
import '../../object_request_api/dashboard/auction/auction_request.dart';
import '../../object_request_api/dashboard/banner_slider/banner_slider_request.dart';
import '../../object_request_api/dashboard/quick/quick_request.dart';
import '../../object_request_api/dashboard/top_shop/top_shop_request.dart';
import '../../remote/api-endpoint.dart';
import '../../remote/api_endpoint/api_end_point_factory.dart';
import '../../remote/middle-handler/error-handler.dart';
import '../base/base_datasource.dart';

@Singleton()
class HomeSource extends BaseDateSource {

  Future<TopShopDto> topShop({required LoadItemRequest request}) async {
    var response = await appClient.dioNonAuth()
        .get(
      ApiEndPointFactory.jancargoServerEndPoint.getUrlQueryApi(
          AppPath.houseOfSale),
      queryParameters: request.toJson(),
    )
        .onError((dios.DioError error, stackTrace) =>
        ErrorMiddleHandler.handleDioError(error));
    ErrorMiddleHandler.log(response);

    if (response.statusCode == HttpStatus.ok) {
      TopShopDto dto = TopShopDto.fromJson(response.data["data"]);
      return dto;
    }

    throw ServerException();
  }

  Future<FlashSaleDto> flashSale() async {
    var response = await appClient.dioNonAuth().get(
        ApiEndPointFactory.jancargoServerEndPoint.getUrlQueryApi(AppPath.flashSale),
    ).onError((dios.DioError error, stackTrace) =>
        ErrorMiddleHandler.handleDioError(error));
    ErrorMiddleHandler.log(response);

    if (response.statusCode == HttpStatus.ok) {
      FlashSaleDto dto = FlashSaleDto.fromJson(response.data);
      return dto;
    }

    throw ServerException();
  }
  Future<TopShopDto> topCategories({required LoadItemRequest request}) async {
    var response = await appClient.dioNonAuth().get(
      ApiEndPointFactory.jancargoServerEndPoint.getUrlQueryApi(AppPath.toViewCategories),
      queryParameters: request.toJson(),
    ).onError((dios.DioError error, stackTrace) =>
        ErrorMiddleHandler.handleDioError(error));
    ErrorMiddleHandler.log(response);

    if (response.statusCode == HttpStatus.ok) {
      TopShopDto dto = TopShopDto.fromJson(response.data["data"]);
      return dto;
    }

    throw ServerException();
  }

  //xem gần đây
  Future<RecentlyDto> recentlyViewed({required LoadItemRequest request}) async {
    var response = await appClient.dioAuth(getLocalAccessToken().accessToken!).get(
      ApiEndPointFactory.jancargoServerEndPoint.getUrlQueryApi(AppPath.recentlyViewed),
      queryParameters: request.toJson(),
    ).onError((dios.DioError error, stackTrace) =>
        ErrorMiddleHandler.handleDioError(error));
    ErrorMiddleHandler.log(response);

    if (response.statusCode == HttpStatus.ok) {
      RecentlyDto dto = RecentlyDto.fromJson(response.data["data"]);
      return dto;
    }

    throw ServerException();
  }
  //type
  Future<QuickDto> quick({required QuickRequest request}) async {
    var response = await appClient.dioNonAuth().get(
      ApiEndPointFactory.jancargoServerEndPoint.getUrlQueryApi(AppPath.quick),
      queryParameters: request.toJson(),
    ).onError((dios.DioError error, stackTrace) =>
        ErrorMiddleHandler.handleDioError(error));
    ErrorMiddleHandler.log(response);

    if (response.statusCode == HttpStatus.ok) {
      QuickDto dto = QuickDto.fromJson(response.data["data"]);
      return dto;
    }

    throw ServerException();
  }
  //sp đấu giá
  Future<AuctionDto> auction({required AuctionRequest request}) async {
    var response = await appClient.dioNonAuth().get(
      ApiEndPointFactory.jancargoServerEndPoint.getUrlQueryApi(AppPath.auction),
      queryParameters: request.toJson(),
    ).onError((dios.DioError error, stackTrace) =>
        ErrorMiddleHandler.handleDioError(error));
    ErrorMiddleHandler.log(response);

    if (response.statusCode == HttpStatus.ok) {
      AuctionDto dto = AuctionDto.fromJson(response.data["data"]);
      return dto;
    }

    throw ServerException();
  }

  //banner
  Future<BannerSliderDto> bannerSlider({required BannerSliderRequest request}) async {
    var response = await appClient.dioNonAuth().get(
      ApiEndPointFactory.jancargoServerEndPoint.getUrlQueryApi(AppPath.bannerSlider),
      queryParameters: request.toJson(),
    ).onError((dios.DioError error, stackTrace) =>
        ErrorMiddleHandler.handleDioError(error));
    ErrorMiddleHandler.log(response);

    if (response.statusCode == HttpStatus.ok) {
      BannerSliderDto dto = BannerSliderDto.fromJson(response.data["data"]);
      return dto;
    }

    throw ServerException();
  }
  //search


}
