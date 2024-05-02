// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auction_off_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuctionOffRequest _$AuctionOffRequestFromJson(Map<String, dynamic> json) =>
    AuctionOffRequest(
      saleId: json['sale_id'] as String?,
      lastMinuteToBid: json['last_minute_to_bid'] as String?,
      mode: json['mode'] as String?,
      price: json['price'] as String?,
      code: json['code'] as String?,
      name: json['name'] as String?,
      url: json['url'] as String?,
      tax: json['tax'] as String?,
      shipMode: json['ship_mode'] as String?,
      shippingCharges: json['shipping_charges'] as String?,
      exchangeRate: json['exchange_rate'] as String?,
      currency: json['currency'] as String?,
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      serviceExtra: (json['service_extra'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      bids: json['bids'] as int?,
      endTime: json['end_time'] as String?,
      reputationLevel: json['reputation_level'] as String?,
      qty: json['qty'] as String?,
      sellerId: json['seller_id'] as String?,
      paymentMethods: (json['payment_methods'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      partial: json['partial'] as String?,
      items: json['user_id'] as String?,
    );

Map<String, dynamic> _$AuctionOffRequestToJson(AuctionOffRequest instance) =>
    <String, dynamic>{
      'user_id': instance.items,
      'price': instance.price,
      'code': instance.code,
      'name': instance.name,
      'url': instance.url,
      'tax': instance.tax,
      'ship_mode': instance.shipMode,
      'shipping_charges': instance.shippingCharges,
      'exchange_rate': instance.exchangeRate,
      'currency': instance.currency,
      'images': instance.images,
      'service_extra': instance.serviceExtra,
      'bids': instance.bids,
      'end_time': instance.endTime,
      'reputation_level': instance.reputationLevel,
      'qty': instance.qty,
      'seller_id': instance.sellerId,
      'payment_methods': instance.paymentMethods,
      'mode': instance.mode,
      'last_minute_to_bid': instance.lastMinuteToBid,
      'sale_id': instance.saleId,
      'partial': instance.partial,
    };
