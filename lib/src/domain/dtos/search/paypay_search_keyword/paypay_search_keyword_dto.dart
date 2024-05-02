import 'package:json_annotation/json_annotation.dart';

part 'paypay_search_keyword_dto.g.dart';

@JsonSerializable()
class PaypaySearchKeyWordDto {
  const PaypaySearchKeyWordDto({
    this.results,
  }) : super();

  @JsonKey(name: 'results')
  final List<PaypayItemsSearchKeyWordDto>? results;

  factory PaypaySearchKeyWordDto.fromJson(Map<String, dynamic> json) =>
      _$PaypaySearchKeyWordDtoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PaypaySearchKeyWordDtoToJson(this);
}

@JsonSerializable()
class PaypayItemsSearchKeyWordDto {
  const PaypayItemsSearchKeyWordDto( {
    this.code, this.name, this.image, this.price, this.url, this.status, this.seller, this.category,
  }) : super();

  @JsonKey(name: 'code')
  final String? code;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'image')
  final String? image;
  @JsonKey(name: 'price')
  final int? price;
  @JsonKey(name: 'url')
  final String? url;
  @JsonKey(name: 'status')
  final String? status;
  @JsonKey(name: 'seller')
  final PaypaySellerSearchKeyWordDto? seller;
  @JsonKey(name: 'category')
  final PaypayCategorySearchKeyWordDto? category;

  factory PaypayItemsSearchKeyWordDto.fromJson(Map<String, dynamic> json) =>
      _$PaypayItemsSearchKeyWordDtoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PaypayItemsSearchKeyWordDtoToJson(this);
}

@JsonSerializable()
class PaypaySellerSearchKeyWordDto {
  const PaypaySellerSearchKeyWordDto( {
    this.id, this.goodRatio, this.numRating,
  }) : super();

  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'goodRatio')
  final double? goodRatio;
  @JsonKey(name: 'numRating')
  final double? numRating;

  factory PaypaySellerSearchKeyWordDto.fromJson(Map<String, dynamic> json) =>
      _$PaypaySellerSearchKeyWordDtoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PaypaySellerSearchKeyWordDtoToJson(this);
}
@JsonSerializable()
class PaypayCategorySearchKeyWordDto {
  const PaypayCategorySearchKeyWordDto({
    this.productCategoryId,    this.id, this.name, this.path,
  }) : super();

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'named')
  final String? name;
  @JsonKey(name: 'productCategoryId')
  final int? productCategoryId;
  @JsonKey(name: 'path')
  final List<PaypayCategoryPathSearchKeyWordDto>? path;

  factory PaypayCategorySearchKeyWordDto.fromJson(Map<String, dynamic> json) =>
      _$PaypayCategorySearchKeyWordDtoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PaypayCategorySearchKeyWordDtoToJson(this);
}

@JsonSerializable()
class PaypayCategoryPathSearchKeyWordDto {
  const PaypayCategoryPathSearchKeyWordDto({
    this.id,this.name,
  }) : super();

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'named')
  final String? name;

  factory PaypayCategoryPathSearchKeyWordDto.fromJson(Map<String, dynamic> json) =>
      _$PaypayCategoryPathSearchKeyWordDtoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PaypayCategoryPathSearchKeyWordDtoToJson(this);
}