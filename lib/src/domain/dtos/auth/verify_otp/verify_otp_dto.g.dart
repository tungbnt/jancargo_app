// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_otp_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyOtpDto _$VerifyOtpDtoFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['token'],
  );
  return VerifyOtpDto(
    success: json['success'] as bool,
    token: json['token'] as String,
  );
}

Map<String, dynamic> _$VerifyOtpDtoToJson(VerifyOtpDto instance) =>
    <String, dynamic>{
      'success': instance.success,
      'token': instance.token,
    };
