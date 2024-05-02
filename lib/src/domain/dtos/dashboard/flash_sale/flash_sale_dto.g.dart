// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flash_sale_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FlashSaleDto _$FlashSaleDtoFromJson(Map<String, dynamic> json) => FlashSaleDto(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ItemSaleDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FlashSaleDtoToJson(FlashSaleDto instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

ItemSaleDto _$ItemSaleDtoFromJson(Map<String, dynamic> json) => ItemSaleDto(
      isItemSavedCart: json['isItemSavedCart'] as bool?,
      discountRate: json['discount_rate'] as int?,
      id: json['id'] as String?,
      guid: json['guid'] as String?,
      reviewUrl: json['review_url'] as String?,
      store: json['store'] == null
          ? null
          : StoreDto.fromJson(json['store'] as Map<String, dynamic>),
      code: json['code'] as String?,
      image: json['image'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      category: json['category'] as String?,
      price: json['price'] as int?,
      availability: json['availability'],
      tax: json['tax'] as String?,
      creditCard: json['creditCard'] as String?,
      postage: json['postage'] as String?,
      review: (json['review'] as num?)?.toDouble(),
      reviewCount: json['review_count'] as int?,
      url: json['url'] as String?,
      tagIds: json['tagIds'] as String?,
      thumbnails: (json['thumbnails'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      endTime: json['endTime'] as String?,
      startTime: json['startTime'] as String?,
    );

Map<String, dynamic> _$ItemSaleDtoToJson(ItemSaleDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'guid': instance.guid,
      'code': instance.code,
      'image': instance.image,
      'isItemSavedCart': instance.isItemSavedCart,
      'name': instance.name,
      'discount_rate': instance.discountRate,
      'description': instance.description,
      'category': instance.category,
      'price': instance.price,
      'availability': instance.availability,
      'tax': instance.tax,
      'creditCard': instance.creditCard,
      'postage': instance.postage,
      'review': instance.review,
      'review_count': instance.reviewCount,
      'review_url': instance.reviewUrl,
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
