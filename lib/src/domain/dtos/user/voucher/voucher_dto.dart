import 'package:json_annotation/json_annotation.dart';

part 'voucher_dto.g.dart';

@JsonSerializable()
class VoucherDto {
  const VoucherDto({this.data, }) : super();

  @JsonKey(name: 'data')
  final List<VouchersDto>? data;



  factory VoucherDto.fromJson(Map<String, dynamic> json) =>
      _$VoucherDtoFromJson(json);

  Map<String, dynamic> toJson() => _$VoucherDtoToJson(this);
}

@JsonSerializable()
class VouchersDto {
  const VouchersDto({this.iid, this.count, this.coupons, }) : super();

  @JsonKey(name: '_id')
  final String? iid;
  @JsonKey(name: 'count')
  final int? count;
  @JsonKey(name: 'coupons')
  final List<VoucherItemDto>? coupons;


  factory VouchersDto.fromJson(Map<String, dynamic> json) =>
      _$VouchersDtoFromJson(json);

  Map<String, dynamic> toJson() => _$VouchersDtoToJson(this);
}

@JsonSerializable()
class VoucherItemDto {
  const VoucherItemDto({ this.myUsed, this.totalUsed, this.iid, this.userId, this.auto, this.couponCode, this.name, this.description, this.type, this.discount, this.discountMax, this.discountUnit, this.discountFee, this.discountType, this.weight, this.qty, this.price, this.fee, this.used, this.mode, this.routeCode, this.siteCode, this.startDate, this.endDate, this.createdBy, this.status, this.deleted, this.createdDate, this.origin, this.usages,}) : super();

  @JsonKey(name: '_id')
  final String? iid;
  @JsonKey(name: 'user_id')
  final String? userId;
  @JsonKey(name: 'auto')
  final bool? auto;
  @JsonKey(name: 'coupon_code')
  final String? couponCode;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'type')
  final String? type;
  @JsonKey(name: 'discount')
  final int? discount;
  @JsonKey(name: 'discount_max')
  final int? discountMax;
  @JsonKey(name: 'discount_unit')
  final String? discountUnit;
  @JsonKey(name: 'discount_fee')
  final String? discountFee;
  @JsonKey(name: 'discount_type')
  final String? discountType;
  @JsonKey(name: 'weight')
  final WeightVouchersDto? weight;
  @JsonKey(name: 'qty')
  final QtyVouchersDto? qty;
  @JsonKey(name: 'price')
  final PriceVouchersDto? price;
  @JsonKey(name: 'fee')
  final FeeVouchersDto? fee;
  @JsonKey(name: 'used')
  final int? used;
  @JsonKey(name: 'mode')
  final String? mode;
  @JsonKey(name: 'route_code')
  final String? routeCode;
  @JsonKey(name: 'site_code')
  final String? siteCode;
  @JsonKey(name: 'start_date')
  final String? startDate;
  @JsonKey(name: 'end_date')
  final String? endDate;
  @JsonKey(name: 'created_by')
  final String? createdBy;
  @JsonKey(name: 'status')
  final bool? status;
  @JsonKey(name: 'deleted')
  final bool? deleted;
  @JsonKey(name: 'created_date')
  final String? createdDate;
  @JsonKey(name: 'origin')
  final OriginVouchersDto? origin;
  @JsonKey(name: 'usages')
  final UsagesVouchersDto? usages;
  @JsonKey(name: 'my_used')
  final MyUsedVouchersDto? myUsed;
  @JsonKey(name: 'total_used')
  final TotalUsedVouchersDto? totalUsed;



  factory VoucherItemDto.fromJson(Map<String, dynamic> json) =>
      _$VoucherItemDtoFromJson(json);

  Map<String, dynamic> toJson() => _$VoucherItemDtoToJson(this);
}

@JsonSerializable()
class WeightVouchersDto {
  const WeightVouchersDto({this.limit, this.value,  }) : super();

  @JsonKey(name: 'limit')
  final bool? limit;
  @JsonKey(name: 'value')
  final int? value;

  factory WeightVouchersDto.fromJson(Map<String, dynamic> json) =>
      _$WeightVouchersDtoFromJson(json);

  Map<String, dynamic> toJson() => _$WeightVouchersDtoToJson(this);
}

@JsonSerializable()
class QtyVouchersDto {
  const QtyVouchersDto({this.total, this.value,  }) : super();

  @JsonKey(name: 'total')
  final int? total;
  @JsonKey(name: 'value')
  final int? value;

  factory QtyVouchersDto.fromJson(Map<String, dynamic> json) =>
      _$QtyVouchersDtoFromJson(json);

  Map<String, dynamic> toJson() => _$QtyVouchersDtoToJson(this);
}

@JsonSerializable()
class PriceVouchersDto {
  const PriceVouchersDto({this.limit, this.value,  }) : super();

  @JsonKey(name: 'limit')
  final bool? limit;
  @JsonKey(name: 'value')
  final int? value;

  factory PriceVouchersDto.fromJson(Map<String, dynamic> json) =>
      _$PriceVouchersDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PriceVouchersDtoToJson(this);
}

@JsonSerializable()
class FeeVouchersDto {
  const FeeVouchersDto({this.limit, this.value,  }) : super();

  @JsonKey(name: 'limit')
  final bool? limit;
  @JsonKey(name: 'value')
  final int? value;

  factory FeeVouchersDto.fromJson(Map<String, dynamic> json) =>
      _$FeeVouchersDtoFromJson(json);

  Map<String, dynamic> toJson() => _$FeeVouchersDtoToJson(this);
}

@JsonSerializable()
class OriginVouchersDto {
  const OriginVouchersDto( {this.iid, this.code, this.qty, this.startDate, this.endDate, this.status, this.deleted,}) : super();

  @JsonKey(name: '_id')
  final String? iid;
  @JsonKey(name: 'code')
  final String? code;
  @JsonKey(name: 'qty')
  final QtyOriginVouchersDto? qty;
  @JsonKey(name: 'start_date')
  final String? startDate;
  @JsonKey(name: 'end_date')
  final String? endDate;
  @JsonKey(name: 'status')
  final bool? status;
  @JsonKey(name: 'deleted')
  final bool? deleted;

  factory OriginVouchersDto.fromJson(Map<String, dynamic> json) =>
      _$OriginVouchersDtoFromJson(json);

  Map<String, dynamic> toJson() => _$OriginVouchersDtoToJson(this);
}

@JsonSerializable()
class QtyOriginVouchersDto {
  const QtyOriginVouchersDto({this.total, this.value,  }) : super();

  @JsonKey(name: 'value')
  final int? value;
  @JsonKey(name: 'total')
  final int? total;


  factory QtyOriginVouchersDto.fromJson(Map<String, dynamic> json) =>
      _$QtyOriginVouchersDtoFromJson(json);

  Map<String, dynamic> toJson() => _$QtyOriginVouchersDtoToJson(this);
}

@JsonSerializable()
class UsagesVouchersDto {
  const UsagesVouchersDto({this.globalUsed,  }) : super();

  @JsonKey(name: 'global_used')
  final GlobalUsedUsagesVouchersDto? globalUsed;

  factory UsagesVouchersDto.fromJson(Map<String, dynamic> json) =>
      _$UsagesVouchersDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UsagesVouchersDtoToJson(this);
}

@JsonSerializable()
class GlobalUsedUsagesVouchersDto {
  const GlobalUsedUsagesVouchersDto({this.iid, this.total }) : super();

  @JsonKey(name: '_id')
  final String? iid;
  @JsonKey(name: 'total')
  final int? total;

  factory GlobalUsedUsagesVouchersDto.fromJson(Map<String, dynamic> json) =>
      _$GlobalUsedUsagesVouchersDtoFromJson(json);

  Map<String, dynamic> toJson() => _$GlobalUsedUsagesVouchersDtoToJson(this);
}

@JsonSerializable()
class MyUsedVouchersDto {
  const MyUsedVouchersDto({this.globalUsed,  }) : super();

  @JsonKey(name: 'quantity')
  final QuantityVouchersDto? globalUsed;

  factory MyUsedVouchersDto.fromJson(Map<String, dynamic> json) =>
      _$MyUsedVouchersDtoFromJson(json);

  Map<String, dynamic> toJson() => _$MyUsedVouchersDtoToJson(this);
}
@JsonSerializable()
class TotalUsedVouchersDto {
  const TotalUsedVouchersDto({this.globalUsed,  }) : super();

  @JsonKey(name: 'quantity')
  final QuantityVouchersDto? globalUsed;

  factory TotalUsedVouchersDto.fromJson(Map<String, dynamic> json) =>
      _$TotalUsedVouchersDtoFromJson(json);

  Map<String, dynamic> toJson() => _$TotalUsedVouchersDtoToJson(this);
}

@JsonSerializable()
class QuantityVouchersDto {
  const QuantityVouchersDto({this.iid, this.total }) : super();

  @JsonKey(name: '_id')
  final String? iid;
  @JsonKey(name: 'total')
  final int? total;

  factory QuantityVouchersDto.fromJson(Map<String, dynamic> json) =>
      _$QuantityVouchersDtoFromJson(json);

  Map<String, dynamic> toJson() => _$QuantityVouchersDtoToJson(this);
}