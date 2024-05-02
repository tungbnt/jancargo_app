
import 'dart:io';

import 'package:dio/dio.dart' as dios;
import 'package:injectable/injectable.dart';

import '../../../core/exception.dart';
import '../../../domain/dtos/detail_product/seller_auction/seller_auction_dto.dart';
import '../../../domain/dtos/seller/seller_mercari/seller_mercari_dto.dart';
import '../../remote/api-endpoint.dart';
import '../../remote/api_endpoint/api_end_point_factory.dart';
import '../../remote/middle-handler/error-handler.dart';
import '../base/base_datasource.dart';


@Singleton()
class SellerDataSource extends BaseDateSource {

  //seller auction
  Future<SellerDetailAuctionDto> sellerAuction(String code) async {
    var response = await appClient.dioNonAuth().get(
      ApiEndPointFactory.jancargoServerEndPoint.getUrlQueryApi("${AppPath.auctionSeller}/products?code=$code&seller_id=$code"),
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
  //seller mercari
  Future<SellerDetailMercariDto> sellerMercari(String code,String name) async {
    var response = await appClient.dioNonAuth().get(
      ApiEndPointFactory.jancargoServerEndPoint.getUrlQueryApi("${AppPath.mercariSeller}/$code?type=${name == 'mercari' ? "" : 'MER_SHOP'}"),
    ).onError((dios.DioError error, stackTrace) =>
        ErrorMiddleHandler.handleDioError(error));
    ErrorMiddleHandler.log(response);

    if (response.statusCode == HttpStatus.ok) {
      SellerDetailMercariDto dto = SellerDetailMercariDto.fromJson(response.data);
      return dto;
    }

    throw ServerException();
  }
}