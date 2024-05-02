// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_cart_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartDto _$CartDtoFromJson(Map<String, dynamic> json) => CartDto(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ItemCartDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CartDtoToJson(CartDto instance) => <String, dynamic>{
      'data': instance.data,
    };

ItemCartDto _$ItemCartDtoFromJson(Map<String, dynamic> json) => ItemCartDto(
      id: json['_id'] as String?,
      siteCode: json['site_code'] as String?,
      code: json['code'] as String?,
      name: json['name'] as String?,
      url: json['url'] as String?,
      qty: json['qtyy'] as int?,
      price: json['price'] as int?,
      currency: json['currency'] as String?,
      sku: json['sku'] as String?,
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      shipMode: json['ship_mode'] as String?,
      status: json['status'] as bool?,
      deleted: json['deleted'] as bool?,
      userId: json['user_id'] as String?,
      options: json['options'] as List<dynamic>?,
      createdDate: json['created_date'] as String?,
      expireAt: json['expireAt'] as String?,
      v: json['__v'] as int?,
      isSelected: ItemCartDto._selectedFromJson(json['selected'] as bool?),
      selectedAmount: ItemCartDto._selectedAmountFromJson(json['qty'] as int?),
      selectedShip:
          ItemCartDto._selectedShipFromJson(json['selectedShip'] as int?),
      selectedService:
          ItemCartDto._selectedServiceFromJson(json['selectedService'] as int?),
    );

Map<String, dynamic> _$ItemCartDtoToJson(ItemCartDto instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'site_code': instance.siteCode,
      'code': instance.code,
      'name': instance.name,
      'url': instance.url,
      'qtyy': instance.qty,
      'qty': ItemCartDto._selectedAmountToJson(instance.selectedAmount),
      'selectedShip': ItemCartDto._selectedShipToJson(instance.selectedShip),
      'selectedService':
          ItemCartDto._selectedServiceToJson(instance.selectedService),
      'price': instance.price,
      'currency': instance.currency,
      'sku': instance.sku,
      'images': instance.images,
      'ship_mode': instance.shipMode,
      'status': instance.status,
      'deleted': instance.deleted,
      'user_id': instance.userId,
      'selected': ItemCartDto._selectedToJson(instance.isSelected),
      'options': instance.options,
      'created_date': instance.createdDate,
      'expireAt': instance.expireAt,
      '__v': instance.v,
    };

GroupCartsDto _$GroupCartsDtoFromJson(Map<String, dynamic> json) =>
    GroupCartsDto(
      code: json['code'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ItemCartDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    )..isSelected = GroupCartsDto._selectedFromJson(json['selected'] as bool?);

Map<String, dynamic> _$GroupCartsDtoToJson(GroupCartsDto instance) =>
    <String, dynamic>{
      'data': instance.data,
      'code': instance.code,
      'selected': GroupCartsDto._selectedToJson(instance.isSelected),
    };
