import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auction_dto.g.dart';
@JsonSerializable()
class AuctionDto  {
  const AuctionDto( {this.category, this.todayEnds, this.results, this.pagination,})
      : super();

  @JsonKey(required: true,name: 'results')
  final List<AuctionItemsDto>? results;
  @JsonKey(name: 'category')
  final String? category;

  @JsonKey(required: true, name: 'pagination')
  final PaginationDto? pagination;
  @JsonKey( name: 'today_ends')
  final List<String>? todayEnds;

  factory AuctionDto.fromJson(Map<String, dynamic> json) =>
      _$AuctionDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AuctionDtoToJson(this);
}

@JsonSerializable()
class AuctionItemsDto  {
   AuctionItemsDto( this.favorite,{this.code, this.name, this.url, this.image, this.price, this.priceBuy, this.endTime, this.sellerId, this.bids, this.newW, this.used, this.freeShip,  })
      : super();

  @JsonKey(name: 'code')
  final String? code;

  @JsonKey( name: 'name')
  final String? name;
  @JsonKey( name: 'url')
  final String? url;
  @JsonKey(name: 'image')
  final String? image;
  @JsonKey( name: 'price')
  final int? price;
  @JsonKey( name: 'price_buy')
  final dynamic priceBuy;
  @JsonKey(name: 'end_time')
  final String? endTime;
  @JsonKey( name: 'seller_id')
  final String? sellerId;
  @JsonKey( name: 'bids')
  final String? bids;
  @JsonKey(name: 'newW')
  final bool? newW;
  @JsonKey(name: 'used')
  final bool? used;
  @JsonKey(name: 'favorite',fromJson: _favoriteFromJson,toJson: _favoriteToJson)
  final ValueNotifier<bool> favorite;
  @JsonKey(name: 'freeship')
  final bool? freeShip;

  static ValueNotifier<bool> _favoriteFromJson(bool? value) =>
      ValueNotifier<bool>(value ?? false);

  static bool _favoriteToJson(ValueNotifier<bool> favorite) =>
      favorite.value;


  factory AuctionItemsDto.fromJson(Map<String, dynamic> json) =>
      _$AuctionItemsDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AuctionItemsDtoToJson(this);
}


@JsonSerializable()
class PaginationDto  {
  const PaginationDto( {this.size, this.page, this.total,})
      : super();

  @JsonKey(required: true, name: 'size')
  final int? size;
  @JsonKey(required: true, name: 'page')
  final int? page;
  @JsonKey(required: true, name: 'total')
  final int? total;

  factory PaginationDto.fromJson(Map<String, dynamic> json) =>
      _$PaginationDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationDtoToJson(this);
}

@JsonSerializable()
class PageRenderDto  {
  const PageRenderDto( {this.page, this.disabled,})
      : super();

  @JsonKey( name: 'page')
  final String? page;
  @JsonKey(name: 'disabled')
  final bool? disabled;


  factory PageRenderDto.fromJson(Map<String, dynamic> json) =>
      _$PageRenderDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PageRenderDtoToJson(this);
}
@JsonSerializable()
class CategoriesDto  {
  const CategoriesDto(  {this.href, this.text, this.vModule, this.clLink, this.catId})
      : super();

  @JsonKey( name: 'href')
  final String? href;
  @JsonKey(name: 'text')
  final String? text;
  @JsonKey( name: '_cl_vmodule')
  final String? vModule;
  @JsonKey( name: '_cl_link')
  final String? clLink;
  @JsonKey(name: 'catid')
  final String? catId;



  factory CategoriesDto.fromJson(Map<String, dynamic> json) =>
      _$CategoriesDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CategoriesDtoToJson(this);
}
@JsonSerializable()
class PopularBrandsDto  {
  const PopularBrandsDto({this.title, this.image, this.originUrl, this.query, this.category, })
      : super();

  @JsonKey( name: 'title')
  final String? title;
  @JsonKey( name: 'image')
  final String? image;
  @JsonKey( name: 'origin_url')
  final String? originUrl;
  @JsonKey(name: 'query')
  final QueryDto? query;
  @JsonKey(name: 'category')
  final String? category;



  factory PopularBrandsDto.fromJson(Map<String, dynamic> json) =>
      _$PopularBrandsDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PopularBrandsDtoToJson(this);
}
@JsonSerializable()
class QueryDto  {
  const QueryDto( {this.brandId,})
      : super();

  @JsonKey( name: 'brand_id')
  final String? brandId;




  factory QueryDto.fromJson(Map<String, dynamic> json) =>
      _$QueryDtoFromJson(json);

  Map<String, dynamic> toJson() => _$QueryDtoToJson(this);
}
