import 'package:json_annotation/json_annotation.dart';

part 'favorite_request.g.dart';

@JsonSerializable()
class FavoriteRequest {
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

  FavoriteRequest( {
    this.siteCode, this.code, this.name, this.url, this.price, this.currency, this.qty, this.endTime, this.images,
  });
  Map<String, dynamic> toJson() => _$FavoriteRequestToJson(this);
}

