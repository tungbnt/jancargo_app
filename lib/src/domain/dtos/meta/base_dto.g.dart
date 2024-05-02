// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseDto _$BaseDtoFromJson(Map<String, dynamic> json) => BaseDto(
      json['status'] as bool? ?? false,
      json['message'] as String? ?? '',
    );

Map<String, dynamic> _$BaseDtoToJson(BaseDto instance) => <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
    };
