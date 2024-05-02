// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voucher_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VoucherDto _$VoucherDtoFromJson(Map<String, dynamic> json) => VoucherDto(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => VouchersDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$VoucherDtoToJson(VoucherDto instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

VouchersDto _$VouchersDtoFromJson(Map<String, dynamic> json) => VouchersDto(
      iid: json['_id'] as String?,
      count: json['count'] as int?,
      coupons: (json['coupons'] as List<dynamic>?)
          ?.map((e) => VoucherItemDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$VouchersDtoToJson(VouchersDto instance) =>
    <String, dynamic>{
      '_id': instance.iid,
      'count': instance.count,
      'coupons': instance.coupons,
    };

VoucherItemDto _$VoucherItemDtoFromJson(Map<String, dynamic> json) =>
    VoucherItemDto(
      myUsed: json['my_used'] == null
          ? null
          : MyUsedVouchersDto.fromJson(json['my_used'] as Map<String, dynamic>),
      totalUsed: json['total_used'] == null
          ? null
          : TotalUsedVouchersDto.fromJson(
              json['total_used'] as Map<String, dynamic>),
      iid: json['_id'] as String?,
      userId: json['user_id'] as String?,
      auto: json['auto'] as bool?,
      couponCode: json['coupon_code'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      type: json['type'] as String?,
      discount: json['discount'] as int?,
      discountMax: json['discount_max'] as int?,
      discountUnit: json['discount_unit'] as String?,
      discountFee: json['discount_fee'] as String?,
      discountType: json['discount_type'] as String?,
      weight: json['weight'] == null
          ? null
          : WeightVouchersDto.fromJson(json['weight'] as Map<String, dynamic>),
      qty: json['qty'] == null
          ? null
          : QtyVouchersDto.fromJson(json['qty'] as Map<String, dynamic>),
      price: json['price'] == null
          ? null
          : PriceVouchersDto.fromJson(json['price'] as Map<String, dynamic>),
      fee: json['fee'] == null
          ? null
          : FeeVouchersDto.fromJson(json['fee'] as Map<String, dynamic>),
      used: json['used'] as int?,
      mode: json['mode'] as String?,
      routeCode: json['route_code'] as String?,
      siteCode: json['site_code'] as String?,
      startDate: json['start_date'] as String?,
      endDate: json['end_date'] as String?,
      createdBy: json['created_by'] as String?,
      status: json['status'] as bool?,
      deleted: json['deleted'] as bool?,
      createdDate: json['created_date'] as String?,
      origin: json['origin'] == null
          ? null
          : OriginVouchersDto.fromJson(json['origin'] as Map<String, dynamic>),
      usages: json['usages'] == null
          ? null
          : UsagesVouchersDto.fromJson(json['usages'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$VoucherItemDtoToJson(VoucherItemDto instance) =>
    <String, dynamic>{
      '_id': instance.iid,
      'user_id': instance.userId,
      'auto': instance.auto,
      'coupon_code': instance.couponCode,
      'name': instance.name,
      'description': instance.description,
      'type': instance.type,
      'discount': instance.discount,
      'discount_max': instance.discountMax,
      'discount_unit': instance.discountUnit,
      'discount_fee': instance.discountFee,
      'discount_type': instance.discountType,
      'weight': instance.weight,
      'qty': instance.qty,
      'price': instance.price,
      'fee': instance.fee,
      'used': instance.used,
      'mode': instance.mode,
      'route_code': instance.routeCode,
      'site_code': instance.siteCode,
      'start_date': instance.startDate,
      'end_date': instance.endDate,
      'created_by': instance.createdBy,
      'status': instance.status,
      'deleted': instance.deleted,
      'created_date': instance.createdDate,
      'origin': instance.origin,
      'usages': instance.usages,
      'my_used': instance.myUsed,
      'total_used': instance.totalUsed,
    };

WeightVouchersDto _$WeightVouchersDtoFromJson(Map<String, dynamic> json) =>
    WeightVouchersDto(
      limit: json['limit'] as bool?,
      value: json['value'] as int?,
    );

Map<String, dynamic> _$WeightVouchersDtoToJson(WeightVouchersDto instance) =>
    <String, dynamic>{
      'limit': instance.limit,
      'value': instance.value,
    };

QtyVouchersDto _$QtyVouchersDtoFromJson(Map<String, dynamic> json) =>
    QtyVouchersDto(
      total: json['total'] as int?,
      value: json['value'] as int?,
    );

Map<String, dynamic> _$QtyVouchersDtoToJson(QtyVouchersDto instance) =>
    <String, dynamic>{
      'total': instance.total,
      'value': instance.value,
    };

PriceVouchersDto _$PriceVouchersDtoFromJson(Map<String, dynamic> json) =>
    PriceVouchersDto(
      limit: json['limit'] as bool?,
      value: json['value'] as int?,
    );

Map<String, dynamic> _$PriceVouchersDtoToJson(PriceVouchersDto instance) =>
    <String, dynamic>{
      'limit': instance.limit,
      'value': instance.value,
    };

FeeVouchersDto _$FeeVouchersDtoFromJson(Map<String, dynamic> json) =>
    FeeVouchersDto(
      limit: json['limit'] as bool?,
      value: json['value'] as int?,
    );

Map<String, dynamic> _$FeeVouchersDtoToJson(FeeVouchersDto instance) =>
    <String, dynamic>{
      'limit': instance.limit,
      'value': instance.value,
    };

OriginVouchersDto _$OriginVouchersDtoFromJson(Map<String, dynamic> json) =>
    OriginVouchersDto(
      iid: json['_id'] as String?,
      code: json['code'] as String?,
      qty: json['qty'] == null
          ? null
          : QtyOriginVouchersDto.fromJson(json['qty'] as Map<String, dynamic>),
      startDate: json['start_date'] as String?,
      endDate: json['end_date'] as String?,
      status: json['status'] as bool?,
      deleted: json['deleted'] as bool?,
    );

Map<String, dynamic> _$OriginVouchersDtoToJson(OriginVouchersDto instance) =>
    <String, dynamic>{
      '_id': instance.iid,
      'code': instance.code,
      'qty': instance.qty,
      'start_date': instance.startDate,
      'end_date': instance.endDate,
      'status': instance.status,
      'deleted': instance.deleted,
    };

QtyOriginVouchersDto _$QtyOriginVouchersDtoFromJson(
        Map<String, dynamic> json) =>
    QtyOriginVouchersDto(
      total: json['total'] as int?,
      value: json['value'] as int?,
    );

Map<String, dynamic> _$QtyOriginVouchersDtoToJson(
        QtyOriginVouchersDto instance) =>
    <String, dynamic>{
      'value': instance.value,
      'total': instance.total,
    };

UsagesVouchersDto _$UsagesVouchersDtoFromJson(Map<String, dynamic> json) =>
    UsagesVouchersDto(
      globalUsed: json['global_used'] == null
          ? null
          : GlobalUsedUsagesVouchersDto.fromJson(
              json['global_used'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UsagesVouchersDtoToJson(UsagesVouchersDto instance) =>
    <String, dynamic>{
      'global_used': instance.globalUsed,
    };

GlobalUsedUsagesVouchersDto _$GlobalUsedUsagesVouchersDtoFromJson(
        Map<String, dynamic> json) =>
    GlobalUsedUsagesVouchersDto(
      iid: json['_id'] as String?,
      total: json['total'] as int?,
    );

Map<String, dynamic> _$GlobalUsedUsagesVouchersDtoToJson(
        GlobalUsedUsagesVouchersDto instance) =>
    <String, dynamic>{
      '_id': instance.iid,
      'total': instance.total,
    };

MyUsedVouchersDto _$MyUsedVouchersDtoFromJson(Map<String, dynamic> json) =>
    MyUsedVouchersDto(
      globalUsed: json['quantity'] == null
          ? null
          : QuantityVouchersDto.fromJson(
              json['quantity'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MyUsedVouchersDtoToJson(MyUsedVouchersDto instance) =>
    <String, dynamic>{
      'quantity': instance.globalUsed,
    };

TotalUsedVouchersDto _$TotalUsedVouchersDtoFromJson(
        Map<String, dynamic> json) =>
    TotalUsedVouchersDto(
      globalUsed: json['quantity'] == null
          ? null
          : QuantityVouchersDto.fromJson(
              json['quantity'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TotalUsedVouchersDtoToJson(
        TotalUsedVouchersDto instance) =>
    <String, dynamic>{
      'quantity': instance.globalUsed,
    };

QuantityVouchersDto _$QuantityVouchersDtoFromJson(Map<String, dynamic> json) =>
    QuantityVouchersDto(
      iid: json['_id'] as String?,
      total: json['total'] as int?,
    );

Map<String, dynamic> _$QuantityVouchersDtoToJson(
        QuantityVouchersDto instance) =>
    <String, dynamic>{
      '_id': instance.iid,
      'total': instance.total,
    };
