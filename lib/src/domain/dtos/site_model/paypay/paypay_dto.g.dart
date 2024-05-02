// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paypay_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaypayDto _$PaypayDtoFromJson(Map<String, dynamic> json) => PaypayDto(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => PaypaysDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PaypayDtoToJson(PaypayDto instance) => <String, dynamic>{
      'data': instance.data,
    };

PaypaysDto _$PaypaysDtoFromJson(Map<String, dynamic> json) => PaypaysDto(
      category: json['category'],
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => ItemPaypay.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PaypaysDtoToJson(PaypaysDto instance) =>
    <String, dynamic>{
      'category': instance.category,
      'results': instance.results,
    };

ItemPaypay _$ItemPaypayFromJson(Map<String, dynamic> json) => ItemPaypay(
      code: json['code'] as String?,
      name: json['name'] as String?,
      image: json['image'] as String?,
      price: json['price'] as int?,
      url: json['url'] as String?,
      status: json['status'] as String?,
      seller: json['seller'] == null
          ? null
          : SellerItemPaypay.fromJson(json['seller'] as Map<String, dynamic>),
      category: json['category'] == null
          ? null
          : CategoryItemPaypay.fromJson(
              json['category'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ItemPaypayToJson(ItemPaypay instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'image': instance.image,
      'price': instance.price,
      'url': instance.url,
      'status': instance.status,
      'seller': instance.seller,
      'category': instance.category,
    };

SellerItemPaypay _$SellerItemPaypayFromJson(Map<String, dynamic> json) =>
    SellerItemPaypay(
      id: json['id'] as String?,
      numRating: json['numRating'] as int?,
      goodRatio: (json['goodRatio'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$SellerItemPaypayToJson(SellerItemPaypay instance) =>
    <String, dynamic>{
      'id': instance.id,
      'goodRatio': instance.goodRatio,
      'numRating': instance.numRating,
    };

CategoryItemPaypay _$CategoryItemPaypayFromJson(Map<String, dynamic> json) =>
    CategoryItemPaypay(
      id: json['id'],
      name: json['name'] as String?,
      path: (json['path'] as List<dynamic>?)
          ?.map(
              (e) => PathCategoryItemPaypay.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CategoryItemPaypayToJson(CategoryItemPaypay instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'path': instance.path,
    };

PathCategoryItemPaypay _$PathCategoryItemPaypayFromJson(
        Map<String, dynamic> json) =>
    PathCategoryItemPaypay(
      id: json['id'],
      name: json['name'] as String?,
    );

Map<String, dynamic> _$PathCategoryItemPaypayToJson(
        PathCategoryItemPaypay instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

MapItemPaypay _$MapItemPaypayFromJson(Map<String, dynamic> json) =>
    MapItemPaypay(
      category: json['category'] as String?,
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => ItemPaypay.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MapItemPaypayToJson(MapItemPaypay instance) =>
    <String, dynamic>{
      'category': instance.category,
      'items': instance.items,
    };
