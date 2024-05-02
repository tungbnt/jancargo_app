// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginRequest _$LoginRequestFromJson(Map<String, dynamic> json) => LoginRequest(
      grantType: json['grant_type'] as String? ?? 'password',
      username: json['username'] as String?,
      password: json['password'] as String?,
      scopes: json['scopes'] as String? ??
          'openid profile full_access offline_access',
      clientId: json['client_id'] as String? ?? 'jancargo-client-mobile-web',
      clientSecret: json['client_secret'] as String? ?? r'jancargo@12354$',
      provider: json['provider'] as String?,
      tokenId: json['token_id'] as String?,
    );

Map<String, dynamic> _$LoginRequestToJson(LoginRequest instance) =>
    <String, dynamic>{
      'grant_type': instance.grantType,
      'username': instance.username,
      'password': instance.password,
      'scopes': instance.scopes,
      'client_id': instance.clientId,
      'client_secret': instance.clientSecret,
      'provider': instance.provider,
      'token_id': instance.tokenId,
    };
