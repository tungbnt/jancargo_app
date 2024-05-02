// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rakuten_search_key_word_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RakutenSearchKeyWordDto _$RakutenSearchKeyWordDtoFromJson(
        Map<String, dynamic> json) =>
    RakutenSearchKeyWordDto(
      results: (json['results'] as List<dynamic>?)
          ?.map((e) =>
              RakutenItemsSearchKeyWordDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RakutenSearchKeyWordDtoToJson(
        RakutenSearchKeyWordDto instance) =>
    <String, dynamic>{
      'results': instance.results,
    };

RakutenItemsSearchKeyWordDto _$RakutenItemsSearchKeyWordDtoFromJson(
        Map<String, dynamic> json) =>
    RakutenItemsSearchKeyWordDto(
      code: json['code'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      category: json['category'] as String?,
      price: json['price'] as int?,
      availability: json['availability'] as int?,
      tax: json['tax'] as int?,
      creditCard: json['creditCard'] as int?,
      postage: json['postage'] as int?,
      review: (json['review'] as num?)?.toDouble(),
      reviewCount: json['reviewCount'] as int?,
      url: json['url'] as String?,
      tagIds: json['tagIds'] as List<dynamic>?,
      thumbnails: (json['thumbnails'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      image: json['image'] as String?,
      endTime: json['endTime'] as String?,
      startTime: json['startTime'] as String?,
      store: json['store'] == null
          ? null
          : RakutenStoreSearchKeyWordDto.fromJson(
              json['store'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RakutenItemsSearchKeyWordDtoToJson(
        RakutenItemsSearchKeyWordDto instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'description': instance.description,
      'category': instance.category,
      'price': instance.price,
      'availability': instance.availability,
      'tax': instance.tax,
      'creditCard': instance.creditCard,
      'postage': instance.postage,
      'review': instance.review,
      'reviewCount': instance.reviewCount,
      'url': instance.url,
      'tagIds': instance.tagIds,
      'thumbnails': instance.thumbnails,
      'image': instance.image,
      'endTime': instance.endTime,
      'startTime': instance.startTime,
      'store': instance.store,
    };

RakutenStoreSearchKeyWordDto _$RakutenStoreSearchKeyWordDtoFromJson(
        Map<String, dynamic> json) =>
    RakutenStoreSearchKeyWordDto(
      code: json['code'] as String?,
      name: json['name'] as String?,
      url: json['url'] as String?,
    );

Map<String, dynamic> _$RakutenStoreSearchKeyWordDtoToJson(
        RakutenStoreSearchKeyWordDto instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'url': instance.url,
    };
