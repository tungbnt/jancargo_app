// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rakuten_resolver_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RakutenResolverDto _$RakutenResolverDtoFromJson(Map<String, dynamic> json) =>
    RakutenResolverDto(
      result: json['result'] == null
          ? null
          : RakutenResolverResultDto.fromJson(
              json['result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RakutenResolverDtoToJson(RakutenResolverDto instance) =>
    <String, dynamic>{
      'result': instance.result,
    };

RakutenResolverResultDto _$RakutenResolverResultDtoFromJson(
        Map<String, dynamic> json) =>
    RakutenResolverResultDto(
      jancargoUrl: json['jancargo_url'] as String?,
      me: json['meta'] == null
          ? null
          : MetaRakutenResolverResultDto.fromJson(
              json['meta'] as Map<String, dynamic>),
      price: (json['price'] as num?)?.toDouble(),
      productId: json['product_id'] as String?,
      productName: json['product_name'] as String?,
      quantity: json['quantity'] as int?,
      shopId: json['shop_id'] as String?,
      shopUrl: json['shop_url'] as String?,
      url: json['url'] as String?,
    );

Map<String, dynamic> _$RakutenResolverResultDtoToJson(
        RakutenResolverResultDto instance) =>
    <String, dynamic>{
      'jancargo_url': instance.jancargoUrl,
      'meta': instance.me,
      'price': instance.price,
      'product_id': instance.productId,
      'product_name': instance.productName,
      'quantity': instance.quantity,
      'shop_id': instance.shopId,
      'shop_url': instance.shopUrl,
      'url': instance.url,
    };

MetaRakutenResolverResultDto _$MetaRakutenResolverResultDtoFromJson(
        Map<String, dynamic> json) =>
    MetaRakutenResolverResultDto(
      hightPrice: (json['hight_price'] as num?)?.toDouble(),
      lowPrice: (json['low_price'] as num?)?.toDouble(),
      price: (json['price'] as num?)?.toDouble(),
      priceCurrency: json['price_currency'] as String?,
    );

Map<String, dynamic> _$MetaRakutenResolverResultDtoToJson(
        MetaRakutenResolverResultDto instance) =>
    <String, dynamic>{
      'hight_price': instance.hightPrice,
      'low_price': instance.lowPrice,
      'price': instance.price,
      'price_currency': instance.priceCurrency,
    };
