// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterRequest _$RegisterRequestFromJson(Map<String, dynamic> json) =>
    RegisterRequest(
      shortName: json['short_name'] as String? ?? 'password',
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String? ?? '',
      confirmPassword: json['confirmPassword'] as String? ?? '',
      captcha: json['captcha'] as String? ?? '',
      typeMode: json['type_mode'] as String? ?? '',
    );

Map<String, dynamic> _$RegisterRequestToJson(RegisterRequest instance) =>
    <String, dynamic>{
      'short_name': instance.shortName,
      'phone': instance.phone,
      'email': instance.email,
      'password': instance.password,
      'confirmPassword': instance.confirmPassword,
      'captcha': instance.captcha,
      'type_mode': instance.typeMode,
    };
