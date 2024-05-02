import 'dart:io';
import 'dart:async';
import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:jancargo_app/src/domain/dtos/auth-model/access-token-dto.dart';
import 'package:jancargo_app/src/general/constants/app_constants.dart';


class NetworkConfig {
  Box hiveBox = Hive.box(AppConstants.APP_NAME_ID);
  AccessTokenDto getLocalAccessToken() {
    final accessToken =
        hiveBox.get(AppConstants.ACCESS_TOKEN, defaultValue: null);
    if (accessToken == null) {
      throw Exception();
    }
    return AccessTokenDto(accessToken);
  }

  Future<ApiResponse> getWebCall(String url) async {
    try {
      var response = await http
          .get(
        Uri.parse(url),
      )
          .timeout(
        const Duration(
          seconds: 30,
        ),
        onTimeout: () async {
          throw TimeoutException(
            'The connection has timed out, Please check your internet connection health and try again!',
          );
        },
      );
      return _checkResponse(response);
    } on SocketException {
      return ApiResponse(
          done: false,
          errorMsg: "Please check your internet connection",
          responseString: null);
    }
  }

  Future<ApiResponse> getWebTokenCall(String url) async {
    print(url);
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${getLocalAccessToken().accessToken!}',
    };
    try {
      var response = await http
          .get(
        Uri.parse(
          url,
        ),
        headers: headers,
      )
          .timeout(
        const Duration(
          seconds: 5,
        ),
        onTimeout: () async {
          throw TimeoutException(
            'The connection has timed out, Please check your internet connection health and try again!',
          );
        },
      );
      return _checkResponse(response);
    } on SocketException {
      return ApiResponse(
          done: false,
          errorMsg: "Please check your internet connection",
          responseString: null);
    }
  }

  Future postWebCall(String url, Map map) async {
    try {
      var response = await http
          .post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(map),
      )
          .timeout(
        const Duration(
          seconds: 30,
        ),
        onTimeout: () async {
          throw TimeoutException(
              'The connection has timed out, Please check your internet connection health and try again!');
        },
      );

      return _checkResponse(response);
    } on SocketException {
      return ApiResponse(
        done: false,
        errorMsg: "Please check your internet connection",
        responseString: null,
      );
    }
  }

  Future postWebCallWithToken(String url, Map map) async {
    try {
      var response = await http
          .post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${getLocalAccessToken().accessToken!}',
        },
        body: jsonEncode(map),
      )
          .timeout(
        const Duration(
          seconds: 30,
        ),
        onTimeout: () async {
          throw TimeoutException(
              'The connection has timed out, Please check your internet connection health and try again!');
        },
      );

      return _checkResponse(response);
    } on SocketException {
      return ApiResponse(
        done: false,
        errorMsg: "Please check your internet connection",
        responseString: null,
      );
    }
  }

  ApiResponse _checkResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return ApiResponse(
          done: true,
          errorMsg: null,
          responseString: response.body,
        );
      case 400:
        return ApiResponse(
          done: true,
          errorMsg: "Bad request",
          responseString: response.body,
        );
      case 401:
        return ApiResponse(
          done: false,
          errorMsg: "Unauthorized request",
          responseString: null,
        );
      case 403:
        return ApiResponse(
          done: false,
          errorMsg: "Unauthorized request",
          responseString: null,
        );
      case 404:
        return ApiResponse(
          done: true,
          errorMsg: "Page not found",
          responseString: response.body,
        );
      case 500:
        return ApiResponse(
          done: false,
          errorMsg: "Server Error",
          responseString: null,
        );
      default:
        return ApiResponse(
            done: false,
            errorMsg: "Error occured while Communication with or timeout",
            responseString: null);
    }
  }
}

class ApiResponse {
  String? responseString;
  String? errorMsg;
  bool? done;

  ApiResponse({this.done, this.errorMsg, this.responseString});
}
