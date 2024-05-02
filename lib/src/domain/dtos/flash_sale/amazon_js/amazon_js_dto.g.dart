// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'amazon_js_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AmazonJsFlashSaleDto _$AmazonJsFlashSaleDtoFromJson(
        Map<String, dynamic> json) =>
    AmazonJsFlashSaleDto(
      success: json['success'] as bool?,
      products: (json['products'] as List<dynamic>?)
          ?.map((e) =>
              ItemsAmazonJsFlashSaleDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AmazonJsFlashSaleDtoToJson(
        AmazonJsFlashSaleDto instance) =>
    <String, dynamic>{
      'success': instance.success,
      'products': instance.products,
    };

ItemsAmazonJsFlashSaleDto _$ItemsAmazonJsFlashSaleDtoFromJson(
        Map<String, dynamic> json) =>
    ItemsAmazonJsFlashSaleDto(
      id: json['id'] as String?,
      code: json['code'] as String?,
      isProduct: json['is_product'] as bool?,
      itemType: json['item_type'] as String?,
      url: json['url'] as String?,
      title: json['title'] as String?,
      type: json['type'] as String?,
      startTime: json['start_time'] as String?,
      endTime: json['end_time'] as String?,
      image: json['image'] as String?,
      price: json['price'] == null
          ? null
          : PriceAmazonJsFlashSaleDto.fromJson(
              json['price'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ItemsAmazonJsFlashSaleDtoToJson(
        ItemsAmazonJsFlashSaleDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'is_product': instance.isProduct,
      'item_type': instance.itemType,
      'url': instance.url,
      'title': instance.title,
      'type': instance.type,
      'start_time': instance.startTime,
      'end_time': instance.endTime,
      'image': instance.image,
      'price': instance.price,
    };

PriceAmazonJsFlashSaleDto _$PriceAmazonJsFlashSaleDtoFromJson(
        Map<String, dynamic> json) =>
    PriceAmazonJsFlashSaleDto(
      basisPrice: json['basis_price'],
      dealPrice: json['deal_price'] == null
          ? null
          : DealPriceAmazonJsFlashSaleDto.fromJson(
              json['deal_price'] as Map<String, dynamic>),
      savingsAmount: (json['savings_amount'] as num?)?.toDouble(),
      savingsPercent: (json['savings_percent'] as num?)?.toDouble(),
      savingsMax: json['savings_max'] == null
          ? null
          : MaxSavingPriceAmazonJsFlashSaleDto.fromJson(
              json['savings_max'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PriceAmazonJsFlashSaleDtoToJson(
        PriceAmazonJsFlashSaleDto instance) =>
    <String, dynamic>{
      'basis_price': instance.basisPrice,
      'deal_price': instance.dealPrice,
      'savings_amount': instance.savingsAmount,
      'savings_percent': instance.savingsPercent,
      'savings_max': instance.savingsMax,
    };

DealPriceAmazonJsFlashSaleDto _$DealPriceAmazonJsFlashSaleDtoFromJson(
        Map<String, dynamic> json) =>
    DealPriceAmazonJsFlashSaleDto(
      range: json['range'],
    );

Map<String, dynamic> _$DealPriceAmazonJsFlashSaleDtoToJson(
        DealPriceAmazonJsFlashSaleDto instance) =>
    <String, dynamic>{
      'range': instance.range,
    };

RangeDealPriceAmazonJsFlashSaleDto _$RangeDealPriceAmazonJsFlashSaleDtoFromJson(
        Map<String, dynamic> json) =>
    RangeDealPriceAmazonJsFlashSaleDto(
      max: json['max'] == null
          ? null
          : MaxDealPriceAmazonJsFlashSaleDto.fromJson(
              json['max'] as Map<String, dynamic>),
      min: json['min'] == null
          ? null
          : MinDealPriceAmazonJsFlashSaleDto.fromJson(
              json['min'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RangeDealPriceAmazonJsFlashSaleDtoToJson(
        RangeDealPriceAmazonJsFlashSaleDto instance) =>
    <String, dynamic>{
      'min': instance.min,
      'max': instance.max,
    };

MinDealPriceAmazonJsFlashSaleDto _$MinDealPriceAmazonJsFlashSaleDtoFromJson(
        Map<String, dynamic> json) =>
    MinDealPriceAmazonJsFlashSaleDto(
      amount: json['amount'] as int?,
      currencyCode: json['currency_code'] as String?,
    );

Map<String, dynamic> _$MinDealPriceAmazonJsFlashSaleDtoToJson(
        MinDealPriceAmazonJsFlashSaleDto instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'currency_code': instance.currencyCode,
    };

MaxDealPriceAmazonJsFlashSaleDto _$MaxDealPriceAmazonJsFlashSaleDtoFromJson(
        Map<String, dynamic> json) =>
    MaxDealPriceAmazonJsFlashSaleDto(
      amount: json['amount'] as int?,
      currencyCode: json['currency_code'] as String?,
    );

Map<String, dynamic> _$MaxDealPriceAmazonJsFlashSaleDtoToJson(
        MaxDealPriceAmazonJsFlashSaleDto instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'currency_code': instance.currencyCode,
    };

MaxSavingPriceAmazonJsFlashSaleDto _$MaxSavingPriceAmazonJsFlashSaleDtoFromJson(
        Map<String, dynamic> json) =>
    MaxSavingPriceAmazonJsFlashSaleDto(
      percent: json['percent'] as int?,
    );

Map<String, dynamic> _$MaxSavingPriceAmazonJsFlashSaleDtoToJson(
        MaxSavingPriceAmazonJsFlashSaleDto instance) =>
    <String, dynamic>{
      'percent': instance.percent,
    };
