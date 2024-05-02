import 'package:json_annotation/json_annotation.dart';

part 'add_item_cart_dto.g.dart';

@JsonSerializable()
class AddItemCartDto {
  const AddItemCartDto({this.data}) : super();

  @JsonKey(name: 'data')
  final AddCartDto? data;

  factory AddItemCartDto.fromJson(Map<String, dynamic> json) =>
      _$AddItemCartDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AddItemCartDtoToJson(this);
}

@JsonSerializable()
class AddCartDto {
  const AddCartDto({this.idi, this.siteCode, this.code, this.name, this.url, this.qty, this.price, this.currency, this.sku, this.description, this.images, this.shipMode, this.status, this.userId, this.selected, this.options, this.createdDate, this.expireAt, this.v, }) : super();

  @JsonKey(name: '_id')
  final String? idi;
  @JsonKey(name: 'site_code')
  final String? siteCode;
  @JsonKey(name: 'code')
  final String? code;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'url')
  final String? url;
  @JsonKey(name: 'qty')
  final int? qty;
  @JsonKey(name: 'price')
  final int? price;
  @JsonKey(name: 'currency')
  final String? currency;
  @JsonKey(name: 'sku')
  final String? sku;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'images')
  final List<String>? images;
  @JsonKey(name: 'ship_mode')
  final String? shipMode;
  @JsonKey(name: 'status')
  final bool? status;
  @JsonKey(name: 'user_id')
  final String? userId;
  @JsonKey(name: 'selected')
  final bool? selected;
  @JsonKey(name: 'options')
  final List<dynamic>? options;
  @JsonKey(name: 'created_date')
  final String? createdDate;
  @JsonKey(name: 'expireAt')
  final String? expireAt;
  @JsonKey(name: '__v')
  final int? v;


  factory AddCartDto.fromJson(Map<String, dynamic> json) =>
      _$AddCartDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AddCartDtoToJson(this);
}
