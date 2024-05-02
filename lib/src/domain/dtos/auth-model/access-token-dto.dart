import 'package:jancargo_app/src/core/exception.dart';

class AccessTokenDto {
  String? accessToken;

  AccessTokenDto(this.accessToken) {
    if (accessToken == null || accessToken!.isEmpty) {
      throw InputInvalidException();
    }
  }
}
