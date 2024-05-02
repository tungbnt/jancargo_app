import 'package:json_annotation/json_annotation.dart';

part 'search_rakuten_dto.g.dart';
@JsonSerializable()
class SearchRakutenDto  {
  const SearchRakutenDto( {this.data,})
      : super();

  @JsonKey(name: 'data')
  final List<RakutensDto>? data;



  factory SearchRakutenDto.fromJson(Map<String, dynamic> json) =>
      _$SearchRakutenDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SearchRakutenDtoToJson(this);
}

@JsonSerializable()
class RakutensDto  {
   RakutensDto( {this.isItemSavedCart,this.store,this.code, this.image, this.name, this.description, this.category, this.price, this.availability, this.tax, this.creditCard, this.postage, this.review, this.reviewCount, this.url, this.tagIds, this.thumbnails, this.endTime, this.startTime, })
      : super();


  @JsonKey( name: 'code')
  final String? code;
  @JsonKey( name: 'image')
  final String? image;
  @JsonKey( name: 'isItemSavedCart')
  bool? isItemSavedCart;

  @JsonKey(name: 'name')
  final String? name;
  @JsonKey( name: 'description')
  final String? description;
  @JsonKey( name: 'category')
  final String? category;
  @JsonKey( name: 'price')
  final int? price;
  @JsonKey( name: 'availability')
  final int? availability;
  @JsonKey( name: 'tax')
  final int? tax;
  @JsonKey( name: 'creditCard')
  final int? creditCard;
  @JsonKey( name: 'postage')
  final int? postage;
  @JsonKey( name: 'review')
  final double? review;
  @JsonKey( name: 'review_count')
  final int? reviewCount;
  @JsonKey( name: 'url')
  final String? url;
  @JsonKey( name: 'tagIds')
  final List<int>? tagIds;
@JsonKey( name: 'thumbnails')
final List<String>? thumbnails;
@JsonKey( name: 'endTime')
final String? endTime;
@JsonKey( name: 'startTime')
final String? startTime;
  @JsonKey( name: 'store')
  final StoreDto? store;



  factory RakutensDto.fromJson(Map<String, dynamic> json) =>
      _$RakutensDtoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$RakutensDtoToJson(this);
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
