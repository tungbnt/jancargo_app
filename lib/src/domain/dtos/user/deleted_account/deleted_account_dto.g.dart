// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deleted_account_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeletedAccountDto _$DeletedAccountDtoFromJson(Map<String, dynamic> json) =>
    DeletedAccountDto(
      success: json['success'] as bool?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$DeletedAccountDtoToJson(DeletedAccountDto instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
    };
