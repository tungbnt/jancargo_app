import 'package:json_annotation/json_annotation.dart';

part 'search_all_dto.g.dart';

@JsonSerializable()
class SearchAllDto {
  const SearchAllDto({
    this.data,
    this.meta,
  }) : super();

  @JsonKey(name: 'results')
  final List<AllSearchs>? data;

  @JsonKey(name: 'query')
  final String? meta;

  factory SearchAllDto.fromJson(Map<String, dynamic> json) =>
      _$SearchAllDtoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SearchAllDtoToJson(this);
}

@JsonSerializable()
class AllSearchs {
  const AllSearchs({
    this.products,
    this.type,
    this.total,
  }) : super();

  @JsonKey(name: 'products')
  final List<AllSearchItems>? products;
  @JsonKey(name: 'total')
  final int? total;
  @JsonKey(name: 'type')
  final String? type;

  factory AllSearchs.fromJson(Map<String, dynamic> json) =>
      _$AllSearchsFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AllSearchsToJson(this);
}

@JsonSerializable()
class AllSearchItems {
  const AllSearchItems({
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
    this.used,
    this.freeship,
    this.itemType,
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
  final dynamic priceBuy;
  @JsonKey(name: 'end_time')
  final String? endTime;
  @JsonKey(name: 'seller_id')
  final String? sellerId;
  @JsonKey(name: 'bids')
  final int? bids;
  @JsonKey(name: 'new')
  final bool? newW;
  @JsonKey(name: 'used')
  final bool? used;
  @JsonKey(name: 'freeship')
  final bool? freeship;
  @JsonKey(name: 'item_type')
  final String? itemType;

  factory AllSearchItems.fromJson(Map<String, dynamic> json) =>
      _$AllSearchItemsFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AllSearchItemsToJson(this);
}