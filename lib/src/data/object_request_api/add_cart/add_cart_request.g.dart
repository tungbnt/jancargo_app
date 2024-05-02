// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_cart_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddCartRequest _$AddCartRequestFromJson(Map<String, dynamic> json) =>
    AddCartRequest(
      siteCode: json['site_code'] as String?,
      code: json['code'] as String?,
      name: json['name'] as String?,
      url: json['url'] as String?,
      price: json['price'] as int?,
      currency: json['currency'] as String?,
      qty: json['qty'] as int?,
      description: json['description'] as String?,
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      shipMode: json['ship_mode'] as String?,
    );

Map<String, dynamic> _$AddCartRequestToJson(AddCartRequest instance) =>
    <String, dynamic>{
      'site_code': instance.siteCode,
      'code': instance.code,
      'name': instance.name,
      'url': instance.url,
      'price': instance.price,
      'currency': instance.currency,
      'qty': instance.qty,
      'description': instance.description,
      'images': instance.images,
      'ship_mode': instance.shipMode,
    };
