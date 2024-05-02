import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'seller_auction_dto.g.dart';

@JsonSerializable()
class SellerDetailAuctionDto {
  const SellerDetailAuctionDto({ this.code, this.data, }) : super();

  @JsonKey(name: 'code')
  final int? code;
  @JsonKey(name: 'data')
  final SellerAuctionDto? data;




  factory SellerDetailAuctionDto.fromJson(Map<String, dynamic> json) =>
      _$SellerDetailAuctionDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SellerDetailAuctionDtoToJson(this);
}

@JsonSerializable()
class SellerAuctionDto {
  const SellerAuctionDto({ this.seller, this.results }) : super();

  @JsonKey(name: 'saller')
  final SellerInfoAuctionDto? seller;
  // @JsonKey(name: 'pagination')
  // final List<BiddingUserDto>? pagination;
  @JsonKey(name: 'results')
  final List<ResultSellerAuctionDto>? results;




  factory SellerAuctionDto.fromJson(Map<String, dynamic> json) =>
      _$SellerAuctionDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SellerAuctionDtoToJson(this);
}

@JsonSerializable()
class SellerInfoAuctionDto {
  const SellerInfoAuctionDto({this.id, this.name, this.total, this.url, this.good, this.normal, this.bad, this.percent, this.verified, this.avatar, this.updatedTime,  }) : super();

  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'total')
  final TotalSellerAuctionDto? total;
  @JsonKey(name: 'url')
  final String? url;
  @JsonKey(name: 'good')
  final GoodSellerAuctionDto? good;
  @JsonKey(name: 'normal')
  final NormalSellerAuctionDto? normal;
  @JsonKey(name: 'bad')
  final BadSellerAuctionDto? bad;
  @JsonKey(name: 'percent')
  final PercentSellerAuctionDto? percent;
  @JsonKey(name: 'verified')
  final bool? verified;
  @JsonKey(name: 'avatar')
  final String? avatar;
  @JsonKey(name: 'updated_time')
  final String? updatedTime;


  factory SellerInfoAuctionDto.fromJson(Map<String, dynamic> json) =>
      _$SellerInfoAuctionDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SellerInfoAuctionDtoToJson(this);
}

@JsonSerializable()
class TotalSellerAuctionDto {
  const TotalSellerAuctionDto({ this.count, this.percent, }) : super();

  @JsonKey(name: 'count')
  final int? count;
  @JsonKey(name: 'percent')
  final double? percent;





  factory TotalSellerAuctionDto.fromJson(Map<String, dynamic> json) =>
      _$TotalSellerAuctionDtoFromJson(json);

  Map<String, dynamic> toJson() => _$TotalSellerAuctionDtoToJson(this);
}

@JsonSerializable()
class GoodSellerAuctionDto {
  const GoodSellerAuctionDto({ this.month, this.year, this.total}) : super();

  @JsonKey(name: 'month')
  final double? month;
  @JsonKey(name: 'year')
  final double? year;
  @JsonKey(name: 'total')
  final double? total;

  factory GoodSellerAuctionDto.fromJson(Map<String, dynamic> json) =>
      _$GoodSellerAuctionDtoFromJson(json);

  Map<String, dynamic> toJson() => _$GoodSellerAuctionDtoToJson(this);
}

@JsonSerializable()
class NormalSellerAuctionDto {
  const NormalSellerAuctionDto({ this.month, this.year, this.total}) : super();

  @JsonKey(name: 'month')
  final double? month;
  @JsonKey(name: 'year')
  final double? year;
  @JsonKey(name: 'total')
  final double? total;

  factory NormalSellerAuctionDto.fromJson(Map<String, dynamic> json) =>
      _$NormalSellerAuctionDtoFromJson(json);

  Map<String, dynamic> toJson() => _$NormalSellerAuctionDtoToJson(this);
}

@JsonSerializable()
class BadSellerAuctionDto {
  const BadSellerAuctionDto({ this.month, this.year, this.total}) : super();

  @JsonKey(name: 'month')
  final double? month;
  @JsonKey(name: 'year')
  final double? year;
  @JsonKey(name: 'total')
  final double? total;

  factory BadSellerAuctionDto.fromJson(Map<String, dynamic> json) =>
      _$BadSellerAuctionDtoFromJson(json);

  Map<String, dynamic> toJson() => _$BadSellerAuctionDtoToJson(this);
}
@JsonSerializable()
class PercentSellerAuctionDto {
  const PercentSellerAuctionDto({ this.month, this.year, this.total}) : super();

  @JsonKey(name: 'month')
  final double? month;
  @JsonKey(name: 'year')
  final double? year;
  @JsonKey(name: 'total')
  final double? total;

  factory PercentSellerAuctionDto.fromJson(Map<String, dynamic> json) =>
      _$PercentSellerAuctionDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PercentSellerAuctionDtoToJson(this);
}

@JsonSerializable()
class ResultSellerAuctionDto {
  const ResultSellerAuctionDto(this.favorite, { this.code, this.name, this.url, this.image, this.price, this.priceBuy, this.endTime, this.sellerId, this.bids, this.neww, this.used, this.freeship, }) : super();

  @JsonKey(name: 'code')
  final String? code;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'url')
  final String? url;
  @JsonKey(name: 'image')
  final String? image;
  @JsonKey(name: 'price')
  final int? price;
  @JsonKey(name: 'price_buy')
  final dynamic priceBuy;
  @JsonKey(name: 'end_time')
  final String? endTime;
  @JsonKey(name: 'seller_id')
  final String? sellerId;
  @JsonKey(name: 'bids')
  final int? bids;
  @JsonKey(name: 'new')
  final bool? neww;
  @JsonKey(name: 'used')
  final bool? used;
  @JsonKey(name: 'freeship')
  final bool? freeship;
  @JsonKey(name: 'favorite',fromJson: _favoriteFromJson,toJson: _favoriteToJson)
  final ValueNotifier<bool> favorite;

  static ValueNotifier<bool> _favoriteFromJson(bool? value) =>
      ValueNotifier<bool>(value ?? false);

  static bool _favoriteToJson(ValueNotifier<bool> favorite) =>
      favorite.value;


  factory ResultSellerAuctionDto.fromJson(Map<String, dynamic> json) =>
      _$ResultSellerAuctionDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ResultSellerAuctionDtoToJson(this);
}