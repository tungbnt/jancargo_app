// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quick_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuickRequest _$QuickRequestFromJson(Map<String, dynamic> json) => QuickRequest(
      status: json['status'] as String?,
      page: json['page'] as String?,
      size: json['size'] as String?,
    );

Map<String, dynamic> _$QuickRequestToJson(QuickRequest instance) =>
    <String, dynamic>{
      'page': instance.page,
      'size': instance.size,
      'status': instance.status,
    };
