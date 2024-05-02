// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_oder_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateOderRequest _$CreateOderRequestFromJson(Map<String, dynamic> json) =>
    CreateOderRequest(
      address: json['address'] == null
          ? null
          : AddressCreateOderRequest.fromJson(
              json['address'] as Map<String, dynamic>),
      quotes: (json['quotes'] as List<dynamic>?)
          ?.map((e) =>
              QuotesCreateOderRequest.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CreateOderRequestToJson(CreateOderRequest instance) =>
    <String, dynamic>{
      'address': instance.address,
      'quotes': instance.quotes,
    };

AddressCreateOderRequest _$AddressCreateOderRequestFromJson(
        Map<String, dynamic> json) =>
    AddressCreateOderRequest(
      createdAt: json['created_at'] as String?,
      deleted: json['deleted'] as bool?,
      district: json['district'] as String?,
      districtId: json['district_id'] as int?,
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      primary: json['primary'] as bool?,
      province: json['province'] as String?,
      provinceId: json['province_id'] as int?,
      status: json['status'] as bool?,
      type: json['type'] as String?,
      updatedAt: json['updated_at'] as String?,
      user: json['user'] as String?,
      ward: json['ward'] as String?,
      wardId: json['ward_id'] as int?,
      v: json['__v'] as int?,
      id: json['_id'] as int?,
      address: json['address'] as String?,
    );

Map<String, dynamic> _$AddressCreateOderRequestToJson(
        AddressCreateOderRequest instance) =>
    <String, dynamic>{
      'address': instance.address,
      'created_at': instance.createdAt,
      'deleted': instance.deleted,
      'district': instance.district,
      'district_id': instance.districtId,
      'name': instance.name,
      'phone': instance.phone,
      'primary': instance.primary,
      'province': instance.province,
      'province_id': instance.provinceId,
      'status': instance.status,
      'type': instance.type,
      'updated_at': instance.updatedAt,
      'user': instance.user,
      'ward': instance.ward,
      'ward_id': instance.wardId,
      '__v': instance.v,
      '_id': instance.id,
    };

QuotesCreateOderRequest _$QuotesCreateOderRequestFromJson(
        Map<String, dynamic> json) =>
    QuotesCreateOderRequest(
      allow: json['allow'] as bool?,
      currency: json['currency'] as String?,
      exchangeRate: json['exchange_rate'] as int?,
      goodsValues: json['goods_values'] as int?,
      link: json['link'] as String?,
      name: json['name'] as String?,
      note: json['note'] as String?,
      percentRate: (json['percent_rate'] as num?)?.toDouble(),
      quality: json['quality'] as int?,
      routeCode: json['route_code'] as String?,
      servicesExtra: (json['services_extra'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      shipMode: json['ship_mode'] as String?,
      webCode: json['web_code'] as String?,
      weight: (json['weight'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$QuotesCreateOderRequestToJson(
        QuotesCreateOderRequest instance) =>
    <String, dynamic>{
      'allow': instance.allow,
      'currency': instance.currency,
      'exchange_rate': instance.exchangeRate,
      'goods_values': instance.goodsValues,
      'link': instance.link,
      'name': instance.name,
      'note': instance.note,
      'percent_rate': instance.percentRate,
      'quality': instance.quality,
      'route_code': instance.routeCode,
      'services_extra': instance.servicesExtra,
      'ship_mode': instance.shipMode,
      'web_code': instance.webCode,
      'weight': instance.weight,
    };
