import 'package:json_annotation/json_annotation.dart';

part 'oder_management_dto.g.dart';
@JsonSerializable()
class ManagementDto {
  const ManagementDto({this.data, this.freeze,this.options}) : super();

  @JsonKey(name: 'data')
  final OderManagementDto? data;
  @JsonKey(name: 'options')
  final OptionDto? options;
  @JsonKey(name: 'freeze')
  final int? freeze;


  factory ManagementDto.fromJson(Map<String, dynamic> json) =>
      _$ManagementDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ManagementDtoToJson(this);
}

@JsonSerializable()
class OderManagementDto {
  const OderManagementDto({this.results,}) : super();

  @JsonKey(name: 'results')
  final List<DataOderManagementDto>? results;



  factory OderManagementDto.fromJson(Map<String, dynamic> json) =>
      _$OderManagementDtoFromJson(json);

  Map<String, dynamic> toJson() => _$OderManagementDtoToJson(this);
}

@JsonSerializable()
class DataOderManagementDto {
  const DataOderManagementDto({this.imageRoot, this.iid, this.type, this.code, this.batchCode, this.link, this.name, this.exchangeRate, this.weightRate, this.weight, this.rWeight, this.dWeight, this.length, this.width, this.height, this.quality, this.qtyOld, this.note, this.currency, this.goodsValues, this.originPrice, this.tax, this.shippingCharges, this.serviceCurrency, this.paymentCurrency, this.totalCurrency, this.price, this.exchangePrice, this.subtotal, this.feeDomestic, this.feeService, this.feePayment, this.feeShip, this.feeOther, this.feeExtra, this.total, this.discountPrice, this.discountService, this.discountShip, this.discountOther, this.discountExtra, this.discountPayment, this.discount, this.payment, this.paymentPrice, this.paymentStatus, this.paymentPercent, this.shipMode, this.typeMode, this.servicesExtra, this.couponsCode, this.phone, this.address, this.province, this.district, this.ward, this.statusId, this.statusLabel, this.warehouseCode, this.warehouseName, this.routeCode, this.siteCode, this.saleId, this.userId, this.addressId, this.groups, this.trackNumber, this.rewardLevel, this.createdDate, this.statusDate, this.auction, this.totalCCurrency, this.sale, this.id,}) : super();

  @JsonKey(name: '_id')
  final String? iid;
  @JsonKey(name: 'type')
  final int? type;
  @JsonKey(name: 'code')
  final String? code;
  @JsonKey(name: 'batch_code')
  final String? batchCode;
  @JsonKey(name: 'link')
  final String? link;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'image_root')
  final String? imageRoot;
  @JsonKey(name: 'exchange_rate')
  final double? exchangeRate;
  @JsonKey(name: 'weight_rate')
  final double? weightRate;
  @JsonKey(name: 'weight')
  final double? weight;
  @JsonKey(name: 'r_weight')
  final double? rWeight;
  @JsonKey(name: 'd_weight')
  final double? dWeight;
  @JsonKey(name: 'length')
  final int? length;
  @JsonKey(name: 'width')
  final double? width;
  @JsonKey(name: 'height')
  final double? height;
  @JsonKey(name: 'quality')
  final int? quality;
  @JsonKey(name: 'qty_old')
  final int? qtyOld;
  @JsonKey(name: 'note')
  final String? note;
  @JsonKey(name: 'currency')
  final String? currency;
  @JsonKey(name: 'goods_values')
  final int? goodsValues;
  @JsonKey(name: 'origin_price')
  final int? originPrice;
  @JsonKey(name: 'tax')
  final int? tax;
  @JsonKey(name: 'shipping_charges')
  final int? shippingCharges;
  @JsonKey(name: 'service_currency')
  final int? serviceCurrency;
  @JsonKey(name: 'payment_currency')
  final int? paymentCurrency;
  @JsonKey(name: 'total_currency')
  final int? totalCurrency;
  @JsonKey(name: 'price')
  final int? price;
  @JsonKey(name: 'exchange_price')
  final int? exchangePrice;
  @JsonKey(name: 'subtotal')
  final int? subtotal;
  @JsonKey(name: 'fee_domestic')
  final int? feeDomestic;
  @JsonKey(name: 'fee_service')
  final int? feeService;
  @JsonKey(name: 'fee_payment')
  final int? feePayment;
  @JsonKey(name: 'fee_ship')
  final int? feeShip;
  @JsonKey(name: 'fee_other')
  final int? feeOther;
  @JsonKey(name: 'fee_extra')
  final int? feeExtra;
  @JsonKey(name: 'total')
  final int? total;
  @JsonKey(name: 'discount_price')
  final int? discountPrice;
  @JsonKey(name: 'discount_service')
  final int? discountService;
  @JsonKey(name: 'discount_ship')
  final int? discountShip;
  @JsonKey(name: 'discount_other')
  final int? discountOther;
  @JsonKey(name: 'discount_extra')
  final int? discountExtra;
  @JsonKey(name: 'discount_payment')
  final int? discountPayment;
  @JsonKey(name: 'discount')
  final int? discount;
  @JsonKey(name: 'payment')
  final int? payment;
  @JsonKey(name: 'payment_price')
  final int? paymentPrice;
  @JsonKey(name: 'payment_status')
  final String? paymentStatus;
  @JsonKey(name: 'payment_percent')
  final int? paymentPercent;
  @JsonKey(name: 'ship_mode')
  final String? shipMode;
  @JsonKey(name: 'type_mode')
  final int? typeMode;
  @JsonKey(name: 'services_extra')
  final List<String>? servicesExtra;
  @JsonKey(name: 'coupons_code')
  final List<dynamic>? couponsCode;
  @JsonKey(name: 'phone')
  final String? phone;
  @JsonKey(name: 'address')
  final String? address;
  @JsonKey(name: 'province')
  final String? province;
  @JsonKey(name: 'district')
  final String? district;
  @JsonKey(name: 'ward')
  final String? ward;
  @JsonKey(name: 'status_id')
  final int? statusId;
  @JsonKey(name: 'status_label')
  final String? statusLabel;
  @JsonKey(name: 'warehouse_code')
  final String? warehouseCode;
  @JsonKey(name: 'warehouse_name')
  final String? warehouseName;
  @JsonKey(name: 'route_code')
  final String? routeCode;
  @JsonKey(name: 'site_code')
  final String? siteCode;
  @JsonKey(name: 'sale_id')
  final String? saleId;
  @JsonKey(name: 'user_id')
  final String? userId;
  @JsonKey(name: 'address_id')
  final String? addressId;
  @JsonKey(name: 'groups')
  final List<dynamic>? groups;
  @JsonKey(name: 'track_number')
  final int? trackNumber;
  @JsonKey(name: 'reward_level')
  final RewardLevelDto? rewardLevel;
  @JsonKey(name: 'created_date')
  final String? createdDate;
  @JsonKey(name: 'status_date')
  final String? statusDate;
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'auction')
  final bool? auction;
  @JsonKey(name: 'totalCurrency')
  final int? totalCCurrency;
  @JsonKey(name: 'sale')
  final SaleDto? sale;





  factory DataOderManagementDto.fromJson(Map<String, dynamic> json) =>
      _$DataOderManagementDtoFromJson(json);

  Map<String, dynamic> toJson() => _$DataOderManagementDtoToJson(this);
}

@JsonSerializable()
class RewardLevelDto {
  const RewardLevelDto({this.routeCode, this.internationalShippingDiscountUnit, this.details, this.id, }) : super();

  @JsonKey(name: 'route_code')
  final String? routeCode;
  @JsonKey(name: 'international_shipping_discount_unit')
  final String? internationalShippingDiscountUnit;
  @JsonKey(name: 'details')
  final List<dynamic>? details;
  @JsonKey(name: '_id')
  final String? id;


  factory RewardLevelDto.fromJson(Map<String, dynamic> json) =>
      _$RewardLevelDtoFromJson(json);

  Map<String, dynamic> toJson() => _$RewardLevelDtoToJson(this);
}

@JsonSerializable()
class SaleDto {
  const SaleDto({this.phone, this.fullName, this.shortName, this.name, this.id, }) : super();

  @JsonKey(name: '_id')
  final String? id;
  @JsonKey(name: 'phone')
  final String? phone;
  @JsonKey(name: 'full_name')
  final String? fullName;
  @JsonKey(name: 'short_name')
  final String? shortName;
  @JsonKey(name: 'name')
  final String? name;


  factory SaleDto.fromJson(Map<String, dynamic> json) =>
      _$SaleDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SaleDtoToJson(this);
}

@JsonSerializable()
class OptionDto {
  const OptionDto({this.total, this.waitForPay, this.waitForBuy, this.buying, this.bought, this.foreignWarehouse, this.outFromForeignWarehouse, this.vnWarehouse, this.processing, this.invoiceCreated, this.deliveryInProgress, this.deliverySuccessful, this.canceled, this.purchase, this.transport, this.id, }) : super();

  @JsonKey(name: '_id')
  final String? id;
  @JsonKey(name: 'total')
  final int? total;
  @JsonKey(name: 'wait_for_pay')
  final int? waitForPay;
  @JsonKey(name: 'wait_for_buy')
  final int? waitForBuy;
  @JsonKey(name: 'buying')
  final int? buying;
  @JsonKey(name: 'bought')
  final int? bought;
  @JsonKey(name: 'foreign_warehouse')
  final int? foreignWarehouse;
  @JsonKey(name: 'out_from_foreign_warehouse')
  final int? outFromForeignWarehouse;
  @JsonKey(name: 'vn_warehouse')
  final int? vnWarehouse;
  @JsonKey(name: 'processing')
  final int? processing;
  @JsonKey(name: 'invoice_created')
  final int? invoiceCreated;
  @JsonKey(name: 'delivery_in_progress')
  final int? deliveryInProgress;
  @JsonKey(name: 'delivery_successful')
  final int? deliverySuccessful;
  @JsonKey(name: 'canceled')
  final int? canceled;
  @JsonKey(name: 'purchase')
  final int? purchase;
  @JsonKey(name: 'transport')
  final int? transport;




  factory OptionDto.fromJson(Map<String, dynamic> json) =>
      _$OptionDtoFromJson(json);

  Map<String, dynamic> toJson() => _$OptionDtoToJson(this);
}