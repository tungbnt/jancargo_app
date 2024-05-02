
import 'dart:io';

import 'package:dio/dio.dart' as dios;
import 'package:injectable/injectable.dart';
import 'package:jancargo_app/src/domain/dtos/detail_product/detail/detail_dto.dart';
import 'package:jancargo_app/src/domain/dtos/user/warehouse/warehouse_dto.dart';

import '../../../core/exception.dart';
import '../../../domain/dtos/dashboard/recently_viewed/recently_viewed_dto.dart';
import '../../../domain/dtos/detail_product/detail_marcari/detail_marcari_dto.dart';
import '../../../domain/dtos/detail_product/list/relates_dto.dart';
import '../../../domain/dtos/detail_product/rakuten_detail/rakuten_detail_dto.dart';
import '../../../domain/dtos/detail_product/seller_auction/seller_auction_dto.dart';
import '../../../domain/dtos/detail_product/suggestion_rakuten/suggestion_rakuten_dto.dart';
import '../../../domain/dtos/detail_product/y_shopping/y_shopping_dto.dart';
import '../../../domain/dtos/favorite/favorite_dto.dart';
import '../../../domain/dtos/search/search_shop/search_shopping_dto.dart';
import '../../object_request_api/dashboard/top_shop/top_shop_request.dart';
import '../../object_request_api/search/search_seller/search_seller_request.dart';
import '../../remote/api-endpoint.dart';
import '../../remote/api_endpoint/api_end_point_factory.dart';
import '../../remote/middle-handler/error-handler.dart';
import '../base/base_datasource.dart';


@Singleton()
class DetailProductSource extends BaseDateSource {

  Future<DetailDto> infoProduct(String code) async {
    var response = await appClient.dioNonAuth()
        .get(
      ApiEndPointFactory.jancargoServerEndPoint.getUrlQueryApi(
          "${AppPath.infoProductAuction}$code?include_seller_info=true"),
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

  Future<RakutenDetailDto> infoProductRakuten(String code) async {
    var response = await appClient.dioNonAuth()
        .get(
      ApiEndPointFactory.jancargoServerEndPoint.getUrlQueryApi(
          "${AppPath.infoProductRakuten}$code"),
    )
        .onError((dios.DioError error, stackTrace) =>
        ErrorMiddleHandler.handleDioError(error));
    ErrorMiddleHandler.log(response);

    if (response.statusCode == HttpStatus.ok) {
      RakutenDetailDto dto = RakutenDetailDto.fromJson(response.data);
      return dto;
    }

    throw ServerException();
  }
  Future<YShoppingDetailDto> infoProductYShopping(String code) async {
    var response = await appClient.dioNonAuth()
        .get(
      ApiEndPointFactory.jancargoServerEndPoint.getUrlQueryApi(
          "${AppPath.infoProductYShopping}$code"),
    )
        .onError((dios.DioError error, stackTrace) =>
        ErrorMiddleHandler.handleDioError(error));
    ErrorMiddleHandler.log(response);

    if (response.statusCode == HttpStatus.ok) {
      YShoppingDetailDto dto = YShoppingDetailDto.fromJson(response.data["data"]);
      return dto;
    }

    throw ServerException();
  }

  Future<MarcariDetailDto> infoProductMarcari(String code) async {
    var response = await appClient.dioNonAuth()
        .get(
      ApiEndPointFactory.jancargoServerEndPoint.getUrlQueryApi(
          "${AppPath.infoProductMarcari}$code?type=ITEM_TYPE_MERCARI"),
    )
        .onError((dios.DioError error, stackTrace) =>
        ErrorMiddleHandler.handleDioError(error));
    ErrorMiddleHandler.log(response);

    if (response.statusCode == HttpStatus.ok) {
      MarcariDetailDto dto = MarcariDetailDto.fromJson(response.data["data"]);
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

  //sp tương t
  Future<RelateDto> relates(String code) async {
    var response = await appClient.dioNonAuth().get(
      ApiEndPointFactory.jancargoServerEndPoint.getUrlQueryApi("${AppPath.suggestion}/$code"),
    ).onError((dios.DioError error, stackTrace) =>
        ErrorMiddleHandler.handleDioError(error));
    ErrorMiddleHandler.log(response);

    if (response.statusCode == HttpStatus.ok) {
      RelateDto dto = RelateDto.fromJson(response.data);
      return dto;
    }

    throw ServerException();
  }
  //
  Future<WareHouseDto> warehouse() async {
    var response = await appClient.dioNonAuth().get(
      ApiEndPointFactory.jancargoServerEndPoint.getUrlQueryApi(AppPath.warehouse),
    ).onError((dios.DioError error, stackTrace) =>
        ErrorMiddleHandler.handleDioError(error));
    ErrorMiddleHandler.log(response);

    if (response.statusCode == HttpStatus.ok) {
      WareHouseDto dto = WareHouseDto.fromJson(response.data["data"]);
      return dto;
    }

    throw ServerException();
  }

  //seller auction
  Future<SellerDetailAuctionDto> sellerAuction() async {
    var response = await appClient.dioNonAuth().get(
      ApiEndPointFactory.jancargoServerEndPoint.getUrlQueryApi(AppPath.auctionSeller),
    ).onError((dios.DioError error, stackTrace) =>
        ErrorMiddleHandler.handleDioError(error));
    ErrorMiddleHandler.log(response);

    if (response.statusCode == HttpStatus.ok) {
      SellerDetailAuctionDto dto = SellerDetailAuctionDto.fromJson(response.data);
      return dto;
    }

    throw ServerException();
  }
  Future<SellerInfoAuctionDto> sellerInfo(String code) async {
    var response = await appClient.dioNonAuth().get(
      ApiEndPointFactory.jancargoServerEndPoint.getUrlQueryApi("${AppPath.auctionSeller}/$code"),
    ).onError((dios.DioError error, stackTrace) =>
        ErrorMiddleHandler.handleDioError(error));
    ErrorMiddleHandler.log(response);

    if (response.statusCode == HttpStatus.ok) {
      SellerInfoAuctionDto dto = SellerInfoAuctionDto.fromJson(response.data["info"]);
      return dto;
    }

    throw ServerException();
  }

  Future<FavoriteSearchDto> favorites() async {
    var response = await appClient.dioAuth(getLocalAccessToken().accessToken!)
        .get(
        ApiEndPointFactory.jancargoServerEndPoint.getUrlQueryApi(
            AppPath.favoritesSearch),
        data: {'size':20,'page':1,'order':"created_date:desc",}
    )
        .onError((dios.DioError error, stackTrace) =>
        ErrorMiddleHandler.handleDioError(error));
    ErrorMiddleHandler.log(response);

    if (response.statusCode == HttpStatus.ok) {
      FavoriteSearchDto dto = FavoriteSearchDto.fromJson(response.data["data"]);
      return dto;
    }

    throw ServerException();
  }

  Future<SearchShoppingDto> suggestionsYShopping({required SuggestionRequest request}) async {
    var response = await appClient.dioNonAuth().get(
      ApiEndPointFactory.jancargoServerEndPoint.getUrlQueryApi(AppPath.searchYAuction),
      queryParameters: request.toJson(),
    ).onError((dios.DioError error, stackTrace) =>
        ErrorMiddleHandler.handleDioError(error));
    ErrorMiddleHandler.log(response);

    if (response.statusCode == HttpStatus.ok) {
      SearchShoppingDto dto = SearchShoppingDto.fromJson(response.data["data"]);
      return dto;
    }

    throw ServerException();
  }

  Future<SuggestionRakutenDto> suggestionsRakuten() async {
    var response = await appClient.dioNonAuth().get(
      ApiEndPointFactory.jancargoServerEndPoint.getUrlQueryApi('${AppPath.suggestionRakuten}?page=1'),
    ).onError((dios.DioError error, stackTrace) =>
        ErrorMiddleHandler.handleDioError(error));
    ErrorMiddleHandler.log(response);

    if (response.statusCode == HttpStatus.ok) {
      SuggestionRakutenDto dto = SuggestionRakutenDto.fromJson(response.data);
      return dto;
    }

    throw ServerException();
  }

  //xem gần đây
  Future<RecentlyDto> recentlyViewedYShopping({required LoadItemRequest request}) async {
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
}