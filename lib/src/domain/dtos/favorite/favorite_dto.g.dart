// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavoriteDto _$FavoriteDtoFromJson(Map<String, dynamic> json) => FavoriteDto(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => FavoriteItems.fromJson(e as Map<String, dynamic>))
          .toList(),
      message: json['message'] as String?,
      code: json['code'] as int?,
    );

Map<String, dynamic> _$FavoriteDtoToJson(FavoriteDto instance) =>
    <String, dynamic>{
      'data': instance.data,
      'message': instance.message,
      'code': instance.code,
    };

FavoriteSearchDto _$FavoriteSearchDtoFromJson(Map<String, dynamic> json) =>
    FavoriteSearchDto(
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => FavoriteItems.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FavoriteSearchDtoToJson(FavoriteSearchDto instance) =>
    <String, dynamic>{
      'results': instance.results,
    };

FavoriteItems _$FavoriteItemsFromJson(Map<String, dynamic> json) =>
    FavoriteItems(
      id: json['_id'] as String?,
      v: json['__v'] as int?,
      createdDate: json['created_date'] as String?,
      userId: json['user_id'] as String?,
      status: json['status'] as bool?,
      deleted: json['deleted'] as bool?,
      liked: json['liked'] as int?,
      sku: json['sku'] as String?,
      siteCode: json['site_code'] as String?,
      code: json['code'] as String?,
      name: json['name'] as String?,
      url: json['url'] as String?,
      price: json['price'] as int?,
      currency: json['currency'] as String?,
      qty: json['qty'] as int?,
      endTime: json['end_time'] as String?,
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$FavoriteItemsToJson(FavoriteItems instance) =>
    <String, dynamic>{
      'site_code': instance.siteCode,
      'code': instance.code,
      'name': instance.name,
      'url': instance.url,
      'price': instance.price,
      'currency': instance.currency,
      'qty': instance.qty,
      'end_time': instance.endTime,
      'images': instance.images,
      '_id': instance.id,
      '__v': instance.v,
      'created_date': instance.createdDate,
      'user_id': instance.userId,
      'status': instance.status,
      'deleted': instance.deleted,
      'liked': instance.liked,
      'sku': instance.sku,
    };
