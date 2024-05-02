import 'package:json_annotation/json_annotation.dart';

import '../../../domain/dtos/user/address_user/address_user_dto.dart';
part'payment_oder_request.g.dart';

@JsonSerializable()
class PaymentOderRequest {
  PaymentOderRequest({
    this.address, this.quotes,
  });

  @JsonKey(name: 'address',)
  final ItemsAddressUser? address;
  @JsonKey(name: 'quotes',)
  final List<QuotesPaymentOderRequest>? quotes;

  factory PaymentOderRequest.fromJson(Map<String, dynamic> json) =>
      _$PaymentOderRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentOderRequestToJson(this);
}

@JsonSerializable()
class QuotesPaymentOderRequest {
  QuotesPaymentOderRequest(  {
    this.weight, this.weightRate,  this.servicesExtra, this.shipMode, this.shippingCharges, this.site, this.subPayment, this.subtotal, this.tax, this.total, this.totalCurrency, this.webCode,  this.link, this.name, this.note, this.payment, this.paymentCurrency, this.percentRate, this.price, this.quality, this.quoteId, this.routeCode, this.serviceCurrency, this.currency, this.description, this.discountExtra, this.discountOther, this.discountPayment, this.discountService, this.discountShip, this.exchangePrice,this.exchangeRate, this.extraPrice, this.feeDomestic, this.feeExtra, this.feeOther, this.feeShip, this.goodsValues, this.id, this.imageRoot, this.isBid,
  });

  @JsonKey(name: 'currency',)
  final String? currency;
  @JsonKey(name: 'description',)
  final String? description;
  @JsonKey(name: 'discount_extra',)
  final int? discountExtra;
  @JsonKey(name: 'discount_other',)
  final int? discountOther;
  @JsonKey(name: 'discount_payment',)
  final int? discountPayment;
  @JsonKey(name: 'discount_service',)
  final int? discountService;
  @JsonKey(name: 'discount_ship',)
  final int? discountShip;
  @JsonKey(name: 'exchange_price',)
  final int? exchangePrice;
  @JsonKey(name: 'exchange_rate',)
  final int? exchangeRate;
  @JsonKey(name: 'extra_price',)
  final int? extraPrice;
  @JsonKey(name: 'fee_domestic',)
  final int? feeDomestic;
  @JsonKey(name: 'fee_extra',)
  final int? feeExtra;
  @JsonKey(name: 'fee_other',)
  final int? feeOther;
  @JsonKey(name: 'fee_ship',)
  final int? feeShip;
  @JsonKey(name: 'goods_values',)
  final int? goodsValues;
  @JsonKey(name: 'id',)
  final String? id;
  @JsonKey(name: 'image_root',)
  final String? imageRoot;
  @JsonKey(name: 'is_bid',)
  final bool? isBid;
  @JsonKey(name: 'link',)
  final String? link;
  @JsonKey(name: 'name',)
  final String? name;
  @JsonKey(name: 'note',)
  final String? note;
  @JsonKey(name: 'payment',)
  final int? payment;
  @JsonKey(name: 'payment_currency',)
  final int? paymentCurrency;
  @JsonKey(name: 'percent_rate',)
  final double? percentRate;
  @JsonKey(name: 'price',)
  final int? price;
  @JsonKey(name: 'quality',)
  final int? quality;
  @JsonKey(name: 'quote_id',)
  final String? quoteId;
  @JsonKey(name: 'route_code',)
  final String? routeCode;
  @JsonKey(name: 'service_currency',)
  final int? serviceCurrency;
  @JsonKey(name: 'services_extra',)
  final List<String>? servicesExtra;
  @JsonKey(name: 'ship_mode',)
  final String? shipMode;
  @JsonKey(name: 'shipping_charges',)
  final String? shippingCharges;
  @JsonKey(name: 'site',)
  final String? site;
  @JsonKey(name: 'subpayment',)
  final int? subPayment;
  @JsonKey(name: 'subtotal',)
  final int? subtotal;
  @JsonKey(name: 'tax',)
  final int? tax;
  @JsonKey(name: 'total',)
  final int? total;
  @JsonKey(name: 'total_currency',)
  final int? totalCurrency;
  @JsonKey(name: 'web_code',)
  final String? webCode;
  @JsonKey(name: 'weight',)
  final double? weight;
  @JsonKey(name: 'weight_rate',)
  final double? weightRate;

  factory QuotesPaymentOderRequest.fromJson(Map<String, dynamic> json) =>
      _$QuotesPaymentOderRequestFromJson(json);
  Map<String, dynamic> toJson() => _$QuotesPaymentOderRequestToJson(this);
}