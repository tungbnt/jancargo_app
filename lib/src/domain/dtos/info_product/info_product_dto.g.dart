// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'info_product_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InfoProductDto _$InfoProductDtoFromJson(Map<String, dynamic> json) =>
    InfoProductDto(
      sellerId: json['seller'] as String?,
      percent: json['percent'] as String?,
      code: json['code'] as String?,
      url: json['url'] as String?,
      name: json['name'] as String?,
      price: json['price'] as int?,
      tax: json['tax'] as int?,
      priceBuy: json['price_buy'] as int?,
      taxBuy: json['tax_buy'] as int?,
      feeShip: json['feeship'] as int?,
      fromOutsideOfapan: json['from_outside_of_japan'] as bool?,
      thumbnails: (json['thumbnails'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      description: json['description'] as String?,
      qty: json['qty'] as int?,
      categoryId: json['category_id'] as String?,
      startDate: json['start_date'] as String?,
      endDate: json['end_date'] as String?,
      earlyClose: json['early_close'] as bool?,
      autoExtension: json['auto_extension'] as bool?,
      returnable: json['returnable'] as bool?,
      biderRestriction: json['bider_restriction'] as bool?,
      bidderVerification: json['bidder_verification'] as bool?,
      initPrice: json['init_price'] as int?,
      condition: json['condition'] as String?,
      bids: json['bids'] as int?,
      postage: json['postage'] as bool?,
      finished: json['finished'] as bool?,
      wonInfo: json['won_info'],
      timeLeft: json['time_left'] as int?,
      endTime: json['end_time'] as String?,
    );

Map<String, dynamic> _$InfoProductDtoToJson(InfoProductDto instance) =>
    <String, dynamic>{
      'code': instance.code,
      'url': instance.url,
      'name': instance.name,
      'price': instance.price,
      'tax': instance.tax,
      'price_buy': instance.priceBuy,
      'tax_buy': instance.taxBuy,
      'feeship': instance.feeShip,
      'from_outside_of_japan': instance.fromOutsideOfapan,
      'thumbnails': instance.thumbnails,
      'description': instance.description,
      'qty': instance.qty,
      'category_id': instance.categoryId,
      'start_date': instance.startDate,
      'end_date': instance.endDate,
      'early_close': instance.earlyClose,
      'auto_extension': instance.autoExtension,
      'returnable': instance.returnable,
      'bider_restriction': instance.biderRestriction,
      'bidder_verification': instance.bidderVerification,
      'init_price': instance.initPrice,
      'condition': instance.condition,
      'bids': instance.bids,
      'postage': instance.postage,
      'finished': instance.finished,
      'won_info': instance.wonInfo,
      'time_left': instance.timeLeft,
      'end_time': instance.endTime,
      'seller': instance.sellerId,
      'percent': instance.percent,
    };
