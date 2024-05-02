import 'package:jancargo_app/src/domain/dtos/auth-model/access-token-dto.dart';
import 'package:jancargo_app/src/domain/dtos/auth-model/auth-code-request-dto.dart';

abstract class RemoteDataSource {
  Future<AccessTokenDto> getAccessToken(AuthCodeRequestDto authCode);
  Future<bool> logout(String accessToken);
}
