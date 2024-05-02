
import 'dart:io';

import 'package:dio/dio.dart' as dios;
import 'package:injectable/injectable.dart';
import 'package:jancargo_app/src/data/object_request_api/auction/price_auction/price_auction_request.dart';
import 'package:jancargo_app/src/domain/dtos/auction/price/price_dto.dart';
import 'package:jancargo_app/src/domain/dtos/cart/calculate_cart/calculate_cart_dto.dart';

import '../../../core/exception.dart';
import '../../../domain/dtos/cart/add_item_cart/add_item_cart_dto.dart';
import '../../../domain/dtos/cart/item_cart/item_cart_dto.dart';
import '../../object_request_api/add_cart/add_cart_request.dart';
import '../../object_request_api/update_item_cart/update_item_cart_request.dart';
import '../../remote/api-endpoint.dart';
import '../../remote/api_endpoint/api_end_point_factory.dart';
import '../../remote/middle-handler/error-handler.dart';
import '../base/base_datasource.dart';
@Singleton()
class CartDataSource extends BaseDateSource {
  Future<AddItemCartDto> addCart(AddCartRequest request) async {
    var response = await appClient.dioAuth(getLocalAccessToken().accessToken!).post(
        ApiEndPointFactory.jancargoServerEndPoint.getUrlQueryApi(AppPath.addCart),
      data: request.toJson(),
    ).onError((dios.DioError error, stackTrace) =>
        ErrorMiddleHandler.handleDioError(error));
    ErrorMiddleHandler.log(response);

    if (response.statusCode == HttpStatus.ok) {
      AddItemCartDto dto = AddItemCartDto.fromJson(response.data);
      return dto;
    }
    throw ServerException();
  }

  Future<CartDto> itemCart() async {
    var response = await appClient.dioAuth(getLocalAccessToken().accessToken!).get(
      ApiEndPointFactory.jancargoServerEndPoint.getUrlQueryApi(AppPath.itemCart),
    ).onError((dios.DioError error, stackTrace) =>
        ErrorMiddleHandler.handleDioError(error));
    ErrorMiddleHandler.log(response);

    if (response.statusCode == HttpStatus.ok) {
      CartDto dto = CartDto.fromJson(response.data);
      return dto;
    }
    throw ServerException();
  }

  Future<bool> removeItemCart(List<String> idItemCart) async {
    var response = await appClient.dioAuth(getLocalAccessToken().accessToken!).post(
      ApiEndPointFactory.jancargoServerEndPoint.getUrlQueryApi(AppPath.removeItemCart),
      data: {"ids": idItemCart}
    ).onError((dios.DioError error, stackTrace) =>
        ErrorMiddleHandler.handleDioError(error));
    ErrorMiddleHandler.log(response);

    if (response.statusCode == HttpStatus.ok) {
      var dto = response.data["message"] == "success" ? true : false;
      return dto;
    }
    throw ServerException();
  }

  Future<bool> updateItemCart(UpdateItemCartRequest updateItemCartRequest) async {
    var response = await appClient.dioAuth(getLocalAccessToken().accessToken!).put(
        ApiEndPointFactory.jancargoServerEndPoint.getUrlQueryApi(AppPath.updateItemCart),
        data: updateItemCartRequest.toJson(),
    ).onError((dios.DioError error, stackTrace) =>
        ErrorMiddleHandler.handleDioError(error));
    ErrorMiddleHandler.log(response);

    if (response.statusCode == HttpStatus.ok) {
      var dto = response.data["success"] == true ? true : false;
      return dto;
    }
    throw ServerException();
  }

  Future<CalculateCartDto> getCalculatePrice({required PriceCalculateCartRequest request}) async {
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
      CalculateCartDto dto = CalculateCartDto.fromJson(response.data);
      return dto;
    }

    throw ServerException();
  }

}