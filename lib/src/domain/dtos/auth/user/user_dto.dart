import 'package:json_annotation/json_annotation.dart';

part 'user_dto.g.dart';

@JsonSerializable()
class UserDto {
  @JsonKey(name: 'email')
  final String? email;
  @JsonKey(name: 'email_confirmed')
  final bool? emailConfirmed;
  @JsonKey(name: 'phone')
  final String? phone;
  @JsonKey(name: 'password')
  final String? password;
  @JsonKey(name: 'customer')
  final bool? customer;
  @JsonKey(name: 'customer_no')
  final String? customerNo;
  @JsonKey(name: 'full_name')
  final String? fullName;
  @JsonKey(name: 'short_name')
  final String? shortName;
  @JsonKey(name: 'gender')
  final String? gender;
  @JsonKey(name: 'avatar')
  final String? avatar;
  @JsonKey(name: 'payment_percent')
  final String? paymentPercent;
  @JsonKey(name: 'status')
  final bool? status;
  @JsonKey(name: 'debt')
  final bool? debt;
  @JsonKey(name: 'register')
  final bool? register;
  @JsonKey(name: 'level_code')
  final String? levelCode;
  @JsonKey(name: 'station_code')
  final String? stationCode;
  @JsonKey(name: 'type_mode')
  final String? typeMode;
  @JsonKey(name: 'permissions')
  final String? permissions;
  @JsonKey(name: 'roles')
  final List? roles;
  @JsonKey(name: 'account_ids')
  final List? accountIds;
  @JsonKey(name: 'deleted')
  final bool? deleted;
  @JsonKey(name: 'social')
  final bool? social;
  @JsonKey(name: 'cancel_bid')
  final int? cancel_bid;
  @JsonKey(name: 'request_change_sale')
  final bool? requestChangeSale;
  @JsonKey(name: 'utm_medium')
  final String? utmMedium;
  @JsonKey(name: 'utm_source')
  final String? utmSource;
  @JsonKey(name: 'utm_campaign')
  final String? utmCampaign;
  @JsonKey(name: 'utm_term')
  final String? utmTerm;
  @JsonKey(name: 'utm_content')
  final String? utmContent;
  @JsonKey(name: 'url_page')
  final String? urlPage;
  @JsonKey(name: 'utm_browser_type')
  final String? utmBrowserType;
  @JsonKey(name: 'qr_signed_success_count')
  final int? qrSignedSuccessAccount;
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'created_date')
  final String? createdDate;
  @JsonKey(name: 'updated_date')
  final String? updatedDate;
  @JsonKey(name: 'newUser')
  final bool? newUser;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'vip')
  final String? vip;
  @JsonKey(name: 'setup')
  final SetUpDto? setUp;
  @JsonKey(name: 'qoute')
  final QuoteDto? quoteDto;

  @JsonKey(name: 'expires_in')
  final int? expiresIn;
  @JsonKey(name: 'refresh_token')
  final String? refreshToken;
  late final Map<String, dynamic>? _user;

  bool get isHasUser => _user != null && _user!.isNotEmpty;

  UserDto(
  { this.email,
    this.emailConfirmed,
    this.phone,
    this.password,
    this.customer,
    this.customerNo,
    this.fullName,
    this.shortName,
    this.gender,
    this.avatar,
    this.paymentPercent,
    this.status,
    this.debt,
    this.register,
    this.levelCode,
    this.stationCode,
    this.typeMode,
    this.permissions,
    this.roles,
    this.accountIds,
    this.deleted,
    this.social,
    this.cancel_bid,
    this.requestChangeSale,
    this.utmMedium,
    this.utmSource,
    this.utmCampaign,
    this.utmTerm,
    this.utmContent,
    this.urlPage,
    this.utmBrowserType,
    this.qrSignedSuccessAccount,
    this.id,
    this.createdDate,
    this.updatedDate,
    this.newUser,
    this.name,
    this.vip,
    this.setUp,
    this.quoteDto,
    this.expiresIn,
    this.refreshToken,
    }
  );

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserDtoToJson(this);
}

@JsonSerializable()
class SetUpDto {
  @JsonKey(name: 'vip_num')
  final int? vipNum;

  SetUpDto({
    this.vipNum,
  });

  factory SetUpDto.fromJson(Map<String, dynamic> json) =>
      _$SetUpDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SetUpDtoToJson(this);
}

@JsonSerializable()
class QuoteDto {
  @JsonKey(name: 'balance')
  final int? balance;

  QuoteDto({
    this.balance,
  });

  factory QuoteDto.fromJson(Map<String, dynamic> json) =>
      _$QuoteDtoFromJson(json);

  Map<String, dynamic> toJson() => _$QuoteDtoToJson(this);
}
