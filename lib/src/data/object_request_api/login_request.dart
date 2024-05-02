import 'package:json_annotation/json_annotation.dart';
part 'login_request.g.dart';

@JsonSerializable()
class LoginRequest {
  @JsonKey(name: 'grant_type', defaultValue: 'password')
  final String? grantType;
  @JsonKey(name: 'username')
  final String? username;
  @JsonKey(name: 'password')
  final String? password;
  @JsonKey(
      name: 'scopes', defaultValue: 'openid profile full_access offline_access')
  final String? scopes;
  @JsonKey(name: 'client_id', defaultValue: 'jancargo-client-mobile-web')
  final String? clientId;
  @JsonKey(name: 'client_secret', defaultValue: 'jancargo@12354\$')
  final String? clientSecret;
  @JsonKey(name: 'provider',)
  final String? provider;
  @JsonKey(name: 'token_id',)
  final String? tokenId;

  LoginRequest({
    this.grantType,
    this.username,
    this.password,
    this.scopes,
    this.clientId,
    this.clientSecret,
    this.provider,
    this.tokenId,
  });
  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);
}
