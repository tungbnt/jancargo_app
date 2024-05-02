import 'package:json_annotation/json_annotation.dart';
part'add_cart_request.g.dart';
@JsonSerializable()
class AddCartRequest {
  AddCartRequest({
    this.siteCode, this.code, this.name, this.url, this.price, this.currency, this.qty, this.description, this.images, this.shipMode,
  });

  @JsonKey(name: 'site_code',)
  final String? siteCode;
  @JsonKey(name: 'code',)
  final String? code;
  @JsonKey(name: 'name',)
  final String? name;
  @JsonKey(name: 'url',)
  final String? url;
  @JsonKey(name: 'price',)
  final int? price;
  @JsonKey(name: 'currency',)
  final String? currency;
  @JsonKey(name: 'qty',)
  final int? qty;
  @JsonKey(name: 'description',)
  final String? description;
  @JsonKey(name: 'images',)
  final List<String>? images;
  @JsonKey(name: 'ship_mode',)
  final String? shipMode;



  Map<String, dynamic> toJson() => _$AddCartRequestToJson(this);
}