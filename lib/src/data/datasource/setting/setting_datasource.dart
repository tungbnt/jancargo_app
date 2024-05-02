import 'dart:io';

import 'package:dio/dio.dart' as dios;
import 'package:injectable/injectable.dart';

import '../../../core/exception.dart';
import '../../object_request_api/request_change/request_change_pass.dart';
import '../../remote/api-endpoint.dart';
import '../../remote/api_endpoint/api_end_point_factory.dart';
import '../../remote/middle-handler/error-handler.dart';
import '../base/base_datasource.dart';

@Singleton()
class SettingSource extends BaseDateSource {
  Future<bool> changePass(ChangePassRequest request) async {
    var response = await appClient
        .dioNonAuth()
        .get(
          ApiEndPointFactory.jancargoServerEndPoint
              .getUrlQueryApi(AppPath.changePass),
          data: request.toJson(),
        )
        .onError((dios.DioError error, stackTrace) =>
            ErrorMiddleHandler.handleDioError(error));
    ErrorMiddleHandler.log(response);

    if (response.statusCode == HttpStatus.ok) {
      bool dto = response.data["success"];
      return dto;
    }

    throw ServerException();
  }
}
