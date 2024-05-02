import 'package:json_annotation/json_annotation.dart';

part 'bidding_user_dto.g.dart';

@JsonSerializable()
class BiddingDto {
  const BiddingDto({ this.success, this.data, }) : super();

  @JsonKey(name: 'success')
  final bool? success;
  @JsonKey(name: 'data')
  final List<BiddingUserDto>? data;




  factory BiddingDto.fromJson(Map<String, dynamic> json) =>
      _$BiddingDtoFromJson(json);

  Map<String, dynamic> toJson() => _$BiddingDtoToJson(this);
}

@JsonSerializable()
class BiddingUserDto {
  const BiddingUserDto({this.id, this.account, this.winner, this.code, this.name, this.qty, this.partial, this.price, this.snipePrice, this.servicesExtra, this.mode, this.shipMode, this.endTime, this.lastMinuteToBid, this.image, }) : super();

  @JsonKey(name: '_id')
  final String? id;
  @JsonKey(name: 'account')
  final String? account;
  @JsonKey(name: 'winner')
  final bool? winner;
  @JsonKey(name: 'code')
  final String? code;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'qty')
  final int? qty;
  @JsonKey(name: 'partial')
  final String? partial;
@JsonKey(name: 'price')
final int? price;
@JsonKey(name: 'snipe_price')
final int? snipePrice;
@JsonKey(name: 'services_extra')
final List<String>? servicesExtra;
@JsonKey(name: 'mode')
final String? mode;
@JsonKey(name: 'ship_mode')
final String? shipMode;
@JsonKey(name: 'end_time')
final String? endTime;
@JsonKey(name: 'last_minute_to_bid')
final int? lastMinuteToBid;
@JsonKey(name: 'image')
final String? image;


  factory BiddingUserDto.fromJson(Map<String, dynamic> json) =>
      _$BiddingUserDtoFromJson(json);

  Map<String, dynamic> toJson() => _$BiddingUserDtoToJson(this);
}