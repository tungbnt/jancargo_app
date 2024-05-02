// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'oder_management_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ManagementDto _$ManagementDtoFromJson(Map<String, dynamic> json) =>
    ManagementDto(
      data: json['data'] == null
          ? null
          : OderManagementDto.fromJson(json['data'] as Map<String, dynamic>),
      freeze: json['freeze'] as int?,
      options: json['options'] == null
          ? null
          : OptionDto.fromJson(json['options'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ManagementDtoToJson(ManagementDto instance) =>
    <String, dynamic>{
      'data': instance.data,
      'options': instance.options,
      'freeze': instance.freeze,
    };

OderManagementDto _$OderManagementDtoFromJson(Map<String, dynamic> json) =>
    OderManagementDto(
      results: (json['results'] as List<dynamic>?)
          ?.map(
              (e) => DataOderManagementDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OderManagementDtoToJson(OderManagementDto instance) =>
    <String, dynamic>{
      'results': instance.results,
    };

DataOderManagementDto _$DataOderManagementDtoFromJson(
        Map<String, dynamic> json) =>
    DataOderManagementDto(
      imageRoot: json['image_root'] as String?,
      iid: json['_id'] as String?,
      type: json['type'] as int?,
      code: json['code'] as String?,
      batchCode: json['batch_code'] as String?,
      link: json['link'] as String?,
      name: json['name'] as String?,
      exchangeRate: (json['exchange_rate'] as num?)?.toDouble(),
      weightRate: (json['weight_rate'] as num?)?.toDouble(),
      weight: (json['weight'] as num?)?.toDouble(),
      rWeight: (json['r_weight'] as num?)?.toDouble(),
      dWeight: (json['d_weight'] as num?)?.toDouble(),
      length: json['length'] as int?,
      width: (json['width'] as num?)?.toDouble(),
      height: (json['height'] as num?)?.toDouble(),
      quality: json['quality'] as int?,
      qtyOld: json['qty_old'] as int?,
      note: json['note'] as String?,
      currency: json['currency'] as String?,
      goodsValues: json['goods_values'] as int?,
      originPrice: json['origin_price'] as int?,
      tax: json['tax'] as int?,
      shippingCharges: json['shipping_charges'] as int?,
      serviceCurrency: json['service_currency'] as int?,
      paymentCurrency: json['payment_currency'] as int?,
      totalCurrency: json['total_currency'] as int?,
      price: json['price'] as int?,
      exchangePrice: json['exchange_price'] as int?,
      subtotal: json['subtotal'] as int?,
      feeDomestic: json['fee_domestic'] as int?,
      feeService: json['fee_service'] as int?,
      feePayment: json['fee_payment'] as int?,
      feeShip: json['fee_ship'] as int?,
      feeOther: json['fee_other'] as int?,
      feeExtra: json['fee_extra'] as int?,
      total: json['total'] as int?,
      discountPrice: json['discount_price'] as int?,
      discountService: json['discount_service'] as int?,
      discountShip: json['discount_ship'] as int?,
      discountOther: json['discount_other'] as int?,
      discountExtra: json['discount_extra'] as int?,
      discountPayment: json['discount_payment'] as int?,
      discount: json['discount'] as int?,
      payment: json['payment'] as int?,
      paymentPrice: json['payment_price'] as int?,
      paymentStatus: json['payment_status'] as String?,
      paymentPercent: json['payment_percent'] as int?,
      shipMode: json['ship_mode'] as String?,
      typeMode: json['type_mode'] as int?,
      servicesExtra: (json['services_extra'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      couponsCode: json['coupons_code'] as List<dynamic>?,
      phone: json['phone'] as String?,
      address: json['address'] as String?,
      province: json['province'] as String?,
      district: json['district'] as String?,
      ward: json['ward'] as String?,
      statusId: json['status_id'] as int?,
      statusLabel: json['status_label'] as String?,
      warehouseCode: json['warehouse_code'] as String?,
      warehouseName: json['warehouse_name'] as String?,
      routeCode: json['route_code'] as String?,
      siteCode: json['site_code'] as String?,
      saleId: json['sale_id'] as String?,
      userId: json['user_id'] as String?,
      addressId: json['address_id'] as String?,
      groups: json['groups'] as List<dynamic>?,
      trackNumber: json['track_number'] as int?,
      rewardLevel: json['reward_level'] == null
          ? null
          : RewardLevelDto.fromJson(
              json['reward_level'] as Map<String, dynamic>),
      createdDate: json['created_date'] as String?,
      statusDate: json['status_date'] as String?,
      auction: json['auction'] as bool?,
      totalCCurrency: json['totalCurrency'] as int?,
      sale: json['sale'] == null
          ? null
          : SaleDto.fromJson(json['sale'] as Map<String, dynamic>),
      id: json['id'] as String?,
    );

Map<String, dynamic> _$DataOderManagementDtoToJson(
        DataOderManagementDto instance) =>
    <String, dynamic>{
      '_id': instance.iid,
      'type': instance.type,
      'code': instance.code,
      'batch_code': instance.batchCode,
      'link': instance.link,
      'name': instance.name,
      'image_root': instance.imageRoot,
      'exchange_rate': instance.exchangeRate,
      'weight_rate': instance.weightRate,
      'weight': instance.weight,
      'r_weight': instance.rWeight,
      'd_weight': instance.dWeight,
      'length': instance.length,
      'width': instance.width,
      'height': instance.height,
      'quality': instance.quality,
      'qty_old': instance.qtyOld,
      'note': instance.note,
      'currency': instance.currency,
      'goods_values': instance.goodsValues,
      'origin_price': instance.originPrice,
      'tax': instance.tax,
      'shipping_charges': instance.shippingCharges,
      'service_currency': instance.serviceCurrency,
      'payment_currency': instance.paymentCurrency,
      'total_currency': instance.totalCurrency,
      'price': instance.price,
      'exchange_price': instance.exchangePrice,
      'subtotal': instance.subtotal,
      'fee_domestic': instance.feeDomestic,
      'fee_service': instance.feeService,
      'fee_payment': instance.feePayment,
      'fee_ship': instance.feeShip,
      'fee_other': instance.feeOther,
      'fee_extra': instance.feeExtra,
      'total': instance.total,
      'discount_price': instance.discountPrice,
      'discount_service': instance.discountService,
      'discount_ship': instance.discountShip,
      'discount_other': instance.discountOther,
      'discount_extra': instance.discountExtra,
      'discount_payment': instance.discountPayment,
      'discount': instance.discount,
      'payment': instance.payment,
      'payment_price': instance.paymentPrice,
      'payment_status': instance.paymentStatus,
      'payment_percent': instance.paymentPercent,
      'ship_mode': instance.shipMode,
      'type_mode': instance.typeMode,
      'services_extra': instance.servicesExtra,
      'coupons_code': instance.couponsCode,
      'phone': instance.phone,
      'address': instance.address,
      'province': instance.province,
      'district': instance.district,
      'ward': instance.ward,
      'status_id': instance.statusId,
      'status_label': instance.statusLabel,
      'warehouse_code': instance.warehouseCode,
      'warehouse_name': instance.warehouseName,
      'route_code': instance.routeCode,
      'site_code': instance.siteCode,
      'sale_id': instance.saleId,
      'user_id': instance.userId,
      'address_id': instance.addressId,
      'groups': instance.groups,
      'track_number': instance.trackNumber,
      'reward_level': instance.rewardLevel,
      'created_date': instance.createdDate,
      'status_date': instance.statusDate,
      'id': instance.id,
      'auction': instance.auction,
      'totalCurrency': instance.totalCCurrency,
      'sale': instance.sale,
    };

RewardLevelDto _$RewardLevelDtoFromJson(Map<String, dynamic> json) =>
    RewardLevelDto(
      routeCode: json['route_code'] as String?,
      internationalShippingDiscountUnit:
          json['international_shipping_discount_unit'] as String?,
      details: json['details'] as List<dynamic>?,
      id: json['_id'] as String?,
    );

Map<String, dynamic> _$RewardLevelDtoToJson(RewardLevelDto instance) =>
    <String, dynamic>{
      'route_code': instance.routeCode,
      'international_shipping_discount_unit':
          instance.internationalShippingDiscountUnit,
      'details': instance.details,
      '_id': instance.id,
    };

SaleDto _$SaleDtoFromJson(Map<String, dynamic> json) => SaleDto(
      phone: json['phone'] as String?,
      fullName: json['full_name'] as String?,
      shortName: json['short_name'] as String?,
      name: json['name'] as String?,
      id: json['_id'] as String?,
    );

Map<String, dynamic> _$SaleDtoToJson(SaleDto instance) => <String, dynamic>{
      '_id': instance.id,
      'phone': instance.phone,
      'full_name': instance.fullName,
      'short_name': instance.shortName,
      'name': instance.name,
    };

OptionDto _$OptionDtoFromJson(Map<String, dynamic> json) => OptionDto(
      total: json['total'] as int?,
      waitForPay: json['wait_for_pay'] as int?,
      waitForBuy: json['wait_for_buy'] as int?,
      buying: json['buying'] as int?,
      bought: json['bought'] as int?,
      foreignWarehouse: json['foreign_warehouse'] as int?,
      outFromForeignWarehouse: json['out_from_foreign_warehouse'] as int?,
      vnWarehouse: json['vn_warehouse'] as int?,
      processing: json['processing'] as int?,
      invoiceCreated: json['invoice_created'] as int?,
      deliveryInProgress: json['delivery_in_progress'] as int?,
      deliverySuccessful: json['delivery_successful'] as int?,
      canceled: json['canceled'] as int?,
      purchase: json['purchase'] as int?,
      transport: json['transport'] as int?,
      id: json['_id'] as String?,
    );

Map<String, dynamic> _$OptionDtoToJson(OptionDto instance) => <String, dynamic>{
      '_id': instance.id,
      'total': instance.total,
      'wait_for_pay': instance.waitForPay,
      'wait_for_buy': instance.waitForBuy,
      'buying': instance.buying,
      'bought': instance.bought,
      'foreign_warehouse': instance.foreignWarehouse,
      'out_from_foreign_warehouse': instance.outFromForeignWarehouse,
      'vn_warehouse': instance.vnWarehouse,
      'processing': instance.processing,
      'invoice_created': instance.invoiceCreated,
      'delivery_in_progress': instance.deliveryInProgress,
      'delivery_successful': instance.deliverySuccessful,
      'canceled': instance.canceled,
      'purchase': instance.purchase,
      'transport': instance.transport,
    };
