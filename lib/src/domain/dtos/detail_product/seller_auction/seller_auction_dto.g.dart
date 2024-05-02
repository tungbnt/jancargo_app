// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seller_auction_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SellerDetailAuctionDto _$SellerDetailAuctionDtoFromJson(
        Map<String, dynamic> json) =>
    SellerDetailAuctionDto(
      code: json['code'] as int?,
      data: json['data'] == null
          ? null
          : SellerAuctionDto.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SellerDetailAuctionDtoToJson(
        SellerDetailAuctionDto instance) =>
    <String, dynamic>{
      'code': instance.code,
      'data': instance.data,
    };

SellerAuctionDto _$SellerAuctionDtoFromJson(Map<String, dynamic> json) =>
    SellerAuctionDto(
      seller: json['saller'] == null
          ? null
          : SellerInfoAuctionDto.fromJson(
              json['saller'] as Map<String, dynamic>),
      results: (json['results'] as List<dynamic>?)
          ?.map(
              (e) => ResultSellerAuctionDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SellerAuctionDtoToJson(SellerAuctionDto instance) =>
    <String, dynamic>{
      'saller': instance.seller,
      'results': instance.results,
    };

SellerInfoAuctionDto _$SellerInfoAuctionDtoFromJson(
        Map<String, dynamic> json) =>
    SellerInfoAuctionDto(
      id: json['id'] as String?,
      name: json['name'] as String?,
      total: json['total'] == null
          ? null
          : TotalSellerAuctionDto.fromJson(
              json['total'] as Map<String, dynamic>),
      url: json['url'] as String?,
      good: json['good'] == null
          ? null
          : GoodSellerAuctionDto.fromJson(json['good'] as Map<String, dynamic>),
      normal: json['normal'] == null
          ? null
          : NormalSellerAuctionDto.fromJson(
              json['normal'] as Map<String, dynamic>),
      bad: json['bad'] == null
          ? null
          : BadSellerAuctionDto.fromJson(json['bad'] as Map<String, dynamic>),
      percent: json['percent'] == null
          ? null
          : PercentSellerAuctionDto.fromJson(
              json['percent'] as Map<String, dynamic>),
      verified: json['verified'] as bool?,
      avatar: json['avatar'] as String?,
      updatedTime: json['updated_time'] as String?,
    );

Map<String, dynamic> _$SellerInfoAuctionDtoToJson(
        SellerInfoAuctionDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'total': instance.total,
      'url': instance.url,
      'good': instance.good,
      'normal': instance.normal,
      'bad': instance.bad,
      'percent': instance.percent,
      'verified': instance.verified,
      'avatar': instance.avatar,
      'updated_time': instance.updatedTime,
    };

TotalSellerAuctionDto _$TotalSellerAuctionDtoFromJson(
        Map<String, dynamic> json) =>
    TotalSellerAuctionDto(
      count: json['count'] as int?,
      percent: (json['percent'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$TotalSellerAuctionDtoToJson(
        TotalSellerAuctionDto instance) =>
    <String, dynamic>{
      'count': instance.count,
      'percent': instance.percent,
    };

GoodSellerAuctionDto _$GoodSellerAuctionDtoFromJson(
        Map<String, dynamic> json) =>
    GoodSellerAuctionDto(
      month: (json['month'] as num?)?.toDouble(),
      year: (json['year'] as num?)?.toDouble(),
      total: (json['total'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$GoodSellerAuctionDtoToJson(
        GoodSellerAuctionDto instance) =>
    <String, dynamic>{
      'month': instance.month,
      'year': instance.year,
      'total': instance.total,
    };

NormalSellerAuctionDto _$NormalSellerAuctionDtoFromJson(
        Map<String, dynamic> json) =>
    NormalSellerAuctionDto(
      month: (json['month'] as num?)?.toDouble(),
      year: (json['year'] as num?)?.toDouble(),
      total: (json['total'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$NormalSellerAuctionDtoToJson(
        NormalSellerAuctionDto instance) =>
    <String, dynamic>{
      'month': instance.month,
      'year': instance.year,
      'total': instance.total,
    };

BadSellerAuctionDto _$BadSellerAuctionDtoFromJson(Map<String, dynamic> json) =>
    BadSellerAuctionDto(
      month: (json['month'] as num?)?.toDouble(),
      year: (json['year'] as num?)?.toDouble(),
      total: (json['total'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$BadSellerAuctionDtoToJson(
        BadSellerAuctionDto instance) =>
    <String, dynamic>{
      'month': instance.month,
      'year': instance.year,
      'total': instance.total,
    };

PercentSellerAuctionDto _$PercentSellerAuctionDtoFromJson(
        Map<String, dynamic> json) =>
    PercentSellerAuctionDto(
      month: (json['month'] as num?)?.toDouble(),
      year: (json['year'] as num?)?.toDouble(),
      total: (json['total'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$PercentSellerAuctionDtoToJson(
        PercentSellerAuctionDto instance) =>
    <String, dynamic>{
      'month': instance.month,
      'year': instance.year,
      'total': instance.total,
    };

ResultSellerAuctionDto _$ResultSellerAuctionDtoFromJson(
        Map<String, dynamic> json) =>
    ResultSellerAuctionDto(
      ResultSellerAuctionDto._favoriteFromJson(json['favorite'] as bool?),
      code: json['code'] as String?,
      name: json['name'] as String?,
      url: json['url'] as String?,
      image: json['image'] as String?,
      price: json['price'] as int?,
      priceBuy: json['price_buy'],
      endTime: json['end_time'] as String?,
      sellerId: json['seller_id'] as String?,
      bids: json['bids'] as int?,
      neww: json['new'] as bool?,
      used: json['used'] as bool?,
      freeship: json['freeship'] as bool?,
    );

Map<String, dynamic> _$ResultSellerAuctionDtoToJson(
        ResultSellerAuctionDto instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'url': instance.url,
      'image': instance.image,
      'price': instance.price,
      'price_buy': instance.priceBuy,
      'end_time': instance.endTime,
      'seller_id': instance.sellerId,
      'bids': instance.bids,
      'new': instance.neww,
      'used': instance.used,
      'freeship': instance.freeship,
      'favorite': ResultSellerAuctionDto._favoriteToJson(instance.favorite),
    };
