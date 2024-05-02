import 'package:json_annotation/json_annotation.dart';

part 'rakuten_resolver_dto.g.dart';

@JsonSerializable()
class RakutenResolverDto {
  const RakutenResolverDto({this.result}) : super();

  @JsonKey(name: 'result')
  final RakutenResolverResultDto? result;

  factory RakutenResolverDto.fromJson(Map<String, dynamic> json) =>
      _$RakutenResolverDtoFromJson(json);

  Map<String, dynamic> toJson() => _$RakutenResolverDtoToJson(this);
}

@JsonSerializable()
class RakutenResolverResultDto {
  const RakutenResolverResultDto({this.jancargoUrl, this.me, this.price, this.productId, this.productName, this.quantity, this.shopId, this.shopUrl, this.url, }) : super();

  @JsonKey(name: 'jancargo_url')
  final String? jancargoUrl;
  @JsonKey(name: 'meta')
  final MetaRakutenResolverResultDto? me;
  @JsonKey(name: 'price')
  final double? price;
  @JsonKey(name: 'product_id')
  final String? productId;
  @JsonKey(name: 'product_name')
  final String? productName;
  @JsonKey(name: 'quantity')
  final int? quantity;
  @JsonKey(name: 'shop_id')
  final String? shopId;
  @JsonKey(name: 'shop_url')
  final String? shopUrl;
  @JsonKey(name: 'url')
  final String? url;

  factory RakutenResolverResultDto.fromJson(Map<String, dynamic> json) =>
      _$RakutenResolverResultDtoFromJson(json);

  Map<String, dynamic> toJson() => _$RakutenResolverResultDtoToJson(this);
}
@JsonSerializable()
class MetaRakutenResolverResultDto {
  const MetaRakutenResolverResultDto({this.hightPrice, this.lowPrice, this.price, this.priceCurrency, }) : super();

  @JsonKey(name: 'hight_price')
  final double? hightPrice;
  @JsonKey(name: 'low_price')
  final double? lowPrice;
  @JsonKey(name: 'price')
  final double? price;
  @JsonKey(name: 'price_currency')
  final String? priceCurrency;

  factory MetaRakutenResolverResultDto.fromJson(Map<String, dynamic> json) =>
      _$MetaRakutenResolverResultDtoFromJson(json);

  Map<String, dynamic> toJson() => _$MetaRakutenResolverResultDtoToJson(this);
}