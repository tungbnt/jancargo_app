// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_rakuten_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchRakutenDto _$SearchRakutenDtoFromJson(Map<String, dynamic> json) =>
    SearchRakutenDto(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => RakutensDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SearchRakutenDtoToJson(SearchRakutenDto instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

RakutensDto _$RakutensDtoFromJson(Map<String, dynamic> json) => RakutensDto(
      isItemSavedCart: json['isItemSavedCart'] as bool?,
      store: json['store'] == null
          ? null
          : StoreDto.fromJson(json['store'] as Map<String, dynamic>),
      code: json['code'] as String?,
      image: json['image'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      category: json['category'] as String?,
      price: json['price'] as int?,
      availability: json['availability'] as int?,
      tax: json['tax'] as int?,
      creditCard: json['creditCard'] as int?,
      postage: json['postage'] as int?,
      review: (json['review'] as num?)?.toDouble(),
      reviewCount: json['review_count'] as int?,
      url: json['url'] as String?,
      tagIds: (json['tagIds'] as List<dynamic>?)?.map((e) => e as int).toList(),
      thumbnails: (json['thumbnails'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      endTime: json['endTime'] as String?,
      startTime: json['startTime'] as String?,
    );

Map<String, dynamic> _$RakutensDtoToJson(RakutensDto instance) =>
    <String, dynamic>{
      'code': instance.code,
      'image': instance.image,
      'isItemSavedCart': instance.isItemSavedCart,
      'name': instance.name,
      'description': instance.description,
      'category': instance.category,
      'price': instance.price,
      'availability': instance.availability,
      'tax': instance.tax,
      'creditCard': instance.creditCard,
      'postage': instance.postage,
      'review': instance.review,
      'review_count': instance.reviewCount,
      'url': instance.url,
      'tagIds': instance.tagIds,
      'thumbnails': instance.thumbnails,
      'endTime': instance.endTime,
      'startTime': instance.startTime,
      'store': instance.store,
    };

StoreDto _$StoreDtoFromJson(Map<String, dynamic> json) => StoreDto(
      code: json['code'] as String?,
      name: json['name'] as String?,
      url: json['url'] as String?,
    );

Map<String, dynamic> _$StoreDtoToJson(StoreDto instance) => <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'url': instance.url,
    };
