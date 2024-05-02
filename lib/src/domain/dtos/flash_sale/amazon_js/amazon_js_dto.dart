import 'package:json_annotation/json_annotation.dart';

part 'amazon_js_dto.g.dart';
@JsonSerializable()
class AmazonJsFlashSaleDto  {
  const AmazonJsFlashSaleDto({ this.success, this.products, })
      : super();

  @JsonKey(name: 'success')
  final bool? success;
  @JsonKey(name: 'products')
  final List<ItemsAmazonJsFlashSaleDto>? products;



  factory AmazonJsFlashSaleDto.fromJson(Map<String, dynamic> json) =>
      _$AmazonJsFlashSaleDtoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AmazonJsFlashSaleDtoToJson(this);
}
@JsonSerializable()
class ItemsAmazonJsFlashSaleDto  {
  const ItemsAmazonJsFlashSaleDto({this.id, this.code, this.isProduct, this.itemType, this.url, this.title, this.type, this.startTime, this.endTime, this.image, this.price,  })
      : super();

  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'code')
  final String? code;
  @JsonKey(name: 'is_product')
  final bool? isProduct;
  @JsonKey(name: 'item_type')
  final String? itemType;
  @JsonKey(name: 'url')
  final String? url;
  @JsonKey(name: 'title')
  final String? title;
  @JsonKey(name: 'type')
  final String? type;
  @JsonKey(name: 'start_time')
  final String? startTime;
  @JsonKey(name: 'end_time')
  final String? endTime;
  @JsonKey(name: 'image')
  final String? image;
  @JsonKey(name: 'price')
  final PriceAmazonJsFlashSaleDto
  ? price;


  factory ItemsAmazonJsFlashSaleDto.fromJson(Map<String, dynamic> json) =>
      _$ItemsAmazonJsFlashSaleDtoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ItemsAmazonJsFlashSaleDtoToJson(this);
}

@JsonSerializable()
class PriceAmazonJsFlashSaleDto  {
  const PriceAmazonJsFlashSaleDto({this.basisPrice, this.dealPrice, this.savingsAmount, this.savingsPercent, this.savingsMax, })
      : super();

  @JsonKey(name: 'basis_price')
  final dynamic basisPrice;
  @JsonKey(name: 'deal_price')
  final DealPriceAmazonJsFlashSaleDto? dealPrice;
  @JsonKey(name: 'savings_amount')
  final double? savingsAmount;
  @JsonKey(name: 'savings_percent')
  final double? savingsPercent;
  @JsonKey(name: 'savings_max')
  final MaxSavingPriceAmazonJsFlashSaleDto? savingsMax;



  factory PriceAmazonJsFlashSaleDto.fromJson(Map<String, dynamic> json) =>
      _$PriceAmazonJsFlashSaleDtoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PriceAmazonJsFlashSaleDtoToJson(this);
}
@JsonSerializable()
class DealPriceAmazonJsFlashSaleDto  {
  const DealPriceAmazonJsFlashSaleDto({this.range, })
      : super();

  @JsonKey(name: 'range')
  final dynamic range;

  factory DealPriceAmazonJsFlashSaleDto.fromJson(Map<String, dynamic> json) =>
      _$DealPriceAmazonJsFlashSaleDtoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$DealPriceAmazonJsFlashSaleDtoToJson(this);
}

@JsonSerializable()
class RangeDealPriceAmazonJsFlashSaleDto  {
  const RangeDealPriceAmazonJsFlashSaleDto({this.max,this.min })
      : super();

  @JsonKey(name: 'min')
  final MinDealPriceAmazonJsFlashSaleDto? min;
  @JsonKey(name: 'max')
  final MaxDealPriceAmazonJsFlashSaleDto? max;




  factory RangeDealPriceAmazonJsFlashSaleDto.fromJson(Map<String, dynamic> json) =>
      _$RangeDealPriceAmazonJsFlashSaleDtoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$RangeDealPriceAmazonJsFlashSaleDtoToJson(this);
}

@JsonSerializable()
class MinDealPriceAmazonJsFlashSaleDto  {
  const MinDealPriceAmazonJsFlashSaleDto({this.amount, this.currencyCode, })
      : super();

  @JsonKey(name: 'amount')
  final int? amount;
  @JsonKey(name: 'currency_code')
  final String? currencyCode;

  factory MinDealPriceAmazonJsFlashSaleDto.fromJson(Map<String, dynamic> json) =>
      _$MinDealPriceAmazonJsFlashSaleDtoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MinDealPriceAmazonJsFlashSaleDtoToJson(this);
}
@JsonSerializable()
class MaxDealPriceAmazonJsFlashSaleDto  {
  const MaxDealPriceAmazonJsFlashSaleDto({this.amount, this.currencyCode, })
      : super();

  @JsonKey(name: 'amount')
  final int? amount;
  @JsonKey(name: 'currency_code')
  final String? currencyCode;




  factory MaxDealPriceAmazonJsFlashSaleDto.fromJson(Map<String, dynamic> json) =>
      _$MaxDealPriceAmazonJsFlashSaleDtoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MaxDealPriceAmazonJsFlashSaleDtoToJson(this);
}

@JsonSerializable()
class MaxSavingPriceAmazonJsFlashSaleDto  {
  const MaxSavingPriceAmazonJsFlashSaleDto({this.percent, })
      : super();

  @JsonKey(name: 'percent')
  final int? percent;

  factory MaxSavingPriceAmazonJsFlashSaleDto.fromJson(Map<String, dynamic> json) =>
      _$MaxSavingPriceAmazonJsFlashSaleDtoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MaxSavingPriceAmazonJsFlashSaleDtoToJson(this);
}