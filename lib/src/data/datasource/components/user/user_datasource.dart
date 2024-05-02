import 'dart:io';

import 'package:dio/dio.dart' as dios;
import 'package:injectable/injectable.dart';
import 'package:jancargo_app/src/data/object_request_api/list_request/list_request.dart';
import 'package:jancargo_app/src/domain/dtos/user/location_user/location_user_dto.dart';
import 'package:jancargo_app/src/domain/dtos/user/voucher/voucher_dto.dart';

import '../../../../core/exception.dart';
import '../../../../domain/dtos/user/address_user/address_user_dto.dart';
import '../../../../domain/dtos/user/service_extras/service_extras_dto.dart';
import '../../../object_request_api/payment_oder/payment_oder_request.dart';
import '../../../remote/api-endpoint.dart';
import '../../../remote/api_endpoint/api_end_point_factory.dart';
import '../../../remote/middle-handler/error-handler.dart';
import '../../base/base_datasource.dart';



@Singleton()
class UserSource extends BaseDateSource {
  Future<ProvinceDto> getProvince() async {
    var response = await appClient
        .dioAuth(getLocalAccessToken().accessToken!)
        .get(
      ApiEndPointFactory.jancargoServerEndPoint
          .getUrlQueryApi(AppPath.getProvinces),
    )
        .onError((dios.DioError error, stackTrace) =>
        ErrorMiddleHandler.handleDioError(error));
    ErrorMiddleHandler.log(response);

    if (response.statusCode == HttpStatus.ok) {
      ProvinceDto dto = ProvinceDto.fromJson(response.data);
      return dto;
    }

    throw ServerException();
  }
  Future<DistrictDto> getDistrict(String provinceID) async {
    var response = await appClient
        .dioAuth(getLocalAccessToken().accessToken!)
        .get(
      ApiEndPointFactory.jancargoServerEndPoint
          .getUrlQueryApi('${AppPath.getDistrict}/$provinceID' ),
    )
        .onError((dios.DioError error, stackTrace) =>
        ErrorMiddleHandler.handleDioError(error));
    ErrorMiddleHandler.log(response);

    if (response.statusCode == HttpStatus.ok) {
      DistrictDto dto = DistrictDto.fromJson(response.data);
      return dto;
    }

    throw ServerException();
  }
  Future<WardDto> getWard(String districtId) async {
    var response = await appClient
        .dioAuth(getLocalAccessToken().accessToken!)
        .get(
      ApiEndPointFactory.jancargoServerEndPoint
          .getUrlQueryApi('${AppPath.getWard}/$districtId'),
    )
        .onError((dios.DioError error, stackTrace) =>
        ErrorMiddleHandler.handleDioError(error));
    ErrorMiddleHandler.log(response);

    if (response.statusCode == HttpStatus.ok) {
      WardDto dto = WardDto.fromJson(response.data);
      return dto;
    }

    throw ServerException();
  }
  Future<AddressUserDto> getAddressUser() async {
    var response = await appClient
        .dioAuth(getLocalAccessToken().accessToken!)
        .get(
      ApiEndPointFactory.jancargoServerEndPoint
          .getUrlQueryApi(AppPath.getAddressUser),
    )
        .onError((dios.DioError error, stackTrace) =>
        ErrorMiddleHandler.handleDioError(error));
    ErrorMiddleHandler.log(response);

    if (response.statusCode == HttpStatus.ok) {
      AddressUserDto dto = AddressUserDto.fromJson(response.data);
      return dto;
    }

    throw ServerException();
  }
  Future<bool> editAddress(ItemsAddressUser item) async {
    var response = await appClient
        .dioAuth(getLocalAccessToken().accessToken!)
        .put(
      ApiEndPointFactory.jancargoServerEndPoint
          .getUrlQueryApi('${AppPath.editAddressUser}/${item.id}'),
      data: item.toJson()..removeWhere((key, value) => value == null),
    )
        .onError((dios.DioError error, stackTrace) =>
        ErrorMiddleHandler.handleDioError(error));
    ErrorMiddleHandler.log(response);

    if (response.statusCode == HttpStatus.ok) {
      bool dto = response.data["data"]["acknowledged"];
      return dto;
    }

    throw ServerException();
  }

  Future<ItemsAddressUser> addAddress(ItemsAddressUser item) async {
    var response = await appClient
        .dioAuth(getLocalAccessToken().accessToken!)
        .put(
      ApiEndPointFactory.jancargoServerEndPoint
          .getUrlQueryApi(AppPath.addAddressUser),
      data: item.toJson()..removeWhere((key, value) => value == null),
    )
        .onError((dios.DioError error, stackTrace) =>
        ErrorMiddleHandler.handleDioError(error));
    ErrorMiddleHandler.log(response);

    if (response.statusCode == HttpStatus.ok) {
      ItemsAddressUser dto = ItemsAddressUser.fromJson(response.data["data"]) ;
      return dto;
    }

    throw ServerException();
  }

  Future<ServiceExtrasDto> getServiceExtras() async {
    var response = await appClient
        .dioAuth(getLocalAccessToken().accessToken!)
        .get(
      ApiEndPointFactory.jancargoServerEndPoint
          .getUrlQueryApi(AppPath.getServiceExtras),
    )
        .onError((dios.DioError error, stackTrace) =>
        ErrorMiddleHandler.handleDioError(error));
    ErrorMiddleHandler.log(response);

    if (response.statusCode == HttpStatus.ok) {
      ServiceExtrasDto dto = ServiceExtrasDto.fromJson(response.data);
      return dto;
    }

    throw ServerException();
  }

  Future<ServiceExtrasDto> confirmPaymentOder({required PaymentOderRequest request}) async {
    var response = await appClient
        .dioAuth(getLocalAccessToken().accessToken!)
        .post(
      ApiEndPointFactory.jancargoServerEndPoint
          .getUrlQueryApi(AppPath.confirmPaymentOder),
      data: request.toJson(),
    )
        .onError((dios.DioError error, stackTrace) =>
        ErrorMiddleHandler.handleDioError(error));
    ErrorMiddleHandler.log(response);

    if (response.statusCode == HttpStatus.ok) {
      ServiceExtrasDto dto = ServiceExtrasDto.fromJson(response.data);
      return dto;
    }

    throw ServerException();
  }

  Future<VoucherDto> getCoupon({required ListRequest request}) async {
    var response = await appClient
        .dioAuth(getLocalAccessToken().accessToken!)
        .get(
      ApiEndPointFactory.jancargoServerEndPoint
          .getUrlQueryApi(AppPath.getCoupon),
      queryParameters: request.toJson()..removeWhere((key, value) => value == null),
    )
        .onError((dios.DioError error, stackTrace) =>
        ErrorMiddleHandler.handleDioError(error));
    ErrorMiddleHandler.log(response);

    if (response.statusCode == HttpStatus.ok) {
      VoucherDto dto = VoucherDto.fromJson(response.data);
      return dto;
    }

    throw ServerException();
  }
}