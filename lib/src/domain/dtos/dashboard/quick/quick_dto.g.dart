// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quick_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuickDto _$QuickDtoFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['results', 'pagination'],
  );
  return QuickDto(
    pagination: json['pagination'] == null
        ? null
        : PaginationDto.fromJson(json['pagination'] as Map<String, dynamic>),
    results: (json['results'] as List<dynamic>?)
        ?.map((e) => QuickTypeDto.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$QuickDtoToJson(QuickDto instance) => <String, dynamic>{
      'results': instance.results,
      'pagination': instance.pagination,
    };

QuickTypeDto _$QuickTypeDtoFromJson(Map<String, dynamic> json) => QuickTypeDto(
      createdDate: json['created_date'] as String?,
      id: json['_id'] as String?,
      url: json['url'] as String?,
      slug: json['slug'] as String?,
      type: json['type'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      position: json['position'] as int?,
      status: json['status'] as bool?,
      deleted: json['deleted'] as bool?,
      icon: json['icon'] as String?,
      updateDate: json['update_date'] as String?,
      idM: json['id'] as String?,
    );

Map<String, dynamic> _$QuickTypeDtoToJson(QuickTypeDto instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'url': instance.url,
      'slug': instance.slug,
      'type': instance.type,
      'name': instance.name,
      'description': instance.description,
      'position': instance.position,
      'status': instance.status,
      'deleted': instance.deleted,
      'created_date': instance.createdDate,
      'icon': instance.icon,
      'update_date': instance.updateDate,
      'id': instance.idM,
    };

PaginationDto _$PaginationDtoFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['size', 'page', 'total'],
  );
  return PaginationDto(
    size: json['size'] as int?,
    page: json['page'] as int?,
    total: json['total'] as int?,
  );
}

Map<String, dynamic> _$PaginationDtoToJson(PaginationDto instance) =>
    <String, dynamic>{
      'size': instance.size,
      'page': instance.page,
      'total': instance.total,
    };
