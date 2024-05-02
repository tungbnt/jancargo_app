// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_oder_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentOderRequest _$PaymentOderRequestFromJson(Map<String, dynamic> json) =>
    PaymentOderRequest(
      address: json['address'] == null
          ? null
          : ItemsAddressUser.fromJson(json['address'] as Map<String, dynamic>),
      quotes: (json['quotes'] as List<dynamic>?)
          ?.map((e) =>
              QuotesPaymentOderRequest.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PaymentOderRequestToJson(PaymentOderRequest instance) =>
    <String, dynamic>{
      'address': instance.address,
      'quotes': instance.quotes,
    };

QuotesPaymentOderRequest _$QuotesPaymentOderRequestFromJson(
        Map<String, dynamic> json) =>
    QuotesPaymentOderRequest(
      weight: (json['weight'] as num?)?.toDouble(),
      weightRate: (json['weight_rate'] as num?)?.toDouble(),
      servicesExtra: (json['services_extra'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      shipMode: json['ship_mode'] as String?,
      shippingCharges: json['shipping_charges'] as String?,
      site: json['site'] as String?,
      subPayment: json['subpayment'] as int?,
      subtotal: json['subtotal'] as int?,
      tax: json['tax'] as int?,
      total: json['total'] as int?,
      totalCurrency: json['total_currency'] as int?,
      webCode: json['web_code'] as String?,
      link: json['link'] as String?,
      name: json['name'] as String?,
      note: json['note'] as String?,
      payment: json['payment'] as int?,
      paymentCurrency: json['payment_currency'] as int?,
      percentRate: (json['percent_rate'] as num?)?.toDouble(),
      price: json['price'] as int?,
      quality: json['quality'] as int?,
      quoteId: json['quote_id'] as String?,
      routeCode: json['route_code'] as String?,
      serviceCurrency: json['service_currency'] as int?,
      currency: json['currency'] as String?,
      description: json['description'] as String?,
      discountExtra: json['discount_extra'] as int?,
      discountOther: json['discount_other'] as int?,
      discountPayment: json['discount_payment'] as int?,
      discountService: json['discount_service'] as int?,
      discountShip: json['discount_ship'] as int?,
      exchangePrice: json['exchange_price'] as int?,
      exchangeRate: json['exchange_rate'] as int?,
      extraPrice: json['extra_price'] as int?,
      feeDomestic: json['fee_domestic'] as int?,
      feeExtra: json['fee_extra'] as int?,
      feeOther: json['fee_other'] as int?,
      feeShip: json['fee_ship'] as int?,
      goodsValues: json['goods_values'] as int?,
      id: json['id'] as String?,
      imageRoot: json['image_root'] as String?,
      isBid: json['is_bid'] as bool?,
    );

Map<String, dynamic> _$QuotesPaymentOderRequestToJson(
        QuotesPaymentOderRequest instance) =>
    <String, dynamic>{
      'currency': instance.currency,
      'description': instance.description,
      'discount_extra': instance.discountExtra,
      'discount_other': instance.discountOther,
      'discount_payment': instance.discountPayment,
      'discount_service': instance.discountService,
      'discount_ship': instance.discountShip,
      'exchange_price': instance.exchangePrice,
      'exchange_rate': instance.exchangeRate,
      'extra_price': instance.extraPrice,
      'fee_domestic': instance.feeDomestic,
      'fee_extra': instance.feeExtra,
      'fee_other': instance.feeOther,
      'fee_ship': instance.feeShip,
      'goods_values': instance.goodsValues,
      'id': instance.id,
      'image_root': instance.imageRoot,
      'is_bid': instance.isBid,
      'link': instance.link,
      'name': instance.name,
      'note': instance.note,
      'payment': instance.payment,
      'payment_currency': instance.paymentCurrency,
      'percent_rate': instance.percentRate,
      'price': instance.price,
      'quality': instance.quality,
      'quote_id': instance.quoteId,
      'route_code': instance.routeCode,
      'service_currency': instance.serviceCurrency,
      'services_extra': instance.servicesExtra,
      'ship_mode': instance.shipMode,
      'shipping_charges': instance.shippingCharges,
      'site': instance.site,
      'subpayment': instance.subPayment,
      'subtotal': instance.subtotal,
      'tax': instance.tax,
      'total': instance.total,
      'total_currency': instance.totalCurrency,
      'web_code': instance.webCode,
      'weight': instance.weight,
      'weight_rate': instance.weightRate,
    };
