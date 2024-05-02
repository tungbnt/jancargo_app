import 'package:json_annotation/json_annotation.dart';

part 'amazon_js_search_keyword_dto.g.dart';

@JsonSerializable()
class AmazonSearchKeyWordDto {
  const AmazonSearchKeyWordDto({
    this.products,
  }) : super();

  @JsonKey(name: 'products')
  final List<AmazonItemsSearchKeyWordDto>? products;

  factory AmazonSearchKeyWordDto.fromJson(Map<String, dynamic> json) =>
      _$AmazonSearchKeyWordDtoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AmazonSearchKeyWordDtoToJson(this);
}

@JsonSerializable()
class AmazonItemsSearchKeyWordDto {
  const AmazonItemsSearchKeyWordDto({
    this.code, this.image, this.name, this.link, this.originHref, this.currentPrice, this.beforePrice, this.discounted, this.savingsAmount, this.savingsPercent, this.country, this.reviews,
  }) : super();

  @JsonKey(name: 'code')
  final String? code;
  @JsonKey(name: 'image')
  final String? image;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'link')
  final String? link;
  @JsonKey(name: 'origin_href')
  final String? originHref;
  @JsonKey(name: 'current_price')
  final dynamic currentPrice;
  @JsonKey(name: 'before_price')
  final dynamic beforePrice;
  @JsonKey(name: 'discounted')
  final bool? discounted;
  @JsonKey(name: 'savings_amount')
  final dynamic savingsAmount;
  @JsonKey(name: 'savings_percent')
  final dynamic savingsPercent;
  @JsonKey(name: 'country')
  final String? country;
  @JsonKey(name: 'reviews')
  final AmazonReviewSearchKeyWordDto? reviews;

  factory AmazonItemsSearchKeyWordDto.fromJson(Map<String, dynamic> json) =>
      _$AmazonItemsSearchKeyWordDtoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AmazonItemsSearchKeyWordDtoToJson(this);
}

@JsonSerializable()
class AmazonReviewSearchKeyWordDto {
  const AmazonReviewSearchKeyWordDto({
    this.rating,
  }) : super();

  @JsonKey(name: 'rating')
  final int? rating;

  factory AmazonReviewSearchKeyWordDto.fromJson(Map<String, dynamic> json) =>
      _$AmazonReviewSearchKeyWordDtoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AmazonReviewSearchKeyWordDtoToJson(this);
}