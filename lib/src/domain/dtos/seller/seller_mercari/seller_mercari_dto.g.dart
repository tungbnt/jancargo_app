// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seller_mercari_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SellerDetailMercariDto _$SellerDetailMercariDtoFromJson(
        Map<String, dynamic> json) =>
    SellerDetailMercariDto(
      code: json['code'] as int?,
      data: json['data'] == null
          ? null
          : SellerMercariDto.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SellerDetailMercariDtoToJson(
        SellerDetailMercariDto instance) =>
    <String, dynamic>{
      'code': instance.code,
      'data': instance.data,
    };

SellerMercariDto _$SellerMercariDtoFromJson(Map<String, dynamic> json) =>
    SellerMercariDto(
      products: (json['products'] as List<dynamic>?)
          ?.map(
              (e) => ItemsSellerMercariDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      seller: json['seller'] == null
          ? null
          : InfoSellerMercariDto.fromJson(
              json['seller'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SellerMercariDtoToJson(SellerMercariDto instance) =>
    <String, dynamic>{
      'products': instance.products,
      'seller': instance.seller,
    };

ItemsSellerMercariDto _$ItemsSellerMercariDtoFromJson(
        Map<String, dynamic> json) =>
    ItemsSellerMercariDto(
      id: json['id'] as String?,
      code: json['code'] as String?,
      name: json['name'] as String?,
      image: json['image'] as String?,
      price: json['price'] as int?,
      numComments: json['num_comments'] as int?,
      numLikes: json['num_likes'] as int?,
      pagerId: json['pager_id'] as int?,
      status: json['status'] as String?,
      url: json['url'] as String?,
      itemType: json['item_type'] as String?,
    );

Map<String, dynamic> _$ItemsSellerMercariDtoToJson(
        ItemsSellerMercariDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'name': instance.name,
      'image': instance.image,
      'price': instance.price,
      'num_comments': instance.numComments,
      'num_likes': instance.numLikes,
      'pager_id': instance.pagerId,
      'status': instance.status,
      'url': instance.url,
      'item_type': instance.itemType,
    };

InfoSellerMercariDto _$InfoSellerMercariDtoFromJson(
        Map<String, dynamic> json) =>
    InfoSellerMercariDto(
      id: json['id'] as String?,
      name: json['name'] as String?,
      follower: json['follower'] as int?,
      following: json['following'] as int?,
      rating: (json['rating'] as num?)?.toDouble(),
      sell: json['sell'] as int?,
      ratings: json['ratings'] == null
          ? null
          : RattingSellerMercariDto.fromJson(
              json['ratings'] as Map<String, dynamic>),
      score: json['score'] as int?,
      star: (json['star'] as num?)?.toDouble(),
      avatar: json['avatar'] as String?,
      introduction: json['introduction'] as String?,
      url: json['url'] as String?,
    );

Map<String, dynamic> _$InfoSellerMercariDtoToJson(
        InfoSellerMercariDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'follower': instance.follower,
      'following': instance.following,
      'rating': instance.rating,
      'sell': instance.sell,
      'ratings': instance.ratings,
      'score': instance.score,
      'star': instance.star,
      'avatar': instance.avatar,
      'introduction': instance.introduction,
      'url': instance.url,
    };

RattingSellerMercariDto _$RattingSellerMercariDtoFromJson(
        Map<String, dynamic> json) =>
    RattingSellerMercariDto(
      good: (json['good'] as num?)?.toDouble(),
      bad: (json['bad'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$RattingSellerMercariDtoToJson(
        RattingSellerMercariDto instance) =>
    <String, dynamic>{
      'good': instance.good,
      'bad': instance.bad,
    };
