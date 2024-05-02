import 'package:json_annotation/json_annotation.dart';

part 'exchange_price_dto.g.dart';

@JsonSerializable()
class ExchangeDto {
  const ExchangeDto({ this.code, this.message, this.data, }) : super();

  @JsonKey(name: 'code')
  final int? code;
  @JsonKey(name: 'message')
  final String? message;
  @JsonKey(name: 'data')
  final List<ExchangePriceDto>? data;




  factory ExchangeDto.fromJson(Map<String, dynamic> json) =>
      _$ExchangeDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ExchangeDtoToJson(this);
}

@JsonSerializable()
class ExchangePriceDto {
  const ExchangePriceDto( { this.currencyCode, this.currencyName, this.buy, this.transfer, this.sell,}) : super();

  @JsonKey(name: 'CurrencyCode')
  final String? currencyCode;
  @JsonKey(name: 'CurrencyName')
  final String? currencyName;
  @JsonKey(name: 'Buy')
  final int? buy;
  @JsonKey(name: 'Transfer')
  final int? transfer;
  @JsonKey(name: 'Sell')
  final int? sell;



  factory ExchangePriceDto.fromJson(Map<String, dynamic> json) =>
      _$ExchangePriceDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ExchangePriceDtoToJson(this);
}