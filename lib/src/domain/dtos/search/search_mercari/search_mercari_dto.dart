import 'package:json_annotation/json_annotation.dart';

part 'search_mercari_dto.g.dart';

@JsonSerializable()
class SearchMercariDto {
  const SearchMercariDto({
    this.data,
    this.meta,
  }) : super();

  @JsonKey(name: 'data')
  final List<MercarisDto>? data;

  @JsonKey(name: 'meta')
  final MetaDto? meta;

  factory SearchMercariDto.fromJson(Map<String, dynamic> json) =>
      _$SearchMercariDtoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SearchMercariDtoToJson(this);
}

@JsonSerializable()
class MercarisDto {
   MercarisDto({
    this.isItemSavedCart,
    this.price,
    this.numComments,
    this.numLikes,
    this.pagerId,
    this.status,
    this.url,
    this.id,
    this.code,
    this.image,
    this.name,
  }) : super();

  @JsonKey(name: 'id')
  final String? id;

  @JsonKey(name: 'code')
  final String? code;
  @JsonKey(name: 'image')
  final String? image;
  @JsonKey(name: 'isItemSavedCart')
  bool? isItemSavedCart;

  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'price')
  final int? price;
  @JsonKey(name: 'num_comments')
  final int? numComments;
  @JsonKey(name: 'num_likes')
  final int? numLikes;
  @JsonKey(name: 'pager_id')
  final int? pagerId;
  @JsonKey(name: 'status')
  final String? status;
  @JsonKey(name: 'url')
  final String? url;

  factory MercarisDto.fromJson(Map<String, dynamic> json) =>
      _$MercarisDtoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MercarisDtoToJson(this);
}

@JsonSerializable()
class MetaDto {
  const MetaDto({
    this.hasNextPage,
    this.endCursor,
  }) : super();

  @JsonKey(name: 'hasNextPage')
  final bool? hasNextPage;
  @JsonKey(name: 'endCursor')
  final int? endCursor;

  factory MetaDto.fromJson(Map<String, dynamic> json) =>
      _$MetaDtoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MetaDtoToJson(this);
}
