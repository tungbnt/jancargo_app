import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category_product_dto.g.dart';

@JsonSerializable()
class CategoryDto {
  const CategoryDto({
    this.data,
  }) : super();

  @JsonKey(required: true, name: 'data')
  final List<CategoryProductDto>? data;

  factory CategoryDto.fromJson(Map<String, dynamic> json) =>
      _$CategoryDtoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CategoryDtoToJson(this);
}
@JsonSerializable()
class CategoryProductDto {
  const CategoryProductDto({
    this.category,
    this.results,
  }) : super();

  @JsonKey(required: true, name: 'category')
  final String? category;
  @JsonKey(required: true, name: 'results')
  final List<CategoryProductItemDto>? results;

  factory CategoryProductDto.fromJson(Map<String, dynamic> json) =>
      _$CategoryProductDtoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CategoryProductDtoToJson(this);
}

@JsonSerializable()
class CategoryProductItemDto {
  const CategoryProductItemDto({required this.favorite,
    this.code,
    this.name,
    this.url,
    this.image,
    this.price,
    this.priceBuy,
    this.endTime,
    this.sellerId,
    this.bids,
    this.newW,
    this.freeship,
    this.used,
  }) : super();

  @JsonKey(name: 'code')
  final String? code;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'url')
  final String? url;
  @JsonKey(name: 'image')
  final String? image;
  @JsonKey(name: 'price')
  final int? price;
  @JsonKey(name: 'price_buy')
  final int? priceBuy;
  @JsonKey(name: 'end_time')
  final String? endTime;
  @JsonKey(name: 'seller_id')
  final String? sellerId;
  @JsonKey(name: 'bids')
  final String? bids;
  @JsonKey(name: 'new')
  final bool? newW;
  @JsonKey(name: 'freeship')
  final bool? freeship;
  @JsonKey(name: 'used')
  final bool? used;
  @JsonKey(name: 'favorite',fromJson: _favoriteFromJson,toJson: _favoriteToJson)
  final ValueNotifier<bool> favorite;

  static ValueNotifier<bool> _favoriteFromJson(bool? value) =>
      ValueNotifier<bool>(value ?? false);

  static bool _favoriteToJson(ValueNotifier<bool> favorite) =>
      favorite.value;

  factory CategoryProductItemDto.fromJson(Map<String, dynamic> json) =>
      _$CategoryProductItemDtoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CategoryProductItemDtoToJson(this);
}
