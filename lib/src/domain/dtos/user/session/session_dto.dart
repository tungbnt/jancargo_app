import 'package:json_annotation/json_annotation.dart';

part 'session_dto.g.dart';

@JsonSerializable()
class SessionDto {
  const SessionDto({ this.code,this.data, }) : super();

  @JsonKey(name: 'code')
  final int? code;
  @JsonKey(name: 'data')
  final SessionUserDto? data;




  factory SessionDto.fromJson(Map<String, dynamic> json) =>
      _$SessionDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SessionDtoToJson(this);
}

@JsonSerializable()
class SessionUserDto {
  const SessionUserDto( {this.birthdate, this.id, this.username, this.name, this.shortName, this.fullName, this.avatar, this.email, this.phone, this.emailConfirmed, this.permission, this.role, this.roles, this.gender, this.address, this.social, this.sale, this.saleId, this.activeVip, this.vip, this.newUser, this.paymentPercent, this.percent, this.cancelBid, this.pwdHasBeenSet, this.level, this.wallet, this.customerNo, this.requestChangeSale, this.lastLogin, this.lastCollectNotification, this.rewardLevel, this.hasSpecialPriceList,  }) : super();

  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'username')
  final String? username;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'short_name')
  final String? shortName;
  @JsonKey(name: 'full_name')
  final String? fullName;
  @JsonKey(name: 'avatar')
  final String? avatar;
  @JsonKey(name: 'email')
  final String? email;
  @JsonKey(name: 'phone')
  final String? phone;
  @JsonKey(name: 'email_confirmed')
  final bool? emailConfirmed;
  @JsonKey(name: 'permission')
  final String? permission;
  @JsonKey(name: 'role')
  final String? role;
  @JsonKey(name: 'roles')
  final List<String>? roles;
  @JsonKey(name: 'gender')
  final String? gender;
  @JsonKey(name: 'address')
  final String? address;
  @JsonKey(name: 'social')
  final bool? social;
  @JsonKey(name: 'sale')
  final SaleSessionDto? sale;
  @JsonKey(name: 'sale_id')
  final String? saleId;
  @JsonKey(name: 'activeVip')
  final ActiveVipSessionDto? activeVip;
  @JsonKey(name: 'vip')
  final bool? vip;
  @JsonKey(name: 'newUser')
  final bool? newUser;
  @JsonKey(name: 'payment_percent')
  final double? paymentPercent;
  @JsonKey(name: 'percent')
  final int? percent;
  @JsonKey(name: 'cancel_bid')
  final int? cancelBid;
  @JsonKey(name: 'pwdHasBeenSet')
  final bool? pwdHasBeenSet;
  @JsonKey(name: 'level')
  final LevelSessionDto? level;
  @JsonKey(name: 'wallet')
  final WalletSessionDto? wallet;
  @JsonKey(name: 'customer_no')
  final String? customerNo;
  @JsonKey(name: 'birthdate')
  final String? birthdate;
  @JsonKey(name: 'request_change_sale')
  final bool? requestChangeSale;
  @JsonKey(name: 'last_login')
  final String? lastLogin;
  @JsonKey(name: 'last_collect_notification')
  final String? lastCollectNotification;
  @JsonKey(name: 'reward_level')
  final RewardSessionDto? rewardLevel;
  @JsonKey(name: 'has_special_price_list')
  final bool? hasSpecialPriceList;


  factory SessionUserDto.fromJson(Map<String, dynamic> json) =>
      _$SessionUserDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SessionUserDtoToJson(this);
}

@JsonSerializable()
class SaleSessionDto {
  const SaleSessionDto( { this.iid, this.fullName, this.email, this.phone, this.shortName, this.staffCode, this.id, this.name, }) : super();

  @JsonKey(name: '_id')
  final String? iid;
  @JsonKey(name: 'full_name')
  final String? fullName;
  @JsonKey(name: 'email')
  final String? email;
  @JsonKey(name: 'phone')
  final String? phone;
  @JsonKey(name: 'short_name')
  final String? shortName;
  @JsonKey(name: 'staff_code')
  final String? staffCode;
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'name')
  final String? name;




  factory SaleSessionDto.fromJson(Map<String, dynamic> json) =>
      _$SaleSessionDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SaleSessionDtoToJson(this);
}

@JsonSerializable()
class ActiveVipSessionDto {
  const ActiveVipSessionDto( { this.code, this.price, this.status,this.id, this.maxQuote, this.maxPrice, this.maxTotal, this.activeDate, this.updatedAt, this.createdAt, }) : super();

  @JsonKey(name: 'code')
  final String? code;
  @JsonKey(name: 'price')
  final int? price;
  @JsonKey(name: 'status')
  final bool? status;
  @JsonKey(name: 'max_quote')
  final int? maxQuote;
  @JsonKey(name: 'max_price')
  final int? maxPrice;
  @JsonKey(name: 'max_total')
  final int? maxTotal;
  @JsonKey(name: 'active_date')
  final String? activeDate;
  @JsonKey(name: 'updatedAt')
  final String? updatedAt;
  @JsonKey(name: 'createdAt')
  final String? createdAt;
  @JsonKey(name: '_id')
  final String? id;




  factory ActiveVipSessionDto.fromJson(Map<String, dynamic> json) =>
      _$ActiveVipSessionDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ActiveVipSessionDtoToJson(this);
}

@JsonSerializable()
class LevelSessionDto {
  const LevelSessionDto( { this.code, this.name,  }) : super();

  @JsonKey(name: 'code')
  final String? code;
  @JsonKey(name: 'name')
  final String? name;




  factory LevelSessionDto.fromJson(Map<String, dynamic> json) =>
      _$LevelSessionDtoFromJson(json);

  Map<String, dynamic> toJson() => _$LevelSessionDtoToJson(this);
}

@JsonSerializable()
class WalletSessionDto {
  const WalletSessionDto({ this.count, this.paid, this.primary, this.total,  this.balance, this.freeze,  }) : super();

  @JsonKey(name: 'balance')
  final int? balance;
  @JsonKey(name: 'freeze')
  final int? freeze;
  @JsonKey(name: 'count')
  final int? count;
  @JsonKey(name: 'paid')
  final double? paid;
  @JsonKey(name: 'primary')
  final int? primary;
  @JsonKey(name: 'total')
  final int? total;




  factory WalletSessionDto.fromJson(Map<String, dynamic> json) =>
      _$WalletSessionDtoFromJson(json);

  Map<String, dynamic> toJson() => _$WalletSessionDtoToJson(this);
}

@JsonSerializable()
class RewardSessionDto {
  const RewardSessionDto( { this.levelCode, this.levelName,  }) : super();

  @JsonKey(name: 'level_code')
  final String? levelCode;
  @JsonKey(name: 'level_name')
  final String? levelName;




  factory RewardSessionDto.fromJson(Map<String, dynamic> json) =>
      _$RewardSessionDtoFromJson(json);

  Map<String, dynamic> toJson() => _$RewardSessionDtoToJson(this);
}