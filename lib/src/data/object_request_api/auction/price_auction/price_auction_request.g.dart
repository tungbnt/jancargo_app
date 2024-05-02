// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'price_auction_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PriceRequest _$PriceRequestFromJson(Map<String, dynamic> json) => PriceRequest(
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => PriceAuctionRequest.fromJson(e as Map<String, dynamic>))
          .toList(),
      routeCode: json['route_code'] as String?,
    );

Map<String, dynamic> _$PriceRequestToJson(PriceRequest instance) =>
    <String, dynamic>{
      'items': instance.items,
      'route_code': instance.routeCode,
    };

PriceCalculateCartRequest _$PriceCalculateCartRequestFromJson(
        Map<String, dynamic> json) =>
    PriceCalculateCartRequest(
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => CalculateCartRequest.fromJson(e as Map<String, dynamic>))
          .toList(),
      routeCode: json['route_code'] as String?,
    );

Map<String, dynamic> _$PriceCalculateCartRequestToJson(
        PriceCalculateCartRequest instance) =>
    <String, dynamic>{
      'items': instance.items,
      'route_code': instance.routeCode,
    };

CalculateCartRequest _$CalculateCartRequestFromJson(
        Map<String, dynamic> json) =>
    CalculateCartRequest(
      price: json['price'] as int?,
      qty: json['qty'] as int?,
      routeCode: json['route_code'] as String?,
      tax: json['tax'] as int?,
      weight: json['weight'] as int?,
      exchangeRate: json['exchange_rate'] as int?,
      mode: json['mode'] as int?,
      originCountryShippingFee: json['origin_country_shipping_fee'] as int?,
    );

Map<String, dynamic> _$CalculateCartRequestToJson(
        CalculateCartRequest instance) =>
    <String, dynamic>{
      'exchange_rate': instance.exchangeRate,
      'mode': instance.mode,
      'origin_country_shipping_fee': instance.originCountryShippingFee,
      'price': instance.price,
      'qty': instance.qty,
      'route_code': instance.routeCode,
      'tax': instance.tax,
      'weight': instance.weight,
    };

PriceAuctionRequest _$PriceAuctionRequestFromJson(Map<String, dynamic> json) =>
    PriceAuctionRequest(
      price: json['price'] as int?,
      tax: json['tax'] as int?,
      qty: json['qty'] as int?,
    );

Map<String, dynamic> _$PriceAuctionRequestToJson(
        PriceAuctionRequest instance) =>
    <String, dynamic>{
      'price': instance.price,
      'tax': instance.tax,
      'qty': instance.qty,
    };
