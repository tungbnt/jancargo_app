// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth-code-request-dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthCodeRequestDto _$AuthCodeRequestDtoFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['code', 'code_verifier'],
  );
  return AuthCodeRequestDto(
    code: json['code'] as String,
    codeVerifier: json['code_verifier'] as String,
  );
}

Map<String, dynamic> _$AuthCodeRequestDtoToJson(AuthCodeRequestDto instance) =>
    <String, dynamic>{
      'code': instance.code,
      'code_verifier': instance.codeVerifier,
    };
