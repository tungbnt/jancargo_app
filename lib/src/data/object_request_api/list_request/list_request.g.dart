// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListRequest _$ListRequestFromJson(Map<String, dynamic> json) => ListRequest(
      size: json['size'] as String?,
      page: json['page'] as String?,
      search: json['search'] as String?,
    );

Map<String, dynamic> _$ListRequestToJson(ListRequest instance) =>
    <String, dynamic>{
      'size': instance.size,
      'page': instance.page,
      'search': instance.search,
    };
