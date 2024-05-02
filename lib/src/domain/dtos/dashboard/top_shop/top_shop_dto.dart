import 'package:json_annotation/json_annotation.dart';

part 'top_shop_dto.g.dart';
@JsonSerializable()
class TopShopDto  {
  const TopShopDto( {this.results, this.pagination,})
      : super();

  @JsonKey(required: true,name: 'results')
  final List<ShopDto>? results;

  @JsonKey(required: true, name: 'pagination')
  final PaginationDto? pagination;

  factory TopShopDto.fromJson(Map<String, dynamic> json) =>
      _$TopShopDtoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$TopShopDtoToJson(this);
}

@JsonSerializable()
class ShopDto  {
  const ShopDto({this.id, this.code, this.image, this.name, this.productUrl, this.siteCode, this.view,  })
      : super();

  @JsonKey(name: '_id')
  final String? id;

  @JsonKey( name: 'code')
  final String? code;
  @JsonKey( name: 'image')
  final String? image;

  @JsonKey(name: 'name')
  final String? name;
  @JsonKey( name: 'product_type')
  final String? productUrl;
  @JsonKey( name: 'site_code')
  final String? siteCode;
  @JsonKey( name: 'view')
  final int? view;


  factory ShopDto.fromJson(Map<String, dynamic> json) =>
      _$ShopDtoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ShopDtoToJson(this);
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

  @override
  Map<String, dynamic> toJson() => _$PaginationDtoToJson(this);
}
