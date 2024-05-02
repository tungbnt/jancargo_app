// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DetailDto _$DetailDtoFromJson(Map<String, dynamic> json) => DetailDto(
      sellerDto: json['seller'] == null
          ? null
          : SellerDto.fromJson(json['seller'] as Map<String, dynamic>),
      code: json['code'] as String?,
      url: json['url'] as String?,
      name: json['name'] as String?,
      price: json['price'] as int?,
      tax: json['tax'] as int?,
      priceBuy: json['price_buy'] as int?,
      taxBuy: json['tax_buy'] as int?,
      feeShip: json['feeship'] as int?,
      fromOutsideOfapan: json['from_outside_of_japan'] as bool?,
      thumbnails: (json['thumbnails'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      description: json['description'] as String?,
      qty: json['qty'] as int?,
      categoryId: json['category_id'] as String?,
      startDate: json['start_date'] as String?,
      endDate: json['end_date'] as String?,
      earlyClose: json['early_close'] as bool?,
      autoExtension: json['auto_extension'] as bool?,
      returnable: json['returnable'] as bool?,
      biderRestriction: json['bider_restriction'] as bool?,
      bidderVerification: json['bidder_verification'] as bool?,
      initPrice: json['init_price'] as int?,
      condition: json['condition'] as String?,
      bids: json['bids'] as int?,
      postage: json['postage'] as bool?,
      finished: json['finished'] as bool?,
      methods: json['methods'] == null
          ? null
          : MethodsDto.fromJson(json['methods'] as Map<String, dynamic>),
      highestBidder: json['highest_bidder'] == null
          ? null
          : HighestBidderDto.fromJson(
              json['highest_bidder'] as Map<String, dynamic>),
      wonInfo: json['won_info'],
      timeLeft: json['time_left'] as int?,
      endTime: json['end_time'] as String?,
    );

Map<String, dynamic> _$DetailDtoToJson(DetailDto instance) => <String, dynamic>{
      'code': instance.code,
      'url': instance.url,
      'name': instance.name,
      'price': instance.price,
      'tax': instance.tax,
      'price_buy': instance.priceBuy,
      'tax_buy': instance.taxBuy,
      'feeship': instance.feeShip,
      'from_outside_of_japan': instance.fromOutsideOfapan,
      'thumbnails': instance.thumbnails,
      'description': instance.description,
      'qty': instance.qty,
      'category_id': instance.categoryId,
      'start_date': instance.startDate,
      'end_date': instance.endDate,
      'early_close': instance.earlyClose,
      'auto_extension': instance.autoExtension,
      'returnable': instance.returnable,
      'bider_restriction': instance.biderRestriction,
      'bidder_verification': instance.bidderVerification,
      'init_price': instance.initPrice,
      'condition': instance.condition,
      'bids': instance.bids,
      'postage': instance.postage,
      'finished': instance.finished,
      'methods': instance.methods,
      'highest_bidder': instance.highestBidder,
      'won_info': instance.wonInfo,
      'time_left': instance.timeLeft,
      'end_time': instance.endTime,
      'seller': instance.sellerDto,
    };

SellerDto _$SellerDtoFromJson(Map<String, dynamic> json) => SellerDto(
      url: json['url'] as String?,
      id: json['id'] as String?,
      name: json['name'] as String?,
      total: json['total'] as int?,
      percent: json['percent'] as String?,
      avatar: json['avatar'] as String?,
      details: json['details'] == null
          ? null
          : DetailSellerDto.fromJson(json['details'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SellerDtoToJson(SellerDto instance) => <String, dynamic>{
      'url': instance.url,
      'id': instance.id,
      'name': instance.name,
      'total': instance.total,
      'percent': instance.percent,
      'avatar': instance.avatar,
      'details': instance.details,
    };

DetailSellerDto _$DetailSellerDtoFromJson(Map<String, dynamic> json) =>
    DetailSellerDto(
      normal: json['normal'] == null
          ? null
          : NormalDto.fromJson(json['normal'] as Map<String, dynamic>),
      bad: json['bad'] == null
          ? null
          : BadDto.fromJson(json['bad'] as Map<String, dynamic>),
      url: json['url'] as String?,
      id: json['id'] as String?,
      name: json['name'] as String?,
      total: json['total'] == null
          ? null
          : TotalDto.fromJson(json['total'] as Map<String, dynamic>),
      good: json['good'] == null
          ? null
          : GoodDto.fromJson(json['good'] as Map<String, dynamic>),
      percent: json['percent'] == null
          ? null
          : PercentDto.fromJson(json['percent'] as Map<String, dynamic>),
      verified: json['verified'] as bool?,
      avatar: json['avatar'] as String?,
      updatedTime: json['updated_time'] as String?,
    );

Map<String, dynamic> _$DetailSellerDtoToJson(DetailSellerDto instance) =>
    <String, dynamic>{
      'url': instance.url,
      'id': instance.id,
      'name': instance.name,
      'total': instance.total,
      'good': instance.good,
      'normal': instance.normal,
      'bad': instance.bad,
      'percent': instance.percent,
      'verified': instance.verified,
      'avatar': instance.avatar,
      'updated_time': instance.updatedTime,
    };

TotalDto _$TotalDtoFromJson(Map<String, dynamic> json) => TotalDto(
      count: json['count'] as int?,
      id: (json['percent'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$TotalDtoToJson(TotalDto instance) => <String, dynamic>{
      'count': instance.count,
      'percent': instance.id,
    };

GoodDto _$GoodDtoFromJson(Map<String, dynamic> json) => GoodDto(
      count: (json['count'] as num?)?.toDouble(),
      total: (json['total'] as num?)?.toDouble(),
      month: (json['month'] as num?)?.toDouble(),
      year: (json['year'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$GoodDtoToJson(GoodDto instance) => <String, dynamic>{
      'count': instance.count,
      'total': instance.total,
      'month': instance.month,
      'year': instance.year,
    };

NormalDto _$NormalDtoFromJson(Map<String, dynamic> json) => NormalDto(
      count: (json['count'] as num?)?.toDouble(),
      total: (json['total'] as num?)?.toDouble(),
      month: (json['month'] as num?)?.toDouble(),
      year: (json['year'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$NormalDtoToJson(NormalDto instance) => <String, dynamic>{
      'count': instance.count,
      'total': instance.total,
      'month': instance.month,
      'year': instance.year,
    };

BadDto _$BadDtoFromJson(Map<String, dynamic> json) => BadDto(
      count: (json['count'] as num?)?.toDouble(),
      total: (json['total'] as num?)?.toDouble(),
      month: (json['month'] as num?)?.toDouble(),
      year: (json['year'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$BadDtoToJson(BadDto instance) => <String, dynamic>{
      'count': instance.count,
      'total': instance.total,
      'month': instance.month,
      'year': instance.year,
    };

PercentDto _$PercentDtoFromJson(Map<String, dynamic> json) => PercentDto(
      count: (json['count'] as num?)?.toDouble(),
      month: (json['month'] as num?)?.toDouble(),
      year: (json['year'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$PercentDtoToJson(PercentDto instance) =>
    <String, dynamic>{
      'count': instance.count,
      'month': instance.month,
      'year': instance.year,
    };

MethodsDto _$MethodsDtoFromJson(Map<String, dynamic> json) => MethodsDto(
      bid: json['bid'] as bool?,
      buy: json['buy'] as bool?,
      someProcedures: json['some_procedures_need_to_be_done'] as bool?,
    );

Map<String, dynamic> _$MethodsDtoToJson(MethodsDto instance) =>
    <String, dynamic>{
      'bid': instance.bid,
      'buy': instance.buy,
      'some_procedures_need_to_be_done': instance.someProcedures,
    };

HighestBidderDto _$HighestBidderDtoFromJson(Map<String, dynamic> json) =>
    HighestBidderDto(
      message: json['message'] as String?,
      isHighest: json['is_highest'] as bool?,
    );

Map<String, dynamic> _$HighestBidderDtoToJson(HighestBidderDto instance) =>
    <String, dynamic>{
      'message': instance.message,
      'is_highest': instance.isHighest,
    };
