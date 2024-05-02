import 'package:json_annotation/json_annotation.dart';

part 'calculate_cart_dto.g.dart';

@JsonSerializable()
class CalculateCartDto {
  const CalculateCartDto({this.data,this.payment,this.reward}) : super();

  @JsonKey(name: 'data')
  final List<PriceItemDto>? data;
  @JsonKey(name: 'payment')
  final PaymentDto? payment;
  @JsonKey(name: 'reward')
  final RewardDto? reward;

  factory CalculateCartDto.fromJson(Map<String, dynamic> json) =>
      _$CalculateCartDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CalculateCartDtoToJson(this);
}

@JsonSerializable()
class PriceItemDto {
  const PriceItemDto({
    this.taxForeignCurrency,
    this.taxVNCurrency,
    this.feeDetails,
  }) : super();

  @JsonKey(name: 'goods_value_with_tax_in_foreign_currency')
  final int? taxForeignCurrency;
  @JsonKey(name: 'goods_value_with_tax_in_vietnam_currency')
  final int? taxVNCurrency;
  @JsonKey(name: 'fee_details')
  final List<FeeDetailsDto>? feeDetails;


  factory PriceItemDto.fromJson(Map<String, dynamic> json) =>
      _$PriceItemDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PriceItemDtoToJson(this);
}

@JsonSerializable()
class FeeDetailsDto {
  const FeeDetailsDto({
    this.id,
    this.name,
    this.foreignCurrency,
    this.vietnamCurrency,
    this.code,
    this.origin,
    this.discount,
    this.groups,
    this.extras,
    this.priceListDetails,
    this.rewardInfo,
  }) : super();

  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'foreign_currency')
  final int? foreignCurrency;
  @JsonKey(name: 'vietnam_currency')
  final int? vietnamCurrency;
  @JsonKey(name: 'code')
  final String? code;
  @JsonKey(name: 'origin')
  final OriginDto? origin;
  @JsonKey(name: 'discount')
  final DiscountDto? discount;
  @JsonKey(name: 'groups')
  final List<dynamic>? groups;
  @JsonKey(name: 'extras')
  final List<dynamic>? extras;
  @JsonKey(name: 'priceListDetails')
  final List<PriceLisstDetailDto>? priceListDetails;
  @JsonKey(name: 'rewardInfo')
  final String? rewardInfo;

  factory FeeDetailsDto.fromJson(Map<String, dynamic> json) =>
      _$FeeDetailsDtoFromJson(json);

  Map<String, dynamic> toJson() => _$FeeDetailsDtoToJson(this);
}

@JsonSerializable()
class OriginDto {
  const OriginDto({
    this.level,
    this.unit,
  }) : super();

  @JsonKey(name: 'level')
  final int? level;
  @JsonKey(name: 'unit')
  final String? unit;

  factory OriginDto.fromJson(Map<String, dynamic> json) =>
      _$OriginDtoFromJson(json);

  Map<String, dynamic> toJson() => _$OriginDtoToJson(this);
}

@JsonSerializable()
class DiscountDto {
  const DiscountDto({
    this.discountDetails,
    this.errors,
  }) : super();

  @JsonKey(name: 'discount_details')
  final List<dynamic>? discountDetails;
  @JsonKey(name: 'errors')
  final List<dynamic>? errors;

  factory DiscountDto.fromJson(Map<String, dynamic> json) =>
      _$DiscountDtoFromJson(json);

  Map<String, dynamic> toJson() => _$DiscountDtoToJson(this);
}

@JsonSerializable()
class PriceLisstDetailDto {
  const PriceLisstDetailDto( {
    this.typeId, this.details, this.id, this.code, this.typeName, this.completedAtStatus, this.orderNo,
  }) : super();

  @JsonKey(name: 'type_id')
  final String? typeId;
  @JsonKey(name: 'details')
  final List<DetailPriceLisstDetailDto>? details;
  @JsonKey(name: '_id')
  final String? id;
  @JsonKey(name: 'code')
  final String? code;
  @JsonKey(name: 'type_name')
  final String? typeName;
  @JsonKey(name: 'completed_at_status')
  final int? completedAtStatus;
  @JsonKey(name: 'order_no')
  final int? orderNo;

  factory PriceLisstDetailDto.fromJson(Map<String, dynamic> json) =>
      _$PriceLisstDetailDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PriceLisstDetailDtoToJson(this);
}

@JsonSerializable()
class DetailPriceLisstDetailDto {
  const DetailPriceLisstDetailDto({
    this.min,
    this.max,
    this.unit,
    this.value,
    this.munitToCalcPriceax,
    this.id,
  }) : super();

  @JsonKey(name: 'min')
  final int? min;
  @JsonKey(name: 'max')
  final int? max;
  @JsonKey(name: 'unit')
  final String? unit;
  @JsonKey(name: 'value')
  final int? value;
  @JsonKey(name: 'unit_to_calc_price')
  final String? munitToCalcPriceax;
  @JsonKey(name: '_id')
  final String? id;

  factory DetailPriceLisstDetailDto.fromJson(Map<String, dynamic> json) =>
      _$DetailPriceLisstDetailDtoFromJson(json);

  Map<String, dynamic> toJson() => _$DetailPriceLisstDetailDtoToJson(this);
}

@JsonSerializable()
class PaymentDto {
  const PaymentDto({
    this.totalFirst,
    this.firstPayment,
    this.secondPayment,
  }) : super();

  @JsonKey(name: 'total_first')
  final int? totalFirst;
  @JsonKey(name: 'first_payment')
  final int? firstPayment;
  @JsonKey(name: 'second_payment')
  final int? secondPayment;

  factory PaymentDto.fromJson(Map<String, dynamic> json) =>
      _$PaymentDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentDtoToJson(this);
}

@JsonSerializable()
class RewardDto {
  const RewardDto({
    this.routeCode,
    this.internationalShippingDiscountUnit,
    this.id,
    this.details,
  }) : super();

  @JsonKey(name: 'route_code')
  final String? routeCode;
  @JsonKey(name: 'international_shipping_discount_unit')
  final String? internationalShippingDiscountUnit;
  @JsonKey(name: '_id')
  final String? id;
  @JsonKey(name: 'details')
  final List<dynamic>? details;

  factory RewardDto.fromJson(Map<String, dynamic> json) =>
      _$RewardDtoFromJson(json);

  Map<String, dynamic> toJson() => _$RewardDtoToJson(this);
}

class CalculateModel {
   double feeService;

   double feePayment;

   double serviceCurrent;
   double paymentCurrent;
   double discountService;
   double totalCurrent;
   double subCurrent;



  CalculateModel({
    required this.feeService,
    required this.feePayment,
    required this.serviceCurrent,
    required this.paymentCurrent,
    required this.discountService,
    required this.totalCurrent,
    required this.subCurrent,

  });

  Map<String, dynamic> toJson() {

    return {

      'size': totalCurrent,
    };
  }
}
