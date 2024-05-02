import 'package:json_annotation/json_annotation.dart';

part 'detail_dto.g.dart';
@JsonSerializable()
class DetailDto  {
  const DetailDto( {this.sellerDto,this.code, this.url, this.name, this.price, this.tax, this.priceBuy, this.taxBuy, this.feeShip, this.fromOutsideOfapan, this.thumbnails, this.description, this.qty, this.categoryId, this.startDate, this.endDate, this.earlyClose, this.autoExtension, this.returnable, this.biderRestriction, this.bidderVerification, this.initPrice, this.condition, this.bids, this.postage, this.finished, this.methods, this.highestBidder, this.wonInfo, this.timeLeft, this.endTime, })
      : super();

  @JsonKey(name: 'code')
  final String? code;

  @JsonKey(name: 'url')
  final String? url;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'price')
  final int? price;
  @JsonKey(name: 'tax')
  final int? tax;
  @JsonKey(name: 'price_buy')
  final int? priceBuy;
  @JsonKey(name: 'tax_buy')
  final int? taxBuy;
  @JsonKey(name: 'feeship')
  final int? feeShip;
  @JsonKey(name: 'from_outside_of_japan')
  final bool? fromOutsideOfapan;
  @JsonKey(name: 'thumbnails')
  final List<String>? thumbnails;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'qty')
  final int? qty;
  @JsonKey(name: 'category_id')
  final String? categoryId;
  @JsonKey(name: 'start_date')
  final String? startDate;
  @JsonKey(name: 'end_date')
  final String? endDate;
  @JsonKey(name: 'early_close')
  final bool? earlyClose;
  @JsonKey(name: 'auto_extension')
  final bool? autoExtension;
  @JsonKey(name: 'returnable')
  final bool? returnable;
  @JsonKey(name: 'bider_restriction')
  final bool? biderRestriction;
  @JsonKey(name: 'bidder_verification')
  final bool? bidderVerification;
  @JsonKey(name: 'init_price')
  final int? initPrice;
  @JsonKey(name: 'condition')
  final String? condition;
  @JsonKey(name: 'bids')
  final int? bids;
  @JsonKey(name: 'postage')
  final bool? postage;
  @JsonKey(name: 'finished')
  final bool? finished;
  @JsonKey(name: 'methods')
  final MethodsDto? methods;
  @JsonKey(name: 'highest_bidder')
  final HighestBidderDto? highestBidder;
  @JsonKey(name: 'won_info')
  final dynamic wonInfo;
  @JsonKey(name: 'time_left')
  final int? timeLeft;
  @JsonKey(name: 'end_time')
  final String? endTime;
  @JsonKey(name: 'seller')
  final SellerDto? sellerDto;



  factory DetailDto.fromJson(Map<String, dynamic> json) =>
      _$DetailDtoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$DetailDtoToJson(this);
}

@JsonSerializable()
class SellerDto  {
  const SellerDto( {this.url, this.id, this.name, this.total, this.percent, this.avatar, this.details, })
      : super();

  @JsonKey(name: 'url')
  final String? url;
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'total')
  final int? total;
  @JsonKey(name: 'percent')
  final String? percent;
  @JsonKey(name: 'avatar')
  final String? avatar;
  @JsonKey(name: 'details')
  final DetailSellerDto? details;


  factory SellerDto.fromJson(Map<String, dynamic> json) =>
      _$SellerDtoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SellerDtoToJson(this);
}


@JsonSerializable()
class DetailSellerDto  {
  const DetailSellerDto({this.normal, this.bad, this.url, this.id, this.name, this.total, this.good, this.percent, this.verified, this.avatar, this.updatedTime,  })
      : super();

  @JsonKey(name: 'url')
  final String? url;
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'total')
  final TotalDto? total;
  @JsonKey(name: 'good')
  final GoodDto? good;
  @JsonKey(name: 'normal')
  final NormalDto? normal;
  @JsonKey(name: 'bad')
  final BadDto? bad;
  @JsonKey(name: 'percent')
  final PercentDto? percent;
  @JsonKey(name: 'verified')
  final bool? verified;
  @JsonKey(name: 'avatar')
  final String? avatar;
  @JsonKey(name: 'updated_time')
  final String? updatedTime;


  factory DetailSellerDto.fromJson(Map<String, dynamic> json) =>
      _$DetailSellerDtoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$DetailSellerDtoToJson(this);
}

@JsonSerializable()
class TotalDto  {
const TotalDto({this.count, this.id,  })
    : super();

   @JsonKey(name: 'count')
   final int? count;
   @JsonKey(name: 'percent')
   final double? id;


factory TotalDto.fromJson(Map<String, dynamic> json) =>
_$TotalDtoFromJson(json);

@override
Map<String, dynamic> toJson() => _$TotalDtoToJson(this);
}
@JsonSerializable()
class GoodDto  {
const GoodDto({this.count,this.total, this.month, this.year,})
    : super();

@JsonKey(name: 'count')
final double? count;
@JsonKey(name: 'total')
final double? total;
@JsonKey(name: 'month')
final double? month;
@JsonKey(name: 'year')
final double? year;


factory GoodDto.fromJson(Map<String, dynamic> json) =>
_$GoodDtoFromJson(json);

@override
Map<String, dynamic> toJson() => _$GoodDtoToJson(this);
}
@JsonSerializable()
class NormalDto  {
const NormalDto({this.count,this.total, this.month, this.year,})
    : super();

@JsonKey(name: 'count')
final double? count;
@JsonKey(name: 'total')
final double? total;
@JsonKey(name: 'month')
final double? month;
@JsonKey(name: 'year')
final double? year;


factory NormalDto.fromJson(Map<String, dynamic> json) =>
_$NormalDtoFromJson(json);

@override
Map<String, dynamic> toJson() => _$NormalDtoToJson(this);
}

@JsonSerializable()
class BadDto  {
const BadDto({this.count, this.total,this.month, this.year,})
    : super();

@JsonKey(name: 'count')
final double? count;
@JsonKey(name: 'total')
final double? total;
@JsonKey(name: 'month')
final double? month;
@JsonKey(name: 'year')
final double? year;


factory BadDto.fromJson(Map<String, dynamic> json) =>
_$BadDtoFromJson(json);

@override
Map<String, dynamic> toJson() => _$BadDtoToJson(this);
}
@JsonSerializable()
class PercentDto  {
const PercentDto({this.count, this.month, this.year,})
    : super();

@JsonKey(name: 'count')
final double? count;
@JsonKey(name: 'month')
final double? month;
@JsonKey(name: 'year')
final double? year;


factory PercentDto.fromJson(Map<String, dynamic> json) =>
_$PercentDtoFromJson(json);

@override
Map<String, dynamic> toJson() => _$PercentDtoToJson(this);
}
@JsonSerializable()
class MethodsDto  {
  const MethodsDto( {this.bid, this.buy, this.someProcedures,})
      : super();

  @JsonKey(name: 'bid')
  final bool? bid;
  @JsonKey(name: 'buy')
  final bool? buy;
  @JsonKey(name: 'some_procedures_need_to_be_done')
  final bool? someProcedures;


  factory MethodsDto.fromJson(Map<String, dynamic> json) =>
      _$MethodsDtoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MethodsDtoToJson(this);
}


@JsonSerializable()
class HighestBidderDto  {
  const HighestBidderDto({this.message, this.isHighest, })
      : super();

  @JsonKey(name: 'message')
  final String? message;
  @JsonKey(name: 'is_highest')
  final bool? isHighest;


  factory HighestBidderDto.fromJson(Map<String, dynamic> json) =>
      _$HighestBidderDtoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$HighestBidderDtoToJson(this);
}