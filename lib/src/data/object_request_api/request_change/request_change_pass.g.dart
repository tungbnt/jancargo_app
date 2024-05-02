// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_change_pass.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestForgetPass _$RequestForgetPassFromJson(Map<String, dynamic> json) =>
    RequestForgetPass(
      phoneOrEmail: json['phoneOrEmail'] as String?,
      step: json['step'] as String?,
      otp: json['otp'] as String?,
    );

Map<String, dynamic> _$RequestForgetPassToJson(RequestForgetPass instance) =>
    <String, dynamic>{
      'phoneOrEmail': instance.phoneOrEmail,
      'step': instance.step,
      'otp': instance.otp,
    };

ChangePassRequest _$ChangePassRequestFromJson(Map<String, dynamic> json) =>
    ChangePassRequest(
      confirmNewPassword: json['ConfirmNewPassword'] as String?,
      newPassword: json['NewPassword'] as String?,
      oldPassword: json['OldPassword'] as String?,
      id: json['id'] as String?,
    );

Map<String, dynamic> _$ChangePassRequestToJson(ChangePassRequest instance) =>
    <String, dynamic>{
      'ConfirmNewPassword': instance.confirmNewPassword,
      'NewPassword': instance.newPassword,
      'OldPassword': instance.oldPassword,
      'id': instance.id,
    };
