// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'relates_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RelateDto _$RelateDtoFromJson(Map<String, dynamic> json) => RelateDto(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => RelatesDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RelateDtoToJson(RelateDto instance) => <String, dynamic>{
      'data': instance.data,
    };

RelatesDto _$RelatesDtoFromJson(Map<String, dynamic> json) => RelatesDto(
      json['index'] as int?,
      json['bids'],
      json['code'],
      json['end_time'] as String?,
      json['freeship'] as bool?,
      json['closing'] as bool?,
      json['image'] as String?,
      json['name'] as String?,
      json['new'] as bool?,
      json['price'] as int?,
      json['price_buy'],
      json['seller_id'] as String?,
      json['url'] as String?,
      json['used'] as bool?,
      json['type'] as String?,
    );

Map<String, dynamic> _$RelatesDtoToJson(RelatesDto instance) =>
    <String, dynamic>{
      'index': instance.index,
      'bids': instance.bids,
      'code': instance.code,
      'end_time': instance.endTime,
      'freeship': instance.freeShip,
      'closing': instance.closing,
      'image': instance.image,
      'name': instance.name,
      'new': instance.neww,
      'price': instance.price,
      'price_buy': instance.priceBuy,
      'seller_id': instance.sellerId,
      'url': instance.url,
      'used': instance.used,
      'type': instance.type,
    };
