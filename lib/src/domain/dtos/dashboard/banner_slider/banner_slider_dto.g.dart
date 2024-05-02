// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'banner_slider_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BannerSliderDto _$BannerSliderDtoFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['results', 'pagination'],
  );
  return BannerSliderDto(
    results: (json['results'] as List<dynamic>?)
        ?.map((e) => BannerDto.fromJson(e as Map<String, dynamic>))
        .toList(),
    pagination: json['pagination'] == null
        ? null
        : PaginationDto.fromJson(json['pagination'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$BannerSliderDtoToJson(BannerSliderDto instance) =>
    <String, dynamic>{
      'results': instance.results,
      'pagination': instance.pagination,
    };

BannerDto _$BannerDtoFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['_id', 'type'],
  );
  return BannerDto(
    id: json['_id'] as String?,
    type: json['type'] as String?,
    name: json['name'] as String?,
    typePage: json['type_page'] as String?,
    btnType: json['btn_type'] as String?,
    url: json['url'] as String?,
    image: json['image'] as String?,
    status: json['status'] as bool?,
    deleted: json['deleted'] as bool?,
    v: json['__v'] as int?,
    idM: json['id'] as String?,
    lastViewed: json['created_date'] as String?,
  );
}

Map<String, dynamic> _$BannerDtoToJson(BannerDto instance) => <String, dynamic>{
      '_id': instance.id,
      'type': instance.type,
      'name': instance.name,
      'type_page': instance.typePage,
      'btn_type': instance.btnType,
      'url': instance.url,
      'image': instance.image,
      'status': instance.status,
      'deleted': instance.deleted,
      'created_date': instance.lastViewed,
      '__v': instance.v,
      'id': instance.idM,
    };

PaginationDto _$PaginationDtoFromJson(Map<String, dynamic> json) =>
    PaginationDto(
      size: json['size'] as int?,
      page: json['page'] as int?,
      total: json['total'] as int?,
    );

Map<String, dynamic> _$PaginationDtoToJson(PaginationDto instance) =>
    <String, dynamic>{
      'size': instance.size,
      'page': instance.page,
      'total': instance.total,
    };
