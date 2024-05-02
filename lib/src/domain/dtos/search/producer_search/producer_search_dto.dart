import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'producer_search_dto.g.dart';

@JsonSerializable()
class ProducerSearchDto {
  const ProducerSearchDto({
    this.brand,
    this.price,
    this.category,
    this.initialBrand,
    // this.shoppingSpecs,
  }) : super();

  @JsonKey(name: 'brand')
  final BrandProducerSearchDto? brand;
  @JsonKey(name: 'price')
  final PriceProducerSearchDto? price;
  @JsonKey(name: 'category')
  final CategoryProducerSearchDto? category;
  @JsonKey(name: 'initialBrand')
  final InitialBrandProducerSearchDto? initialBrand;
  // @JsonKey(name: 'shoppingSpecs')
  // final ShoppingSpecsProducerSearchDto? shoppingSpecs;

  factory ProducerSearchDto.fromJson(Map<String, dynamic> json) => _$ProducerSearchDtoFromJson(json);
}

@JsonSerializable()
class BrandProducerSearchDto {
  const BrandProducerSearchDto({
    this.path,
    this.childDepth,
    this.children,
    this.brand1,
  }) : super();

  @JsonKey(name: 'brand1')
  final List<dynamic>? brand1;
  @JsonKey(name: 'path')
  final List<dynamic>? path;
  @JsonKey(name: 'childDepth')
  final int? childDepth;
  @JsonKey(name: 'children')
  final List<ChildrenBrandProducerSearchDto>? children;

  factory BrandProducerSearchDto.fromJson(Map<String, dynamic> json) => _$BrandProducerSearchDtoFromJson(json);
}

@JsonSerializable()
class ChildrenBrandProducerSearchDto extends InitialBrandChildrenItemProducerSearchDto {
  ChildrenBrandProducerSearchDto({
    this.path,
    this.auctions,
    super.count,
    super.englishName,
    super.id,
    this.images,
    super.kanaName,
    super.name,
  }) : super();

  @JsonKey(name: 'auctions')
  final AuctionsChildrenBrandProducerSearchDto? auctions;

  @JsonKey(name: 'images')
  final List<String>? images;

  @JsonKey(name: 'path')
  final List<dynamic>? path;

  factory ChildrenBrandProducerSearchDto.fromJson(Map<String, dynamic> json) =>
      _$ChildrenBrandProducerSearchDtoFromJson(json);
}

@JsonSerializable()
class AuctionsChildrenBrandProducerSearchDto {
  const AuctionsChildrenBrandProducerSearchDto({
    this.images,
  }) : super();

  @JsonKey(name: 'images')
  final List<dynamic>? images;

  factory AuctionsChildrenBrandProducerSearchDto.fromJson(Map<String, dynamic> json) =>
      _$AuctionsChildrenBrandProducerSearchDtoFromJson(json);
}

/// category
@JsonSerializable()
class CategoryProducerSearchDto {
  const CategoryProducerSearchDto({
    this.current,
    this.parent,
    this.children,
  }) : super();

  @JsonKey(name: 'children')
  final List<dynamic>? children;
  @JsonKey(name: 'current')
  final CurrentCategoryProducerSearchDto? current;
  @JsonKey(name: 'parent')
  final ParentCategoryProducerSearchDto? parent;

  factory CategoryProducerSearchDto.fromJson(Map<String, dynamic> json) => _$CategoryProducerSearchDtoFromJson(json);
}

@JsonSerializable()
class CurrentCategoryProducerSearchDto {
  const CurrentCategoryProducerSearchDto({
    this.id,
    this.name,
    this.depth,
    this.count,
    this.isLeaf,
  }) : super();

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'depth')
  final int? depth;
  @JsonKey(name: 'count')
  final int? count;
  @JsonKey(name: 'isLeaf')
  final bool? isLeaf;

  factory CurrentCategoryProducerSearchDto.fromJson(Map<String, dynamic> json) =>
      _$CurrentCategoryProducerSearchDtoFromJson(json);
}

@JsonSerializable()
class ParentCategoryProducerSearchDto {
  const ParentCategoryProducerSearchDto({
    this.id,
    this.name,
  }) : super();

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'name')
  final String? name;

  factory ParentCategoryProducerSearchDto.fromJson(Map<String, dynamic> json) =>
      _$ParentCategoryProducerSearchDtoFromJson(json);
}

/// initial brand
@JsonSerializable()
class InitialBrandProducerSearchDto {
  const InitialBrandProducerSearchDto({
    this.initials,
  }) : super();

  @JsonKey(name: 'initials')
  final List<InitialBrandItemsProducerSearchDto>? initials;

  factory InitialBrandProducerSearchDto.fromJson(Map<String, dynamic> json) =>
      _$InitialBrandProducerSearchDtoFromJson(json);
}

@JsonSerializable()
class InitialBrandItemsProducerSearchDto {
  const InitialBrandItemsProducerSearchDto({
    this.character,
    this.children,
    this.count,
  }) : super();

  @JsonKey(name: 'character')
  final String? character;
  @JsonKey(name: 'children')
  final List<InitialBrandChildrenItemProducerSearchDto>? children;
  @JsonKey(name: 'count')
  final int? count;

  factory InitialBrandItemsProducerSearchDto.fromJson(Map<String, dynamic> json) =>
      _$InitialBrandItemsProducerSearchDtoFromJson(json);

  InitialBrandItemsProducerSearchDto clone() {
    return InitialBrandItemsProducerSearchDto(
      character: character,
      children: children == null ? null : List.of(children!),
      count: count,
    );
  }
}

@JsonSerializable()
class InitialBrandChildrenItemProducerSearchDto extends Equatable {
  InitialBrandChildrenItemProducerSearchDto({
    this.englishName,
    this.id,
    this.kanaName,
    this.name,
    this.count,
  })  : isSelected = ValueNotifier(false),
        super();

  @JsonKey(name: 'count')
  final int? count;

  @JsonKey(name: 'englishName')
  final String? englishName;

  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'kanaName')
  final String? kanaName;

  @JsonKey(name: 'name')
  final String? name;

  final ValueNotifier<bool> isSelected;

  factory InitialBrandChildrenItemProducerSearchDto.fromJson(Map<String, dynamic> json) =>
      _$InitialBrandChildrenItemProducerSearchDtoFromJson(json);

  @override
  List<Object?> get props => [id, englishName, kanaName, name];
}

/// price
@JsonSerializable()
class PriceProducerSearchDto {
  const PriceProducerSearchDto({
    this.ranges,
  }) : super();

  @JsonKey(name: 'ranges')
  final List<dynamic>? ranges;

  factory PriceProducerSearchDto.fromJson(Map<String, dynamic> json) => _$PriceProducerSearchDtoFromJson(json);
}

/// shoppingSpecs
@JsonSerializable()
class ShoppingSpecsProducerSearchDto {
  const ShoppingSpecsProducerSearchDto({
    this.ranges,
  }) : super();

  @JsonKey(name: 'ranges')
  final List<dynamic>? ranges;

  factory ShoppingSpecsProducerSearchDto.fromJson(Map<String, dynamic> json) =>
      _$ShoppingSpecsProducerSearchDtoFromJson(json);
}
