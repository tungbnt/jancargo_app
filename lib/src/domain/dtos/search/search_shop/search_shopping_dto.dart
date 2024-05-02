import 'package:json_annotation/json_annotation.dart';

part 'search_shopping_dto.g.dart';
@JsonSerializable()
class SearchShoppingDto  {
  const SearchShoppingDto( {this.results, this.pagination,})
      : super();

  @JsonKey(name: 'results')
  final List<ItemsShoppingDto>? results;

  @JsonKey( name: 'pagination')
  final PaginationDto? pagination;

  factory SearchShoppingDto.fromJson(Map<String, dynamic> json) =>
      _$SearchShoppingDtoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SearchShoppingDtoToJson(this);
}

@JsonSerializable()
class ItemsShoppingDto  {
  ItemsShoppingDto({this.isItemSavedCart, this.code, this.name, this.description, this.category, this.brand, this.stock, this.price, this.priceLabel, this.releaseDate, this.review, this.seller, this.url, this.image,  })
      : super();

  @JsonKey(name: 'code')
  final String? code;

  @JsonKey(name: 'name')
  final String? name;
  @JsonKey( name: 'description')
  final String? description;

  @JsonKey( name: 'category')
  final CategoriesDto? category;
  @JsonKey(name: 'brand')
  final BrandDto? brand;
  @JsonKey( name: 'stock')
  final bool? stock;
  @JsonKey( name: 'isItemSavedCart')
  bool? isItemSavedCart;
  @JsonKey(name: 'price')
  final int? price;
  @JsonKey( name: 'priceLabel')
  final PriceLabelDto? priceLabel;
  @JsonKey( name: 'releaseDate')
  final int? releaseDate;
  @JsonKey( name: 'review')
  final ReviewedDto? review;
  @JsonKey( name: 'seller')
  final SellerDto? seller;
  @JsonKey(name: 'url')
  final String? url;
  @JsonKey( name: 'image')
  final String? image;


  factory ItemsShoppingDto.fromJson(Map<String, dynamic> json) =>
      _$ItemsShoppingDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ItemsShoppingDtoToJson(this);
}

@JsonSerializable()
class CategoriesDto  {
const CategoriesDto({this.id, this.name, this.depth,})
    : super();

  @JsonKey( name: 'id')
   final int? id;
   @JsonKey( name: 'name')
   final String? name;
   @JsonKey(name: 'depth')
  final int? depth;

factory CategoriesDto.fromJson(Map<String, dynamic> json) =>
_$CategoriesDtoFromJson(json);

Map<String, dynamic> toJson() => _$CategoriesDtoToJson(this);
}

@JsonSerializable()
class BrandDto  {
const BrandDto({this.id, this.name,})
    : super();

  @JsonKey( name: 'id')
  final double? id;
  @JsonKey( name: 'name')
  final String? name;


factory BrandDto.fromJson(Map<String, dynamic> json) =>
_$BrandDtoFromJson(json);

Map<String, dynamic> toJson() => _$BrandDtoToJson(this);
}

@JsonSerializable()
class PriceLabelDto  {
const PriceLabelDto({this.taxable, this.defaultPrice, this.discountedPrice, this.fixedPrice, this.premiumPrice, this.periodStart, this.periodEnd,})
    : super();

@JsonKey( name: 'taxable')
final bool? taxable;
@JsonKey(name: 'defaultPrice')
final int? defaultPrice;
@JsonKey(name: 'discountedPrice')
final int? discountedPrice;
@JsonKey(name: 'fixedPrice')
final int? fixedPrice;
@JsonKey(name: 'premiumPrice')
final int? premiumPrice;
@JsonKey(name: 'periodStart')
final int? periodStart;
@JsonKey(name: 'periodEnd')
final int? periodEnd;


factory PriceLabelDto.fromJson(Map<String, dynamic> json) =>
_$PriceLabelDtoFromJson(json);

Map<String, dynamic> toJson() => _$PriceLabelDtoToJson(this);
}

@JsonSerializable()
class ReviewedDto  {
const ReviewedDto({this.count, this.url, this.rate, })
    : super();

@JsonKey( name: 'count')
final int? count;
@JsonKey( name: 'url')
final String? url;
@JsonKey( name: 'rate')
final double? rate;


factory ReviewedDto.fromJson(Map<String, dynamic> json) =>
_$ReviewedDtoFromJson(json);

Map<String, dynamic> toJson() => _$ReviewedDtoToJson(this);
}

@JsonSerializable()
class SellerDto  {
const SellerDto({this.sellerId, this.name, this.url, this.isBestSeller, this.review, this.imageId, })
    : super();

@JsonKey( name: 'sellerId')
final String? sellerId;
@JsonKey( name: 'name')
final String? name;
@JsonKey( name: 'url')
final String? url;
@JsonKey( name: 'isBestSeller')
final bool? isBestSeller;
@JsonKey( name: 'review')
final ReviewSellerDto? review;
@JsonKey( name: 'imageId')
final String? imageId;

factory SellerDto.fromJson(Map<String, dynamic> json) =>
_$SellerDtoFromJson(json);

Map<String, dynamic> toJson() => _$SellerDtoToJson(this);
}

@JsonSerializable()
class ReviewSellerDto  {
const ReviewSellerDto({this.count, this.rate, })
    : super();

@JsonKey( name: 'rate')
final double? rate;
@JsonKey( name: 'count')
final int? count;



factory ReviewSellerDto.fromJson(Map<String, dynamic> json) =>
_$ReviewSellerDtoFromJson(json);

Map<String, dynamic> toJson() => _$ReviewSellerDtoToJson(this);
}

@JsonSerializable()
class PaginationDto  {
  const PaginationDto( {this.size, this.page, this.total,})
      : super();

  @JsonKey( name: 'size')
  final int? size;
  @JsonKey(name: 'page')
  final int? page;
  @JsonKey(name: 'total')
  final int? total;

  factory PaginationDto.fromJson(Map<String, dynamic> json) =>
      _$PaginationDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationDtoToJson(this);
}
