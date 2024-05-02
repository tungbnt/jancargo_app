import 'package:json_annotation/json_annotation.dart';

part 'paypay_dto.g.dart';
@JsonSerializable()
class PaypayDto {
  const PaypayDto({this.data,}) : super();

  @JsonKey(name: 'data')
  final List<PaypaysDto>? data;


  factory PaypayDto.fromJson(Map<String, dynamic> json) =>
      _$PaypayDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PaypayDtoToJson(this);
}
@JsonSerializable()
class PaypaysDto {
  const PaypaysDto({this.category, this.results,}) : super();

  @JsonKey(name: 'category')
  final dynamic category;
  @JsonKey(name: 'results')
  final List<ItemPaypay>? results;


  factory PaypaysDto.fromJson(Map<String, dynamic> json) =>
      _$PaypaysDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PaypaysDtoToJson(this);
}

@JsonSerializable()
class ItemPaypay {
  const ItemPaypay( {this.code, this.name, this.image, this.price, this.url, this.status, this.seller, this.category,}) : super();

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
  final SellerItemPaypay? seller;
  @JsonKey(name: 'category')
  final CategoryItemPaypay? category;


  factory ItemPaypay.fromJson(Map<String, dynamic> json) =>
      _$ItemPaypayFromJson(json);

  Map<String, dynamic> toJson() => _$ItemPaypayToJson(this);
}

@JsonSerializable()
class SellerItemPaypay {
  const SellerItemPaypay({this.id, this.numRating,this.goodRatio}) : super();

  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'goodRatio')
  final double? goodRatio;
  @JsonKey(name: 'numRating')
  final int? numRating;


  factory SellerItemPaypay.fromJson(Map<String, dynamic> json) =>
      _$SellerItemPaypayFromJson(json);

  Map<String, dynamic> toJson() => _$SellerItemPaypayToJson(this);
}

@JsonSerializable()
class CategoryItemPaypay {
  const CategoryItemPaypay({this.id, this.name,this.path}) : super();

  @JsonKey(name: 'id')
  final dynamic id;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'path')
  final List<PathCategoryItemPaypay>? path;


  factory CategoryItemPaypay.fromJson(Map<String, dynamic> json) =>
      _$CategoryItemPaypayFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryItemPaypayToJson(this);
}

@JsonSerializable()
class PathCategoryItemPaypay {
  const PathCategoryItemPaypay({this.id, this.name,}) : super();

  @JsonKey(name: 'id')
  final dynamic id;
  @JsonKey(name: 'name')
  final String? name;


  factory PathCategoryItemPaypay.fromJson(Map<String, dynamic> json) =>
      _$PathCategoryItemPaypayFromJson(json);

  Map<String, dynamic> toJson() => _$PathCategoryItemPaypayToJson(this);
}

@JsonSerializable()
class MapItemPaypay {
  const MapItemPaypay({this.category, this.items,}) : super();

  @JsonKey(name: 'category')
  final String? category;
  @JsonKey(name: 'items')
  final List<ItemPaypay>? items;


  factory MapItemPaypay.fromJson(Map<String, dynamic> json) =>
      _$MapItemPaypayFromJson(json);

  Map<String, dynamic> toJson() => _$MapItemPaypayToJson(this);
}
