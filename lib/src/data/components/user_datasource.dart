// import 'dart:html';
//
// import 'package:dio/dio.dart' as dios;
// import 'package:injectable/injectable.dart';
//
// import '../../core/exception.dart';
// import '../datasource/base/base_datasource.dart';
// import '../remote/api-endpoint.dart';
// import '../remote/api_endpoint/api_end_point_factory.dart';
// import '../remote/middle-handler/error-handler.dart';
//
// @Singleton()
// class UserSource extends BaseDateSource {
//
//   Future<TopShopDto> topShop({required LoadItemRequest request}) async {
//     var response = await appClient.dioAuth(getLocalAccessToken().accessToken!)
//         .post(
//       ApiEndPointFactory.jancargoServerEndPoint.getUrlQueryApi(
//           AppPath.houseOfSale),
//       queryParameters: request.toJson(),
//     )
//         .onError((dios.DioError error, stackTrace) =>
//         ErrorMiddleHandler.handleDioError(error));
//     ErrorMiddleHandler.log(response);
//
//     if (response.statusCode == HttpStatus.ok) {
//       TopShopDto dto = TopShopDto.fromJson(response.data["data"]);
//       return dto;
//     }
//
//     throw ServerException();
//   }
// }