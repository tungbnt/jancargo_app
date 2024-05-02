// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paypay_search_keyword_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaypaySearchKeyWordDto _$PaypaySearchKeyWordDtoFromJson(
        Map<String, dynamic> json) =>
    PaypaySearchKeyWordDto(
      results: (json['results'] as List<dynamic>?)
          ?.map((e) =>
              PaypayItemsSearchKeyWordDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PaypaySearchKeyWordDtoToJson(
        PaypaySearchKeyWordDto instance) =>
    <String, dynamic>{
      'results': instance.results,
    };

PaypayItemsSearchKeyWordDto _$PaypayItemsSearchKeyWordDtoFromJson(
        Map<String, dynamic> json) =>
    PaypayItemsSearchKeyWordDto(
      code: json['code'] as String?,
      name: json['name'] as String?,
      image: json['image'] as String?,
      price: json['price'] as int?,
      url: json['url'] as String?,
      status: json['status'] as String?,
      seller: json['seller'] == null
          ? null
          : PaypaySellerSearchKeyWordDto.fromJson(
              json['seller'] as Map<String, dynamic>),
      category: json['category'] == null
          ? null
          : PaypayCategorySearchKeyWordDto.fromJson(
              json['category'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PaypayItemsSearchKeyWordDtoToJson(
        PaypayItemsSearchKeyWordDto instance) =>
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

PaypaySellerSearchKeyWordDto _$PaypaySellerSearchKeyWordDtoFromJson(
        Map<String, dynamic> json) =>
    PaypaySellerSearchKeyWordDto(
      id: json['id'] as String?,
      goodRatio: (json['goodRatio'] as num?)?.toDouble(),
      numRating: (json['numRating'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$PaypaySellerSearchKeyWordDtoToJson(
        PaypaySellerSearchKeyWordDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'goodRatio': instance.goodRatio,
      'numRating': instance.numRating,
    };

PaypayCategorySearchKeyWordDto _$PaypayCategorySearchKeyWordDtoFromJson(
        Map<String, dynamic> json) =>
    PaypayCategorySearchKeyWordDto(
      productCategoryId: json['productCategoryId'] as int?,
      id: json['id'] as int?,
      name: json['named'] as String?,
      path: (json['path'] as List<dynamic>?)
          ?.map((e) => PaypayCategoryPathSearchKeyWordDto.fromJson(
              e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PaypayCategorySearchKeyWordDtoToJson(
        PaypayCategorySearchKeyWordDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'named': instance.name,
      'productCategoryId': instance.productCategoryId,
      'path': instance.path,
    };

PaypayCategoryPathSearchKeyWordDto _$PaypayCategoryPathSearchKeyWordDtoFromJson(
        Map<String, dynamic> json) =>
    PaypayCategoryPathSearchKeyWordDto(
      id: json['id'] as int?,
      name: json['named'] as String?,
    );

Map<String, dynamic> _$PaypayCategoryPathSearchKeyWordDtoToJson(
        PaypayCategoryPathSearchKeyWordDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'named': instance.name,
    };
