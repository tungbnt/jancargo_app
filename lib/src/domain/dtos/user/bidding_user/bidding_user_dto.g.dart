// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bidding_user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BiddingDto _$BiddingDtoFromJson(Map<String, dynamic> json) => BiddingDto(
      success: json['success'] as bool?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => BiddingUserDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BiddingDtoToJson(BiddingDto instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
    };

BiddingUserDto _$BiddingUserDtoFromJson(Map<String, dynamic> json) =>
    BiddingUserDto(
      id: json['_id'] as String?,
      account: json['account'] as String?,
      winner: json['winner'] as bool?,
      code: json['code'] as String?,
      name: json['name'] as String?,
      qty: json['qty'] as int?,
      partial: json['partial'] as String?,
      price: json['price'] as int?,
      snipePrice: json['snipe_price'] as int?,
      servicesExtra: (json['services_extra'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      mode: json['mode'] as String?,
      shipMode: json['ship_mode'] as String?,
      endTime: json['end_time'] as String?,
      lastMinuteToBid: json['last_minute_to_bid'] as int?,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$BiddingUserDtoToJson(BiddingUserDto instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'account': instance.account,
      'winner': instance.winner,
      'code': instance.code,
      'name': instance.name,
      'qty': instance.qty,
      'partial': instance.partial,
      'price': instance.price,
      'snipe_price': instance.snipePrice,
      'services_extra': instance.servicesExtra,
      'mode': instance.mode,
      'ship_mode': instance.shipMode,
      'end_time': instance.endTime,
      'last_minute_to_bid': instance.lastMinuteToBid,
      'image': instance.image,
    };
