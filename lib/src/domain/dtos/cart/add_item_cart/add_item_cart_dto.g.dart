// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_item_cart_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddItemCartDto _$AddItemCartDtoFromJson(Map<String, dynamic> json) =>
    AddItemCartDto(
      data: json['data'] == null
          ? null
          : AddCartDto.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AddItemCartDtoToJson(AddItemCartDto instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

AddCartDto _$AddCartDtoFromJson(Map<String, dynamic> json) => AddCartDto(
      idi: json['_id'] as String?,
      siteCode: json['site_code'] as String?,
      code: json['code'] as String?,
      name: json['name'] as String?,
      url: json['url'] as String?,
      qty: json['qty'] as int?,
      price: json['price'] as int?,
      currency: json['currency'] as String?,
      sku: json['sku'] as String?,
      description: json['description'] as String?,
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      shipMode: json['ship_mode'] as String?,
      status: json['status'] as bool?,
      userId: json['user_id'] as String?,
      selected: json['selected'] as bool?,
      options: json['options'] as List<dynamic>?,
      createdDate: json['created_date'] as String?,
      expireAt: json['expireAt'] as String?,
      v: json['__v'] as int?,
    );

Map<String, dynamic> _$AddCartDtoToJson(AddCartDto instance) =>
    <String, dynamic>{
      '_id': instance.idi,
      'site_code': instance.siteCode,
      'code': instance.code,
      'name': instance.name,
      'url': instance.url,
      'qty': instance.qty,
      'price': instance.price,
      'currency': instance.currency,
      'sku': instance.sku,
      'description': instance.description,
      'images': instance.images,
      'ship_mode': instance.shipMode,
      'status': instance.status,
      'user_id': instance.userId,
      'selected': instance.selected,
      'options': instance.options,
      'created_date': instance.createdDate,
      'expireAt': instance.expireAt,
      '__v': instance.v,
    };
