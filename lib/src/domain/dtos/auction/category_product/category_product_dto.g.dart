// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_product_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryDto _$CategoryDtoFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['data'],
  );
  return CategoryDto(
    data: (json['data'] as List<dynamic>?)
        ?.map((e) => CategoryProductDto.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$CategoryDtoToJson(CategoryDto instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

CategoryProductDto _$CategoryProductDtoFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['category', 'results'],
  );
  return CategoryProductDto(
    category: json['category'] as String?,
    results: (json['results'] as List<dynamic>?)
        ?.map((e) => CategoryProductItemDto.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$CategoryProductDtoToJson(CategoryProductDto instance) =>
    <String, dynamic>{
      'category': instance.category,
      'results': instance.results,
    };

CategoryProductItemDto _$CategoryProductItemDtoFromJson(
        Map<String, dynamic> json) =>
    CategoryProductItemDto(
      favorite:
          CategoryProductItemDto._favoriteFromJson(json['favorite'] as bool?),
      code: json['code'] as String?,
      name: json['name'] as String?,
      url: json['url'] as String?,
      image: json['image'] as String?,
      price: json['price'] as int?,
      priceBuy: json['price_buy'] as int?,
      endTime: json['end_time'] as String?,
      sellerId: json['seller_id'] as String?,
      bids: json['bids'] as String?,
      newW: json['new'] as bool?,
      freeship: json['freeship'] as bool?,
      used: json['used'] as bool?,
    );

Map<String, dynamic> _$CategoryProductItemDtoToJson(
        CategoryProductItemDto instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'url': instance.url,
      'image': instance.image,
      'price': instance.price,
      'price_buy': instance.priceBuy,
      'end_time': instance.endTime,
      'seller_id': instance.sellerId,
      'bids': instance.bids,
      'new': instance.newW,
      'freeship': instance.freeship,
      'used': instance.used,
      'favorite': CategoryProductItemDto._favoriteToJson(instance.favorite),
    };
