import 'package:json_annotation/json_annotation.dart';

part'auction_off_request.g.dart';
@JsonSerializable()
class AuctionOffRequest {
  AuctionOffRequest( {this.saleId,this.lastMinuteToBid, this.mode, this.price, this.code, this.name, this.url, this.tax, this.shipMode, this.shippingCharges, this.exchangeRate, this.currency, this.images, this.serviceExtra, this.bids, this.endTime, this.reputationLevel, this.qty, this.sellerId, this.paymentMethods, this.partial,
  this.items,
  });

  @JsonKey(name: 'user_id',)
  final String? items;
  @JsonKey(name: 'price',)
  final String? price;
  @JsonKey(name: 'code',)
  final String? code;
  @JsonKey(name: 'name',)
  final String? name;
  @JsonKey(name: 'url',)
  final String? url;
  @JsonKey(name: 'tax',)
  final String? tax;
  @JsonKey(name: 'ship_mode',)
  final String? shipMode;
  @JsonKey(name: 'shipping_charges',)
  final String? shippingCharges;
  @JsonKey(name: 'exchange_rate',)
  final String? exchangeRate;
  @JsonKey(name: 'currency',)
  final String? currency;
  @JsonKey(name: 'images',)
  final List<String>? images;
  @JsonKey(name: 'service_extra',)
  final List<String>? serviceExtra;
  @JsonKey(name: 'bids',)
  final int? bids;
  @JsonKey(name: 'end_time',)
  final String? endTime;
  @JsonKey(name: 'reputation_level',)
  final String? reputationLevel;
  @JsonKey(name: 'qty',)
  final String? qty;
  @JsonKey(name: 'seller_id',)
  final String? sellerId;
  @JsonKey(name: 'payment_methods',)
  final List<String>? paymentMethods;
  @JsonKey(name: 'mode',)
  final String? mode;
  @JsonKey(name: 'last_minute_to_bid',)
  final String? lastMinuteToBid;
  @JsonKey(name: 'sale_id')
  final String? saleId;
  @JsonKey(name: 'partial')
  final String? partial;


  Map<String, dynamic> toJson() => _$AuctionOffRequestToJson(this);
}