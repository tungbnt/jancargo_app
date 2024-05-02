import 'package:json_annotation/json_annotation.dart';

part 'mecari_search_key_word_dto.g.dart';

@JsonSerializable()
class MercariSearchKeyWordDto {
  const MercariSearchKeyWordDto({
    this.products,
  }) : super();

  @JsonKey(name: 'products')
  final List<MercariSearchKeyWordItemDto>? products;

  factory MercariSearchKeyWordDto.fromJson(Map<String, dynamic> json) =>
      _$MercariSearchKeyWordDtoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MercariSearchKeyWordDtoToJson(this);
}

@JsonSerializable()
class MercariSearchKeyWordItemDto {
  const MercariSearchKeyWordItemDto({
    this.id, this.code, this.name, this.image, this.price, this.numComments, this.numLikes, this.pagerId, this.buyerId, this.status, this.url, this.itemType,
  }) : super();

  @JsonKey(name: 'id')
  final String? id;

  @JsonKey(name: 'code')
  final String? code;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'image')
  final String? image;
  @JsonKey(name: 'price')
  final int? price;
  @JsonKey(name: 'num_comments')
  final int? numComments;
  @JsonKey(name: 'num_likes')
  final int? numLikes;
  @JsonKey(name: 'pager_id')
  final int? pagerId;
  @JsonKey(name: 'buyer_id')
  final String? buyerId;
  @JsonKey(name: 'status')
  final String? status;
  @JsonKey(name: 'url')
  final String? url;
  @JsonKey(name: 'item_type')
  final String? itemType;



  factory MercariSearchKeyWordItemDto.fromJson(Map<String, dynamic> json) =>
      _$MercariSearchKeyWordItemDtoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MercariSearchKeyWordItemDtoToJson(this);
}