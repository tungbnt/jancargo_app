// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'top_shop_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopShopDto _$TopShopDtoFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['results', 'pagination'],
  );
  return TopShopDto(
    results: (json['results'] as List<dynamic>?)
        ?.map((e) => ShopDto.fromJson(e as Map<String, dynamic>))
        .toList(),
    pagination: json['pagination'] == null
        ? null
        : PaginationDto.fromJson(json['pagination'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$TopShopDtoToJson(TopShopDto instance) =>
    <String, dynamic>{
      'results': instance.results,
      'pagination': instance.pagination,
    };

ShopDto _$ShopDtoFromJson(Map<String, dynamic> json) => ShopDto(
      id: json['_id'] as String?,
      code: json['code'] as String?,
      image: json['image'] as String?,
      name: json['name'] as String?,
      productUrl: json['product_type'] as String?,
      siteCode: json['site_code'] as String?,
      view: json['view'] as int?,
    );

Map<String, dynamic> _$ShopDtoToJson(ShopDto instance) => <String, dynamic>{
      '_id': instance.id,
      'code': instance.code,
      'image': instance.image,
      'name': instance.name,
      'product_type': instance.productUrl,
      'site_code': instance.siteCode,
      'view': instance.view,
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
