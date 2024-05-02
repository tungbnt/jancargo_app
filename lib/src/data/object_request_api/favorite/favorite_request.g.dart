// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavoriteRequest _$FavoriteRequestFromJson(Map<String, dynamic> json) =>
    FavoriteRequest(
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

Map<String, dynamic> _$FavoriteRequestToJson(FavoriteRequest instance) =>
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
    };
