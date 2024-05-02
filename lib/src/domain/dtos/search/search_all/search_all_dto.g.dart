// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_all_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchAllDto _$SearchAllDtoFromJson(Map<String, dynamic> json) => SearchAllDto(
      data: (json['results'] as List<dynamic>?)
          ?.map((e) => AllSearchs.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: json['query'] as String?,
    );

Map<String, dynamic> _$SearchAllDtoToJson(SearchAllDto instance) =>
    <String, dynamic>{
      'results': instance.data,
      'query': instance.meta,
    };

AllSearchs _$AllSearchsFromJson(Map<String, dynamic> json) => AllSearchs(
      products: (json['products'] as List<dynamic>?)
          ?.map((e) => AllSearchItems.fromJson(e as Map<String, dynamic>))
          .toList(),
      type: json['type'] as String?,
      total: json['total'] as int?,
    );

Map<String, dynamic> _$AllSearchsToJson(AllSearchs instance) =>
    <String, dynamic>{
      'products': instance.products,
      'total': instance.total,
      'type': instance.type,
    };

AllSearchItems _$AllSearchItemsFromJson(Map<String, dynamic> json) =>
    AllSearchItems(
      code: json['code'] as String?,
      name: json['name'] as String?,
      url: json['url'] as String?,
      image: json['image'] as String?,
      price: json['price'] as int?,
      priceBuy: json['price_buy'],
      endTime: json['end_time'] as String?,
      sellerId: json['seller_id'] as String?,
      bids: json['bids'] as int?,
      newW: json['new'] as bool?,
      used: json['used'] as bool?,
      freeship: json['freeship'] as bool?,
      itemType: json['item_type'] as String?,
    );

Map<String, dynamic> _$AllSearchItemsToJson(AllSearchItems instance) =>
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
      'used': instance.used,
      'freeship': instance.freeship,
      'item_type': instance.itemType,
    };
