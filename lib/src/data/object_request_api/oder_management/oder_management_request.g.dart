// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'oder_management_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OderManagementRequest _$OderManagementRequestFromJson(
        Map<String, dynamic> json) =>
    OderManagementRequest(
      size: json['size'] as int?,
      page: json['page'] as int?,
      from: json['from'] as String?,
      to: json['to'] as String?,
      step: (json['step'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$OderManagementRequestToJson(
        OderManagementRequest instance) =>
    <String, dynamic>{
      'size': instance.size,
      'page': instance.page,
      'from': instance.from,
      'to': instance.to,
      'step': instance.step,
    };
