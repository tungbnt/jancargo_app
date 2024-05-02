import 'package:json_annotation/json_annotation.dart';

part 'info_product_dto.g.dart';
@JsonSerializable()
class InfoProductDto  {
  const InfoProductDto({this.sellerId,this.percent,  this.code, this.url, this.name, this.price, this.tax, this.priceBuy, this.taxBuy, this.feeShip, this.fromOutsideOfapan, this.thumbnails, this.description, this.qty, this.categoryId, this.startDate, this.endDate, this.earlyClose, this.autoExtension, this.returnable, this.biderRestriction, this.bidderVerification, this.initPrice, this.condition, this.bids, this.postage, this.finished, this.wonInfo, this.timeLeft, this.endTime, })
      : super();

  @JsonKey(name: 'code')
  final String? code;

  @JsonKey(name: 'url')
  final String? url;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'price')
  final int? price;
  @JsonKey(name: 'tax')
  final int? tax;
  @JsonKey(name: 'price_buy')
  final int? priceBuy;
  @JsonKey(name: 'tax_buy')
  final int? taxBuy;
  @JsonKey(name: 'feeship')
  final int? feeShip;
  @JsonKey(name: 'from_outside_of_japan')
  final bool? fromOutsideOfapan;
  @JsonKey(name: 'thumbnails')
  final List<String>? thumbnails;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'qty')
  final int? qty;
  @JsonKey(name: 'category_id')
  final String? categoryId;
  @JsonKey(name: 'start_date')
  final String? startDate;
  @JsonKey(name: 'end_date')
  final String? endDate;
  @JsonKey(name: 'early_close')
  final bool? earlyClose;
  @JsonKey(name: 'auto_extension')
  final bool? autoExtension;
  @JsonKey(name: 'returnable')
  final bool? returnable;
  @JsonKey(name: 'bider_restriction')
  final bool? biderRestriction;
  @JsonKey(name: 'bidder_verification')
  final bool? bidderVerification;
  @JsonKey(name: 'init_price')
  final int? initPrice;
  @JsonKey(name: 'condition')
  final String? condition;
  @JsonKey(name: 'bids')
  final int? bids;
  @JsonKey(name: 'postage')
  final bool? postage;
  @JsonKey(name: 'finished')
  final bool? finished;
  @JsonKey(name: 'won_info')
  final dynamic wonInfo;
  @JsonKey(name: 'time_left')
  final int? timeLeft;
  @JsonKey(name: 'end_time')
  final String? endTime;
  @JsonKey(name: 'seller')
  final String? sellerId;
  @JsonKey(name: 'percent')
  final String? percent;




  factory InfoProductDto.fromJson(Map<String, dynamic> json) =>
      _$InfoProductDtoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$InfoProductDtoToJson(this);
}

