// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'amazon_js_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AmazonJsDto _$AmazonJsDtoFromJson(Map<String, dynamic> json) => AmazonJsDto(
      products: (json['products'] as List<dynamic>?)
          ?.map((e) => ItemsAmazonJsDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      success: json['success'] as bool?,
    );

Map<String, dynamic> _$AmazonJsDtoToJson(AmazonJsDto instance) =>
    <String, dynamic>{
      'products': instance.products,
      'success': instance.success,
    };

ItemsAmazonJsDto _$ItemsAmazonJsDtoFromJson(Map<String, dynamic> json) =>
    ItemsAmazonJsDto(
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
          : ItemPriceAmazonJsDto.fromJson(
              json['price'] as Map<String, dynamic>),
      id: json['id'] as String?,
    );

Map<String, dynamic> _$ItemsAmazonJsDtoToJson(ItemsAmazonJsDto instance) =>
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

ItemPriceAmazonJsDto _$ItemPriceAmazonJsDtoFromJson(
        Map<String, dynamic> json) =>
    ItemPriceAmazonJsDto(
      basisPrice: json['basis_price'] == null
          ? null
          : ItemBasicPriceValueAmazonJsDto.fromJson(
              json['basis_price'] as Map<String, dynamic>),
      dealPrice: json['deal_price'] == null
          ? null
          : ItemBasicPriceDealAmazonJsDto.fromJson(
              json['deal_price'] as Map<String, dynamic>),
      savingsAmount: json['savings_amount'] as int?,
      savingsPercent: (json['savings_percent'] as num?)?.toDouble(),
      savingsMax: json['savings_max'] == null
          ? null
          : SavingPriceAmazonJsDto.fromJson(
              json['savings_max'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ItemPriceAmazonJsDtoToJson(
        ItemPriceAmazonJsDto instance) =>
    <String, dynamic>{
      'basis_price': instance.basisPrice,
      'deal_price': instance.dealPrice,
      'savings_amount': instance.savingsAmount,
      'savings_percent': instance.savingsPercent,
      'savings_max': instance.savingsMax,
    };

ItemBasicPriceValueAmazonJsDto _$ItemBasicPriceValueAmazonJsDtoFromJson(
        Map<String, dynamic> json) =>
    ItemBasicPriceValueAmazonJsDto(
      value: json['value'] == null
          ? null
          : ItemBasicPriceAmazonJsDto.fromJson(
              json['value'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ItemBasicPriceValueAmazonJsDtoToJson(
        ItemBasicPriceValueAmazonJsDto instance) =>
    <String, dynamic>{
      'value': instance.value,
    };

ItemBasicPriceDealAmazonJsDto _$ItemBasicPriceDealAmazonJsDtoFromJson(
        Map<String, dynamic> json) =>
    ItemBasicPriceDealAmazonJsDto(
      value: json['value'] == null
          ? null
          : ItemBasicPriceAmazonJsDto.fromJson(
              json['value'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ItemBasicPriceDealAmazonJsDtoToJson(
        ItemBasicPriceDealAmazonJsDto instance) =>
    <String, dynamic>{
      'value': instance.value,
    };

ItemBasicPriceAmazonJsDto _$ItemBasicPriceAmazonJsDtoFromJson(
        Map<String, dynamic> json) =>
    ItemBasicPriceAmazonJsDto(
      amount: json['amount'] as int?,
      currencyCode: json['currency_code'] as int?,
    );

Map<String, dynamic> _$ItemBasicPriceAmazonJsDtoToJson(
        ItemBasicPriceAmazonJsDto instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'currency_code': instance.currencyCode,
    };

SavingPriceAmazonJsDto _$SavingPriceAmazonJsDtoFromJson(
        Map<String, dynamic> json) =>
    SavingPriceAmazonJsDto(
      percent: (json['percent'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$SavingPriceAmazonJsDtoToJson(
        SavingPriceAmazonJsDto instance) =>
    <String, dynamic>{
      'percent': instance.percent,
    };
