// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'price_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PriceDto _$PriceDtoFromJson(Map<String, dynamic> json) => PriceDto(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => PriceItemDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PriceDtoToJson(PriceDto instance) => <String, dynamic>{
      'data': instance.data,
    };

PriceItemDto _$PriceItemDtoFromJson(Map<String, dynamic> json) => PriceItemDto(
      taxForeignCurrency:
          json['goods_value_with_tax_in_foreign_currency'] as int?,
      taxVNCurrency: json['goods_value_with_tax_in_vietnam_currency'] as int?,
      payment: json['payment'] == null
          ? null
          : PaymentDto.fromJson(json['payment'] as Map<String, dynamic>),
      reward: json['reward'] == null
          ? null
          : RewardDto.fromJson(json['reward'] as Map<String, dynamic>),
      feeDetails: (json['fee_details'] as List<dynamic>?)
          ?.map((e) => FeeDetailsDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PriceItemDtoToJson(PriceItemDto instance) =>
    <String, dynamic>{
      'goods_value_with_tax_in_foreign_currency': instance.taxForeignCurrency,
      'goods_value_with_tax_in_vietnam_currency': instance.taxVNCurrency,
      'fee_details': instance.feeDetails,
      'payment': instance.payment,
      'reward': instance.reward,
    };

FeeDetailsDto _$FeeDetailsDtoFromJson(Map<String, dynamic> json) =>
    FeeDetailsDto(
      id: json['id'] as String?,
      name: json['name'] as String?,
      foreignCurrency: json['foreign_currency'] as int?,
      vietnamCurrency: json['vietnam_currency'] as int?,
      code: json['code'] as String?,
      origin: json['origin'] == null
          ? null
          : OriginDto.fromJson(json['origin'] as Map<String, dynamic>),
      discount: json['discount'] == null
          ? null
          : DiscountDto.fromJson(json['discount'] as Map<String, dynamic>),
      groups: json['groups'] as List<dynamic>?,
      extras: json['extras'] as List<dynamic>?,
      priceListDetails: (json['priceListDetails'] as List<dynamic>?)
          ?.map((e) => PriceLisstDetailDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      rewardInfo: json['rewardInfo'] as String?,
    );

Map<String, dynamic> _$FeeDetailsDtoToJson(FeeDetailsDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'foreign_currency': instance.foreignCurrency,
      'vietnam_currency': instance.vietnamCurrency,
      'code': instance.code,
      'origin': instance.origin,
      'discount': instance.discount,
      'groups': instance.groups,
      'extras': instance.extras,
      'priceListDetails': instance.priceListDetails,
      'rewardInfo': instance.rewardInfo,
    };

OriginDto _$OriginDtoFromJson(Map<String, dynamic> json) => OriginDto(
      level: json['level'] as int?,
      unit: json['unit'] as String?,
    );

Map<String, dynamic> _$OriginDtoToJson(OriginDto instance) => <String, dynamic>{
      'level': instance.level,
      'unit': instance.unit,
    };

DiscountDto _$DiscountDtoFromJson(Map<String, dynamic> json) => DiscountDto(
      discountDetails: json['discount_details'] as List<dynamic>?,
      errors: json['errors'] as List<dynamic>?,
    );

Map<String, dynamic> _$DiscountDtoToJson(DiscountDto instance) =>
    <String, dynamic>{
      'discount_details': instance.discountDetails,
      'errors': instance.errors,
    };

PriceLisstDetailDto _$PriceLisstDetailDtoFromJson(Map<String, dynamic> json) =>
    PriceLisstDetailDto(
      typeId: json['type_id'] as String?,
      details: (json['details'] as List<dynamic>?)
          ?.map((e) =>
              DetailPriceLisstDetailDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      id: json['_id'] as String?,
      code: json['code'] as String?,
      typeName: json['type_name'] as String?,
      completedAtStatus: json['completed_at_status'] as int?,
      orderNo: json['order_no'] as int?,
    );

Map<String, dynamic> _$PriceLisstDetailDtoToJson(
        PriceLisstDetailDto instance) =>
    <String, dynamic>{
      'type_id': instance.typeId,
      'details': instance.details,
      '_id': instance.id,
      'code': instance.code,
      'type_name': instance.typeName,
      'completed_at_status': instance.completedAtStatus,
      'order_no': instance.orderNo,
    };

DetailPriceLisstDetailDto _$DetailPriceLisstDetailDtoFromJson(
        Map<String, dynamic> json) =>
    DetailPriceLisstDetailDto(
      min: json['min'] as int?,
      max: json['max'] as int?,
      unit: json['unit'] as String?,
      value: json['value'] as int?,
      munitToCalcPriceax: json['unit_to_calc_price'] as String?,
      id: json['_id'] as String?,
    );

Map<String, dynamic> _$DetailPriceLisstDetailDtoToJson(
        DetailPriceLisstDetailDto instance) =>
    <String, dynamic>{
      'min': instance.min,
      'max': instance.max,
      'unit': instance.unit,
      'value': instance.value,
      'unit_to_calc_price': instance.munitToCalcPriceax,
      '_id': instance.id,
    };

PaymentDto _$PaymentDtoFromJson(Map<String, dynamic> json) => PaymentDto(
      totalFirst: json['total_first'] as int?,
      firstPayment: json['first_payment'] as int?,
      secondPayment: json['second_payment'] as int?,
    );

Map<String, dynamic> _$PaymentDtoToJson(PaymentDto instance) =>
    <String, dynamic>{
      'total_first': instance.totalFirst,
      'first_payment': instance.firstPayment,
      'second_payment': instance.secondPayment,
    };

RewardDto _$RewardDtoFromJson(Map<String, dynamic> json) => RewardDto(
      routeCode: json['route_code'] as String?,
      internationalShippingDiscountUnit:
          json['international_shipping_discount_unit'] as String?,
      id: json['_id'] as String?,
      details: json['details'] as List<dynamic>?,
    );

Map<String, dynamic> _$RewardDtoToJson(RewardDto instance) => <String, dynamic>{
      'route_code': instance.routeCode,
      'international_shipping_discount_unit':
          instance.internationalShippingDiscountUnit,
      '_id': instance.id,
      'details': instance.details,
    };
