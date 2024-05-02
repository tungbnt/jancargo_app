import 'dart:io';

import 'package:dio/dio.dart' as dios;
import 'package:injectable/injectable.dart';
import 'package:jancargo_app/src/domain/dtos/favorite/favorite_dto.dart';

import '../../../core/exception.dart';
import '../../../domain/dtos/seller/favorite_seller/favorite_seller_dto.dart';
import '../../object_request_api/favorite/favorite_request.dart';
import '../../object_request_api/favorite_seller/favorite_seller_request.dart';
import '../../remote/api-endpoint.dart';
import '../../remote/api_endpoint/api_end_point_factory.dart';
import '../../remote/middle-handler/error-handler.dart';
import '../base/base_datasource.dart';

@Singleton()
class FavoriteSource extends BaseDateSource {

  Future<String> favoriteItem(FavoriteRequest request) async {
    var response = await appClient.dioAuth(getLocalAccessToken().accessToken!)
        .post(
      ApiEndPointFactory.jancargoServerEndPoint.getUrlQueryApi(
          AppPath.favoriteItem),
     data: request.toJson(),
    )
        .onError((dios.DioError error, stackTrace) =>
        ErrorMiddleHandler.handleDioError(error));
    ErrorMiddleHandler.log(response);

    if (response.statusCode == HttpStatus.ok) {
      String dto = response.data["message"];
      return dto;
    }

    throw ServerException();
  }

  Future<FavoriteDto> favorites() async {
    var response = await appClient.dioAuth(getLocalAccessToken().accessToken!)
        .get(
      ApiEndPointFactory.jancargoServerEndPoint.getUrlQueryApi(
          AppPath.favorites),
    )
        .onError((dios.DioError error, stackTrace) =>
        ErrorMiddleHandler.handleDioError(error));
    ErrorMiddleHandler.log(response);

    if (response.statusCode == HttpStatus.ok) {
      FavoriteDto dto = FavoriteDto.fromJson(response.data);
      return dto;
    }

    throw ServerException();
  }

  Future<String> favoritesSeller(FavoriteSellerRequest request) async {
    var response = await appClient.dioAuth(getLocalAccessToken().accessToken!)
        .post(
      ApiEndPointFactory.jancargoServerEndPoint.getUrlQueryApi(
          AppPath.favoriteStore),
      data:  request.toJson(),
    )
        .onError((dios.DioError error, stackTrace) =>
        ErrorMiddleHandler.handleDioError(error));
    ErrorMiddleHandler.log(response);

    if (response.statusCode == HttpStatus.ok) {
      String dto = response.data["messages"];
      return dto;
    }

    throw ServerException();
  }
  Future<FavoriteSellerDto> getFavoritesSeller() async {
    var response = await appClient.dioAuth(getLocalAccessToken().accessToken!)
        .get(
      ApiEndPointFactory.jancargoServerEndPoint.getUrlQueryApi(
          AppPath.favoriteStoreUser),
    )
        .onError((dios.DioError error, stackTrace) =>
        ErrorMiddleHandler.handleDioError(error));
    ErrorMiddleHandler.log(response);

    if (response.statusCode == HttpStatus.ok) {
      FavoriteSellerDto dto = FavoriteSellerDto.fromJson(response.data);
      return dto;
    }

    throw ServerException();
  }

  Future<bool> deletedFavorites() async {
    var response = await appClient.dioAuth(getLocalAccessToken().accessToken!)
        .get(
      ApiEndPointFactory.jancargoServerEndPoint.getUrlQueryApi(
          AppPath.removeFavorite),
    )
        .onError((dios.DioError error, stackTrace) =>
        ErrorMiddleHandler.handleDioError(error));
    ErrorMiddleHandler.log(response);

    if (response.statusCode == HttpStatus.ok) {
      bool dto = response.data["message"] == "success" ? true : false;
      return dto;
    }

    throw ServerException();
  }

  Future<FavoriteSearchDto> favoriteSearch(String keySearch,String siteCode,String arrange) async {
    var response = await appClient.dioAuth(getLocalAccessToken().accessToken!)
        .get(
      ApiEndPointFactory.jancargoServerEndPoint.getUrlQueryApi(
          AppPath.favoritesSearch),
      queryParameters: {'size':20,'page':1,'order':arrange,'search': keySearch,'site_code': siteCode}..removeWhere((key, value) => value == ""),
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

  Future<FavoriteSearchDto> favoriteFilter(String siteCode) async {
    var response = await appClient.dioAuth(getLocalAccessToken().accessToken!)
        .get(
        ApiEndPointFactory.jancargoServerEndPoint.getUrlQueryApi(
            AppPath.favoritesSearch),
        data: {'size':20,'page':1,'order':"created_date:desc",'site_code': siteCode}
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


}