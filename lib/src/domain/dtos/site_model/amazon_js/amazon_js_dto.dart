import 'package:json_annotation/json_annotation.dart';

part 'amazon_js_dto.g.dart';

@JsonSerializable()
class AmazonJsDto {
  const AmazonJsDto({this.products,this.success,}) : super();

  @JsonKey(name: 'products')
  final List<ItemsAmazonJsDto>? products;
  @JsonKey(name: 'success')
  final bool? success;


  factory AmazonJsDto.fromJson(Map<String, dynamic> json) =>
      _$AmazonJsDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AmazonJsDtoToJson(this);
}

@JsonSerializable()
class ItemsAmazonJsDto {
  const ItemsAmazonJsDto({this.code, this.isProduct, this.itemType, this.url, this.title, this.type, this.startTime, this.endTime, this.image, this.price, this.id,}) : super();

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
  final ItemPriceAmazonJsDto? price;


  factory ItemsAmazonJsDto.fromJson(Map<String, dynamic> json) =>
      _$ItemsAmazonJsDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ItemsAmazonJsDtoToJson(this);
}

@JsonSerializable()
class ItemPriceAmazonJsDto {
  const ItemPriceAmazonJsDto({this.basisPrice, this.dealPrice, this.savingsAmount, this.savingsPercent, this.savingsMax, }) : super();

  @JsonKey(name: 'basis_price')
  final ItemBasicPriceValueAmazonJsDto? basisPrice;
  @JsonKey(name: 'deal_price')
  final ItemBasicPriceDealAmazonJsDto? dealPrice;
  @JsonKey(name: 'savings_amount')
  final int? savingsAmount;
  @JsonKey(name: 'savings_percent')
  final double? savingsPercent;
  @JsonKey(name: 'savings_max')
  final SavingPriceAmazonJsDto? savingsMax;


  factory ItemPriceAmazonJsDto.fromJson(Map<String, dynamic> json) =>
      _$ItemPriceAmazonJsDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ItemPriceAmazonJsDtoToJson(this);
}


@JsonSerializable()
class ItemBasicPriceValueAmazonJsDto {
  const ItemBasicPriceValueAmazonJsDto({this.value, }) : super();

  @JsonKey(name: 'value')
  final ItemBasicPriceAmazonJsDto? value;



  factory ItemBasicPriceValueAmazonJsDto.fromJson(Map<String, dynamic> json) =>
      _$ItemBasicPriceValueAmazonJsDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ItemBasicPriceValueAmazonJsDtoToJson(this);
}

@JsonSerializable()
class ItemBasicPriceDealAmazonJsDto {
  const ItemBasicPriceDealAmazonJsDto({this.value}) : super();

  @JsonKey(name: 'value')
  final ItemBasicPriceAmazonJsDto? value;



  factory ItemBasicPriceDealAmazonJsDto.fromJson(Map<String, dynamic> json) =>
      _$ItemBasicPriceDealAmazonJsDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ItemBasicPriceDealAmazonJsDtoToJson(this);
}

@JsonSerializable()
class ItemBasicPriceAmazonJsDto {
  const ItemBasicPriceAmazonJsDto({this.amount,this.currencyCode, }) : super();

  @JsonKey(name: 'amount')
  final int? amount;
  @JsonKey(name: 'currency_code')
  final int? currencyCode;



  factory ItemBasicPriceAmazonJsDto.fromJson(Map<String, dynamic> json) =>
      _$ItemBasicPriceAmazonJsDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ItemBasicPriceAmazonJsDtoToJson(this);
}

@JsonSerializable()
class SavingPriceAmazonJsDto {
  const SavingPriceAmazonJsDto({this.percent, }) : super();

  @JsonKey(name: 'percent')
  final double? percent;



  factory SavingPriceAmazonJsDto.fromJson(Map<String, dynamic> json) =>
      _$SavingPriceAmazonJsDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SavingPriceAmazonJsDtoToJson(this);
}