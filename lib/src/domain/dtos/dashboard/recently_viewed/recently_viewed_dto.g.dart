// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recently_viewed_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecentlyDto _$RecentlyDtoFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['results', 'pagination'],
  );
  return RecentlyDto(
    result: (json['results'] as List<dynamic>?)
        ?.map((e) => RecentlyViewedDto.fromJson(e as Map<String, dynamic>))
        .toList(),
    pagination: json['pagination'] == null
        ? null
        : PaginationDto.fromJson(json['pagination'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$RecentlyDtoToJson(RecentlyDto instance) =>
    <String, dynamic>{
      'results': instance.result,
      'pagination': instance.pagination,
    };

RecentlyViewedDto _$RecentlyViewedDtoFromJson(Map<String, dynamic> json) =>
    RecentlyViewedDto(
      v: json['__v'] as int?,
      idM: json['id'] as String?,
      price: json['price'] as int?,
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      id: json['_id'] as String?,
      userId: json['user_id'] as String?,
      productId: json['product_id'] as String?,
      productName: json['product_name'] as String?,
      productUrl: json['product_url'] as String?,
      currencyUnit: json['currency_unit'] as String?,
      source: json['source'] as String?,
      createdBy: json['created_by'] as String?,
      createdDate: json['created_date'] as String?,
      lastViewed: json['last_viewed'] as String?,
    );

Map<String, dynamic> _$RecentlyViewedDtoToJson(RecentlyViewedDto instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'user_id': instance.userId,
      'product_id': instance.productId,
      'product_name': instance.productName,
      'product_url': instance.productUrl,
      'currency_unit': instance.currencyUnit,
      'source': instance.source,
      'created_by': instance.createdBy,
      'created_date': instance.createdDate,
      'last_viewed': instance.lastViewed,
      '__v': instance.v,
      'id': instance.idM,
      'price': instance.price,
      'images': instance.images,
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
