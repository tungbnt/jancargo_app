import 'package:json_annotation/json_annotation.dart';

part 'flash_sale_dto.g.dart';
@JsonSerializable()
class FlashSaleDto  {
  const FlashSaleDto( {this.data,})
      : super();

  @JsonKey(name: 'data')
  final List<ItemSaleDto>? data;



  factory FlashSaleDto.fromJson(Map<String, dynamic> json) =>
      _$FlashSaleDtoFromJson(json);

  Map<String, dynamic> toJson() => _$FlashSaleDtoToJson(this);
}

@JsonSerializable()
class ItemSaleDto  {
   ItemSaleDto({this.isItemSavedCart,this.discountRate,this.id, this.guid, this.reviewUrl,this.store,this.code, this.image, this.name, this.description, this.category, this.price, this.availability, this.tax, this.creditCard, this.postage, this.review, this.reviewCount, this.url, this.tagIds, this.thumbnails, this.endTime, this.startTime, })
      : super();

  @JsonKey( name: 'id')
  final String? id;
  @JsonKey( name: 'guid')
  final String? guid;
  @JsonKey( name: 'code')
  final String? code;
  @JsonKey( name: 'image')
  final String? image;
  @JsonKey( name: 'isItemSavedCart')
  bool? isItemSavedCart;

  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'discount_rate')
  final int? discountRate;
  @JsonKey( name: 'description')
  final String? description;
  @JsonKey( name: 'category')
  final String? category;
  @JsonKey( name: 'price')
  final int? price;
  @JsonKey( name: 'availability')
  final dynamic availability;
  @JsonKey( name: 'tax')
  final String? tax;
  @JsonKey( name: 'creditCard')
  final String? creditCard;
  @JsonKey( name: 'postage')
  final String? postage;
  @JsonKey( name: 'review')
  final double? review;
  @JsonKey( name: 'review_count')
  final int? reviewCount;
  @JsonKey( name: 'review_url')
  final String? reviewUrl;
  @JsonKey( name: 'url')
  final String? url;
  @JsonKey( name: 'tagIds')
  final String? tagIds;
  @JsonKey( name: 'thumbnails')
  final List<String>? thumbnails;
  @JsonKey( name: 'endTime')
  final String? endTime;
  @JsonKey( name: 'startTime')
  final String? startTime;
  @JsonKey( name: 'store')
  final StoreDto? store;



  factory ItemSaleDto.fromJson(Map<String, dynamic> json) =>
      _$ItemSaleDtoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ItemSaleDtoToJson(this);
}


@JsonSerializable()
class StoreDto  {
  const StoreDto({this.code, this.name, this.url,})
      : super();

  @JsonKey( name: 'code')
  final String? code;
  @JsonKey( name: 'name')
  final String? name;
  @JsonKey( name: 'url')
  final String? url;


  factory StoreDto.fromJson(Map<String, dynamic> json) =>
      _$StoreDtoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$StoreDtoToJson(this);
}
