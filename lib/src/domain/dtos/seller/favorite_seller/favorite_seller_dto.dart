import 'package:json_annotation/json_annotation.dart';

part 'favorite_seller_dto.g.dart';

@JsonSerializable()
class FavoriteSellerDto {
  const FavoriteSellerDto({ this.code, this.data, }) : super();

  @JsonKey(name: 'code')
  final int? code;
  @JsonKey(name: 'data')
  final List<FavoriteSellerItemDto>? data;




  factory FavoriteSellerDto.fromJson(Map<String, dynamic> json) =>
      _$FavoriteSellerDtoFromJson(json);

  Map<String, dynamic> toJson() => _$FavoriteSellerDtoToJson(this);
}

@JsonSerializable()
class FavoriteSellerItemDto {
  const FavoriteSellerItemDto({ this.code, this.id, this.avatar, this.createdDate, this.deleted, this.description, this.expireAt, this.name, this.remark, this.siteCode, this.status, this.type, this.url, this.userId,  }) : super();

  @JsonKey(name: '_id')
  final String? id;
  @JsonKey(name: 'avatar')
  final String? avatar;
  @JsonKey(name: 'code')
  final String? code;
  @JsonKey(name: 'created_date')
  final String? createdDate;
  @JsonKey(name: 'deleted')
  final bool? deleted;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'expireAt')
  final String? expireAt;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'remark')
  final String? remark;
  @JsonKey(name: 'site_code')
  final String? siteCode;
  @JsonKey(name: 'status')
  final bool? status;
  @JsonKey(name: 'type')
  final String? type;
  @JsonKey(name: 'url')
  final String? url;
  @JsonKey(name: 'user_id')
  final String? userId;


  factory FavoriteSellerItemDto.fromJson(Map<String, dynamic> json) =>
      _$FavoriteSellerItemDtoFromJson(json);

  Map<String, dynamic> toJson() => _$FavoriteSellerItemDtoToJson(this);
}
