import 'package:json_annotation/json_annotation.dart';
part 'favorite_seller_request.g.dart';

@JsonSerializable()
class FavoriteSellerRequest {
  @JsonKey(name: 'code', )
  final String? code;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'image')
  final String? image;
  @JsonKey(name: 'name',)
  final String? name;
  @JsonKey(name: 'remark',)
  final String? remark;
  @JsonKey(name: 'url',)
  final String? url;
  @JsonKey(name: 'site_code',)
  final String? siteCode;

  FavoriteSellerRequest({
    this.code, this.description, this.image, this.name, this.remark, this.url, this.siteCode,
  });
  Map<String, dynamic> toJson() => _$FavoriteSellerRequestToJson(this);
}
