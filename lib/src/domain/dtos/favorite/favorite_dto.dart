import 'package:json_annotation/json_annotation.dart';
part 'favorite_dto.g.dart';


@JsonSerializable()
class FavoriteDto {
  @JsonKey(name: 'data')
  final List<FavoriteItems>? data;
  @JsonKey(name: 'message')
  final String? message;
  @JsonKey(name: 'code')
  final int? code;


  FavoriteDto( {
    this.data, this.message, this.code,
  });

  factory FavoriteDto.fromJson(Map<String, dynamic> json) =>
      _$FavoriteDtoFromJson(json);

  Map<String, dynamic> toJson() => _$FavoriteDtoToJson(this);
}

@JsonSerializable()
class FavoriteSearchDto {
  @JsonKey(name: 'results')
  final List<FavoriteItems>? results;



  FavoriteSearchDto( {
   this.results,
  });

  factory FavoriteSearchDto.fromJson(Map<String, dynamic> json) =>
      _$FavoriteSearchDtoFromJson(json);

  Map<String, dynamic> toJson() => _$FavoriteSearchDtoToJson(this);
}


@JsonSerializable()
class FavoriteItems {
  @JsonKey(name: 'site_code')
  final String? siteCode;
  @JsonKey(name: 'code')
  final String? code;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'url')
  final String? url;
  @JsonKey(name: 'price')
  final int? price;
  @JsonKey(name: 'currency')
  final String? currency;
  @JsonKey(name: 'qty')
  final int? qty;
  @JsonKey(name: 'end_time')
  final String? endTime;
  @JsonKey(name: 'images')
  final List<String>? images;
  @JsonKey(name: '_id')
  final String? id;
  @JsonKey(name: '__v')
  final int? v;
  @JsonKey(name: 'created_date')
  final String? createdDate;
  @JsonKey(name: 'user_id')
  final String? userId;
  @JsonKey(name: 'status')
  final bool? status;
  @JsonKey(name: 'deleted')
  final bool? deleted;
  @JsonKey(name: 'liked')
  final int? liked;
  @JsonKey(name: 'sku')
  final String? sku;

  FavoriteItems(  {
    this.id, this.v, this.createdDate, this.userId, this.status, this.deleted, this.liked, this.sku,this.siteCode, this.code, this.name, this.url, this.price, this.currency, this.qty, this.endTime, this.images,
  });

  factory FavoriteItems.fromJson(Map<String, dynamic> json) =>
      _$FavoriteItemsFromJson(json);

  Map<String, dynamic> toJson() => _$FavoriteItemsToJson(this);
}