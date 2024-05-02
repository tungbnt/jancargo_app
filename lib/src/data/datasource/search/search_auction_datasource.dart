
import 'dart:io';

import 'package:dio/dio.dart' as dios;
import 'package:injectable/injectable.dart';
import 'package:jancargo_app/src/domain/dtos/object_resolver/rakuten_resolver/rakuten_resolver_dto.dart';
import 'package:jancargo_app/src/domain/dtos/search/producer_search/producer_search_dto.dart';
import 'package:jancargo_app/src/domain/dtos/search/search_mercari/search_mercari_dto.dart';
import 'package:jancargo_app/src/domain/dtos/search/search_popular/search_popular_dto.dart';
import 'package:jancargo_app/src/domain/dtos/search/search_suggestion/search_suggestion_dto.dart';
import 'package:jancargo_app/src/general/constants/app_storage.dart';

import '../../../core/exception.dart';
import '../../../domain/dtos/auction/auction_search/auction_search_dto.dart';
import '../../../domain/dtos/dashboard/auction/auction_dto.dart';
import '../../../domain/dtos/search/amazon_js_search_keyword/amazon_js_search_keyword_dto.dart';
import '../../../domain/dtos/search/mecari_search_key_word/mecari_search_key_word_dto.dart';
import '../../../domain/dtos/search/paypay_search_keyword/paypay_search_keyword_dto.dart';
import '../../../domain/dtos/search/rakuten_search_key_word/rakuten_search_key_word_dto.dart';
import '../../../domain/dtos/search/search_all/search_all_dto.dart';
import '../../../domain/dtos/search/search_rakuten/search_rakuten_dto.dart';
import '../../../domain/dtos/search/search_shop/search_shopping_dto.dart';
import '../../../domain/dtos/site_model/amazon_js/amazon_js_dto.dart';
import '../../../domain/dtos/site_model/paypay/paypay_dto.dart';
import '../../object_request_api/dashboard/auction/auction_request.dart';
import '../../object_request_api/key_word/search_key_word_request.dart';
import '../../object_request_api/search/search_seller/search_seller_request.dart';
import '../../remote/api-endpoint.dart';
import '../../remote/api_endpoint/api_end_point_factory.dart';
import '../../remote/middle-handler/error-handler.dart';
import '../base/base_datasource.dart';

@Singleton()
class SearchDatasource extends BaseDateSource {
  Future<SearchShoppingDto> searchYShopping({required SearchSellerRequest request}) async {
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
  Future<SearchMercariDto> searchMercari() async {
    var response = await appClient.dioNonAuth().get(
      ApiEndPointFactory.jancargoServerEndPoint.getUrlQueryApi(AppPath.searchMercari),
    ).onError((dios.DioError error, stackTrace) =>
        ErrorMiddleHandler.handleDioError(error));
    ErrorMiddleHandler.log(response);

    if (response.statusCode == HttpStatus.ok) {
      SearchMercariDto dto = SearchMercariDto.fromJson(response.data);
      return dto;
    }

    throw ServerException();
  }

  Future<SearchRakutenDto> searchRakuten({required SearchSellerRequest request}) async {
    var response = await appClient.dioNonAuth().get(
      ApiEndPointFactory.jancargoServerEndPoint.getUrlQueryApi(AppPath.searchRakuten),
      queryParameters: request.toJson(),
    ).onError((dios.DioError error, stackTrace) =>
        ErrorMiddleHandler.handleDioError(error));
    ErrorMiddleHandler.log(response);

    if (response.statusCode == HttpStatus.ok) {
      SearchRakutenDto dto = SearchRakutenDto.fromJson(response.data);
      return dto;
    }

    throw ServerException();
  }
  Future<PaypayDto> searchPaypay() async {
    print("${AppPath.searchPaypay}?size=20&${AppStorage.getQuery()}");
    var response = await appClient.dioNonAuth().get(
      ApiEndPointFactory.jancargoServerEndPoint.getUrlQueryApi("${AppPath.searchPaypay}?size=20&${await AppStorage.getQuery()}"),
    ).onError((dios.DioError error, stackTrace) =>
        ErrorMiddleHandler.handleDioError(error));
    ErrorMiddleHandler.log(response);

    if (response.statusCode == HttpStatus.ok) {
      PaypayDto dto = PaypayDto.fromJson(response.data);
      return dto;
    }

    throw ServerException();
  }
  Future<AmazonJsDto> searchAmazonJs() async {
    var response = await appClient.dioNonAuth().post(
      ApiEndPointFactory.jancargoServerEndPoint.getUrlQueryApi(AppPath.searchAmazonJs),
    ).onError((dios.DioError error, stackTrace) =>
        ErrorMiddleHandler.handleDioError(error));
    ErrorMiddleHandler.log(response);

    if (response.statusCode == HttpStatus.ok) {
      AmazonJsDto dto = AmazonJsDto.fromJson(response.data);
      return dto;
    }

    throw ServerException();
  }
  //api search suggestion
  Future<SearchSuggestionDto> searchSuggestion({required SearchSellerRequest request}) async {
    var response = await appClient.dioNonAuth().get(
      ApiEndPointFactory.jancargoServerEndPoint.getUrlQueryApi(AppPath.searchSuggestion),
      queryParameters: request.toJson(),
    ).onError((dios.DioError error, stackTrace) =>
        ErrorMiddleHandler.handleDioError(error));
    ErrorMiddleHandler.log(response);

    if (response.statusCode == HttpStatus.ok) {
      SearchSuggestionDto dto = SearchSuggestionDto.fromJson(response.data["data"]);
      return dto;
    }

    throw ServerException();
  }
  Future<SearchPopularDto> searchPopular({required SearchSellerRequest request}) async {
    var response = await appClient.dioNonAuth().get(
      ApiEndPointFactory.jancargoServerEndPoint.getUrlQueryApi(AppPath.searchPopular),
      queryParameters: request.toJson(),
    ).onError((dios.DioError error, stackTrace) =>
        ErrorMiddleHandler.handleDioError(error));
    ErrorMiddleHandler.log(response);

    if (response.statusCode == HttpStatus.ok) {
      SearchPopularDto dto = SearchPopularDto.fromJson(response.data["data"]);
      return dto;
    }

    throw ServerException();
  }

  //api keyword
  Future<MercariSearchKeyWordDto> searchMercariKeyWord({required SearchKeyWordRequest request}) async {
    var response = await appClient.dioNonAuth().get(
      ApiEndPointFactory.jancargoServerEndPoint.getUrlQueryApi(AppPath.searchMercariWord),
      queryParameters: request.toJson(),
    ).onError((dios.DioError error, stackTrace) =>
        ErrorMiddleHandler.handleDioError(error));
    ErrorMiddleHandler.log(response);

    if (response.statusCode == HttpStatus.ok) {
      MercariSearchKeyWordDto dto = MercariSearchKeyWordDto.fromJson(response.data["data"]);
      return dto;
    }

    throw ServerException();
  }
  Future<RakutenSearchKeyWordDto> searchRakutenKeyWord({required SearchKeyWordRequest request}) async {
    var response = await appClient.dioNonAuth().get(
      ApiEndPointFactory.jancargoServerEndPoint.getUrlQueryApi(AppPath.searchRakutenWord),
      queryParameters: request.toJson()..removeWhere((key, value) => value == '' || value == null),
    ).onError((dios.DioError error, stackTrace) =>
        ErrorMiddleHandler.handleDioError(error));
    ErrorMiddleHandler.log(response);

    if (response.statusCode == HttpStatus.ok) {
      RakutenSearchKeyWordDto dto = RakutenSearchKeyWordDto.fromJson(response.data["data"]);
      return dto;
    }

    throw ServerException();
  }
  Future<RakutenResolverDto> objectResolverRakuten(String url) async {
    var response = await appClient.dioNonAuth().post(
      ApiEndPointFactory.jancargoServerEndPoint.getUrlQueryApi(AppPath.objectResolverRakuten),
      data: {'url': url},
    ).onError((dios.DioError error, stackTrace) =>
        ErrorMiddleHandler.handleDioError(error));
    ErrorMiddleHandler.log(response);

    if (response.statusCode == HttpStatus.ok) {
      RakutenResolverDto dto = RakutenResolverDto.fromJson(response.data);
      return dto;
    }

    throw ServerException();
  }
  Future<AuctionDto> yAuctionSearchCategory({required AuctionRequest request}) async {
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
  Future<ProducerSearchDto> getBrandAuction(String urlApi) async {
    var response = await appClient.dioNonAuth().get(
      ApiEndPointFactory.jancargoServerEndPoint.getUrlQueryApi(urlApi),

    ).onError((dios.DioError error, stackTrace) =>
        ErrorMiddleHandler.handleDioError(error));
    ErrorMiddleHandler.log(response);

    if (response.statusCode == HttpStatus.ok) {
      ProducerSearchDto dto = ProducerSearchDto.fromJson(response.data);
      return dto;
    }

    throw ServerException();
  }
  Future<AuctionSearchDto> yAuctionSearchKeyWord({required AuctionSearchRequest request}) async {

    var response = await appClient.dioNonAuth().get(
      ApiEndPointFactory.jancargoServerEndPoint.getUrlQueryApi(AppPath.auctionSearch),
      queryParameters: request.toJson()..removeWhere((key, value) => value == "" || value == null || value == [] || value == 0 ),
    ).onError((dios.DioError error, stackTrace) =>
        ErrorMiddleHandler.handleDioError(error));
    ErrorMiddleHandler.log(response);

    if (response.statusCode == HttpStatus.ok) {
      AuctionSearchDto dto = AuctionSearchDto.fromJson(response.data);
      return dto;
    }

    throw ServerException();
  }
  Future<AuctionSearchDto> yAuctionSearchKeyWordCategoryId(String categoryId) async {
    var response = await appClient.dioNonAuth().get(
      ApiEndPointFactory.jancargoServerEndPoint.getUrlQueryApi("${AppPath.breadcrumb}?code=$categoryId&type=y-auction"),
    ).onError((dios.DioError error, stackTrace) =>
        ErrorMiddleHandler.handleDioError(error));
    ErrorMiddleHandler.log(response);

    if (response.statusCode == HttpStatus.ok) {
      AuctionSearchDto dto = AuctionSearchDto.fromJson(response.data["data"]);
      return dto;
    }

    throw ServerException();
  }
  Future<PaypaySearchKeyWordDto> payPaySearchKeyWord({required SearchKeyWordRequest request}) async {
    var response = await appClient.dioNonAuth().get(
      ApiEndPointFactory.jancargoServerEndPoint.getUrlQueryApi(AppPath.searchPayPayWord),
      queryParameters: request.toJson(),
    ).onError((dios.DioError error, stackTrace) =>
        ErrorMiddleHandler.handleDioError(error));
    ErrorMiddleHandler.log(response);

    if (response.statusCode == HttpStatus.ok) {
      PaypaySearchKeyWordDto dto = PaypaySearchKeyWordDto.fromJson(response.data["data"]);
      return dto;
    }

    throw ServerException();
  }
  Future<AmazonSearchKeyWordDto> amazonJsSearchKeyWord({required SearchKeyWordRequest request}) async {
    var response = await appClient.dioNonAuth().get(
      ApiEndPointFactory.jancargoServerEndPoint.getUrlQueryApi(AppPath.searchAmazonJsWord),
      queryParameters: request.toJson(),
    ).onError((dios.DioError error, stackTrace) =>
        ErrorMiddleHandler.handleDioError(error));
    ErrorMiddleHandler.log(response);

    if (response.statusCode == HttpStatus.ok) {
      AmazonSearchKeyWordDto dto = AmazonSearchKeyWordDto.fromJson(response.data);
      return dto;
    }

    throw ServerException();
  }
  Future<AmazonSearchKeyWordDto> amazonUsSearchKeyWord({required SearchKeyWordRequest request}) async {
    var response = await appClient.dioNonAuth().get(
      ApiEndPointFactory.jancargoServerEndPoint.getUrlQueryApi(AppPath.searchAmazonUsWord),
      queryParameters: request.toJson(),
    ).onError((dios.DioError error, stackTrace) =>
        ErrorMiddleHandler.handleDioError(error));
    ErrorMiddleHandler.log(response);

    if (response.statusCode == HttpStatus.ok) {
      AmazonSearchKeyWordDto dto = AmazonSearchKeyWordDto.fromJson(response.data);
      return dto;
    }

    throw ServerException();
  }

  Future<SearchShoppingDto> yahooShoppingKeyWord({required SearchKeyWordRequest request}) async {
    var response = await appClient.dioAuth(getLocalAccessToken().accessToken!).get(
      ApiEndPointFactory.jancargoServerEndPoint.getUrlQueryApi(AppPath.searchYAuction),
      queryParameters: request.toJson()..removeWhere((key, value) => value == ""),
    ).onError((dios.DioError error, stackTrace) =>
        ErrorMiddleHandler.handleDioError(error));
    ErrorMiddleHandler.log(response);

    if (response.statusCode == HttpStatus.ok) {
      SearchShoppingDto dto = SearchShoppingDto.fromJson(response.data["data"]);
      return dto;
    }

    throw ServerException();
  }

  Future<SearchAllDto> allSearchKeyWord(String? keySearch) async {
    var response = await appClient.dioNonAuth().get(
      ApiEndPointFactory.jancargoServerEndPoint.getUrlQueryApi(AppPath.searchAll),
      queryParameters: {"q": keySearch},
    ).onError((dios.DioError error, stackTrace) =>
        ErrorMiddleHandler.handleDioError(error));
    ErrorMiddleHandler.log(response);

    if (response.statusCode == HttpStatus.ok) {
      SearchAllDto dto = SearchAllDto.fromJson(response.data["data"]);
      return dto;
    }

    throw ServerException();
  }
}