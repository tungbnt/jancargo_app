// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseUserDto _$BaseUserDtoFromJson(Map<String, dynamic> json) => BaseUserDto(
      accessToken: json['access_token'] as String?,
      expiresIn: json['expires_in'] as int?,
      refreshToken: json['refresh_token'] as String?,
    );

Map<String, dynamic> _$BaseUserDtoToJson(BaseUserDto instance) =>
    <String, dynamic>{
      'access_token': instance.accessToken,
      'expires_in': instance.expiresIn,
      'refresh_token': instance.refreshToken,
    };
