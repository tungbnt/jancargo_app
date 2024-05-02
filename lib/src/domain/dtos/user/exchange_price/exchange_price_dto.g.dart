// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exchange_price_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExchangeDto _$ExchangeDtoFromJson(Map<String, dynamic> json) => ExchangeDto(
      code: json['code'] as int?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ExchangePriceDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ExchangeDtoToJson(ExchangeDto instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

ExchangePriceDto _$ExchangePriceDtoFromJson(Map<String, dynamic> json) =>
    ExchangePriceDto(
      currencyCode: json['CurrencyCode'] as String?,
      currencyName: json['CurrencyName'] as String?,
      buy: json['Buy'] as int?,
      transfer: json['Transfer'] as int?,
      sell: json['Sell'] as int?,
    );

Map<String, dynamic> _$ExchangePriceDtoToJson(ExchangePriceDto instance) =>
    <String, dynamic>{
      'CurrencyCode': instance.currencyCode,
      'CurrencyName': instance.currencyName,
      'Buy': instance.buy,
      'Transfer': instance.transfer,
      'Sell': instance.sell,
    };
