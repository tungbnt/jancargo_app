import 'package:json_annotation/json_annotation.dart';

part 'seller_mercari_dto.g.dart';

@JsonSerializable()
class SellerDetailMercariDto {
  const SellerDetailMercariDto({ this.code, this.data, }) : super();

  @JsonKey(name: 'code')
  final int? code;
  @JsonKey(name: 'data')
  final SellerMercariDto? data;




  factory SellerDetailMercariDto.fromJson(Map<String, dynamic> json) =>
      _$SellerDetailMercariDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SellerDetailMercariDtoToJson(this);
}

@JsonSerializable()
class SellerMercariDto {
  const SellerMercariDto({ this.products, this.seller, }) : super();

  @JsonKey(name: 'products')
  final List<ItemsSellerMercariDto>? products;
  @JsonKey(name: 'seller')
  final InfoSellerMercariDto? seller;




  factory SellerMercariDto.fromJson(Map<String, dynamic> json) =>
      _$SellerMercariDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SellerMercariDtoToJson(this);
}

@JsonSerializable()
class ItemsSellerMercariDto {
  const ItemsSellerMercariDto({this.id, this.code, this.name, this.image, this.price, this.numComments, this.numLikes, this.pagerId, this.status, this.url, this.itemType, }) : super();

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
  @JsonKey(name: 'status')
  final String? status;
  @JsonKey(name: 'url')
  final String? url;
  @JsonKey(name: 'item_type')
  final String? itemType;




  factory ItemsSellerMercariDto.fromJson(Map<String, dynamic> json) =>
      _$ItemsSellerMercariDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ItemsSellerMercariDtoToJson(this);
}

@JsonSerializable()
class InfoSellerMercariDto {
  const InfoSellerMercariDto({ this.id, this.name, this.follower, this.following, this.rating, this.sell, this.ratings, this.score, this.star, this.avatar, this.introduction, this.url,}) : super();

  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'follower')
  final int? follower;
  @JsonKey(name: 'following')
  final int? following;
  @JsonKey(name: 'rating')
  final double? rating;
  @JsonKey(name: 'sell')
  final int? sell;
  @JsonKey(name: 'ratings')
  final RattingSellerMercariDto? ratings;
  @JsonKey(name: 'score')
  final int? score;
  @JsonKey(name: 'star')
  final double? star;
  @JsonKey(name: 'avatar')
  final String? avatar;
  @JsonKey(name: 'introduction')
  final String? introduction;
  @JsonKey(name: 'url')
  final String? url;


  factory InfoSellerMercariDto.fromJson(Map<String, dynamic> json) =>
      _$InfoSellerMercariDtoFromJson(json);

  Map<String, dynamic> toJson() => _$InfoSellerMercariDtoToJson(this);
}

@JsonSerializable()
class RattingSellerMercariDto {
  const RattingSellerMercariDto({ this.good, this.bad,}) : super();

  @JsonKey(name: 'good')
  final double? good;
  @JsonKey(name: 'bad')
  final double? bad;

  factory RattingSellerMercariDto.fromJson(Map<String, dynamic> json) =>
      _$RattingSellerMercariDtoFromJson(json);

  Map<String, dynamic> toJson() => _$RattingSellerMercariDtoToJson(this);
}
