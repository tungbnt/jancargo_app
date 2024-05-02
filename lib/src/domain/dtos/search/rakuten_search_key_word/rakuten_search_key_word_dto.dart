import 'package:json_annotation/json_annotation.dart';

part 'rakuten_search_key_word_dto.g.dart';

@JsonSerializable()
class RakutenSearchKeyWordDto {
  const RakutenSearchKeyWordDto({
    this.results,
  }) : super();

  @JsonKey(name: 'results')
  final List<RakutenItemsSearchKeyWordDto>? results;

  factory RakutenSearchKeyWordDto.fromJson(Map<String, dynamic> json) =>
      _$RakutenSearchKeyWordDtoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$RakutenSearchKeyWordDtoToJson(this);
}
@JsonSerializable()
class RakutenItemsSearchKeyWordDto {
  const RakutenItemsSearchKeyWordDto({
    this.code, this.name, this.description, this.category, this.price, this.availability, this.tax, this.creditCard, this.postage, this.review, this.reviewCount, this.url, this.tagIds, this.thumbnails, this.image, this.endTime, this.startTime, this.store,
  }) : super();

  @JsonKey(name: 'code')
  final String? code;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'category')
  final String? category;
  @JsonKey(name: 'price')
  final int? price;
  @JsonKey(name: 'availability')
  final int? availability;
  @JsonKey(name: 'tax')
  final int? tax;
  @JsonKey(name: 'creditCard')
  final int? creditCard;
  @JsonKey(name: 'postage')
  final int? postage;
  @JsonKey(name: 'review')
  final double? review;
  @JsonKey(name: 'reviewCount')
  final int? reviewCount;
  @JsonKey(name: 'url')
  final String? url;
  @JsonKey(name: 'tagIds')
  final List<dynamic>? tagIds;
  @JsonKey(name: 'thumbnails')
  final List<String>? thumbnails;
  @JsonKey(name: 'image')
  final String? image;
  @JsonKey(name: 'endTime')
  final String? endTime;
  @JsonKey(name: 'startTime')
  final String? startTime;
  @JsonKey(name: 'store')
  final RakutenStoreSearchKeyWordDto? store;

  factory RakutenItemsSearchKeyWordDto.fromJson(Map<String, dynamic> json) =>
      _$RakutenItemsSearchKeyWordDtoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$RakutenItemsSearchKeyWordDtoToJson(this);
}

@JsonSerializable()
class RakutenStoreSearchKeyWordDto {
  const RakutenStoreSearchKeyWordDto({
    this.code, this.name, this.url,
  }) : super();

  @JsonKey(name: 'code')
  final String? code;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'url')
  final String? url;

  factory RakutenStoreSearchKeyWordDto.fromJson(Map<String, dynamic> json) =>
      _$RakutenStoreSearchKeyWordDtoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$RakutenStoreSearchKeyWordDtoToJson(this);
}