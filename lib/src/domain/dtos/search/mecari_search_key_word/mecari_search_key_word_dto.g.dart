// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mecari_search_key_word_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MercariSearchKeyWordDto _$MercariSearchKeyWordDtoFromJson(
        Map<String, dynamic> json) =>
    MercariSearchKeyWordDto(
      products: (json['products'] as List<dynamic>?)
          ?.map((e) =>
              MercariSearchKeyWordItemDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MercariSearchKeyWordDtoToJson(
        MercariSearchKeyWordDto instance) =>
    <String, dynamic>{
      'products': instance.products,
    };

MercariSearchKeyWordItemDto _$MercariSearchKeyWordItemDtoFromJson(
        Map<String, dynamic> json) =>
    MercariSearchKeyWordItemDto(
      id: json['id'] as String?,
      code: json['code'] as String?,
      name: json['name'] as String?,
      image: json['image'] as String?,
      price: json['price'] as int?,
      numComments: json['num_comments'] as int?,
      numLikes: json['num_likes'] as int?,
      pagerId: json['pager_id'] as int?,
      buyerId: json['buyer_id'] as String?,
      status: json['status'] as String?,
      url: json['url'] as String?,
      itemType: json['item_type'] as String?,
    );

Map<String, dynamic> _$MercariSearchKeyWordItemDtoToJson(
        MercariSearchKeyWordItemDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'name': instance.name,
      'image': instance.image,
      'price': instance.price,
      'num_comments': instance.numComments,
      'num_likes': instance.numLikes,
      'pager_id': instance.pagerId,
      'buyer_id': instance.buyerId,
      'status': instance.status,
      'url': instance.url,
      'item_type': instance.itemType,
    };
