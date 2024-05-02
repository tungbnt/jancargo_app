import 'package:json_annotation/json_annotation.dart';
part'price_auction_request.g.dart';
@JsonSerializable()
class PriceRequest {
  PriceRequest({
    this.items,
    this.routeCode,
  });

  @JsonKey(name: 'items',)
  final List<PriceAuctionRequest>? items;
  @JsonKey(name: 'route_code',)
  final String? routeCode;


  Map<String, dynamic> toJson() => _$PriceRequestToJson(this);
}

@JsonSerializable()
class PriceCalculateCartRequest {
  PriceCalculateCartRequest({
    this.items,
    this.routeCode,
  });

  @JsonKey(name: 'items',)
  final List<CalculateCartRequest>? items;
  @JsonKey(name: 'route_code',)
  final String? routeCode;


  Map<String, dynamic> toJson() => _$PriceCalculateCartRequestToJson(this);
}

@JsonSerializable()
class CalculateCartRequest {
  CalculateCartRequest({this.price, this.qty, this.routeCode, this.tax, this.weight,
    this.exchangeRate, this.mode, this.originCountryShippingFee,
  });
  @JsonKey(name: 'exchange_rate', )
  final int? exchangeRate;
  @JsonKey(name: 'mode')
  final int? mode;
  @JsonKey(name: 'origin_country_shipping_fee')
  final int? originCountryShippingFee;
  @JsonKey(name: 'price')
  final int? price;
  @JsonKey(name: 'qty')
  final int? qty;
  @JsonKey(name: 'route_code')
  final String? routeCode;
  @JsonKey(name: 'tax')
  final int? tax;
  @JsonKey(name: 'weight')
  final int? weight;
  factory CalculateCartRequest.fromJson(Map<String, dynamic> json) =>
      _$CalculateCartRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CalculateCartRequestToJson(this);
}

@JsonSerializable()
class PriceAuctionRequest {
  PriceAuctionRequest({
    this.price, this.tax, this.qty,
  });
  @JsonKey(name: 'price', )
  final int? price;
  @JsonKey(name: 'tax')
  final int? tax;
  @JsonKey(name: 'qty')
  final int? qty;
  factory PriceAuctionRequest.fromJson(Map<String, dynamic> json) =>
      _$PriceAuctionRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PriceAuctionRequestToJson(this);
}