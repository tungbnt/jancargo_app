import 'package:json_annotation/json_annotation.dart';

part 'relates_dto.g.dart';

@JsonSerializable()
class RelateDto  {
  const RelateDto({this.data})
      : super();

  @JsonKey(name: 'data')
  final List<RelatesDto>? data;



  factory RelateDto.fromJson(Map<String, dynamic> json) =>
      _$RelateDtoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$RelateDtoToJson(this);
}

@JsonSerializable()
class  RelatesDto {
  RelatesDto(this.index, this.bids, this.code, this.endTime, this.freeShip, this.closing, this.image, this.name, this.neww, this.price, this.priceBuy, this.sellerId, this.url, this.used, this.type, )  : super();

  @JsonKey(name: 'index')
  final int? index;
  @JsonKey(name: 'bids')
  final dynamic bids;
  @JsonKey(name: 'code')
  final dynamic code;
  @JsonKey(name: 'end_time')
  final String? endTime;
  @JsonKey(name: 'freeship')
  final bool? freeShip;
  @JsonKey(name: 'closing')
  final bool? closing;
  @JsonKey(name: 'image')
  final String? image;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'new')
  final bool? neww;
  @JsonKey(name: 'price')
  final int? price;
  @JsonKey(name: 'price_buy')
  final dynamic priceBuy;
  @JsonKey(name: 'seller_id')
  final String? sellerId;
  @JsonKey(name: 'url')
  final String? url;
  @JsonKey(name: 'used')
  final bool? used;
  @JsonKey(name: 'type')
  final String? type;



  factory RelatesDto.fromJson(Map<String, dynamic> json) =>
      _$RelatesDtoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$RelatesDtoToJson(this);
}