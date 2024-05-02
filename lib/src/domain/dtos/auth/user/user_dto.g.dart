// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDto _$UserDtoFromJson(Map<String, dynamic> json) => UserDto(
      email: json['email'] as String?,
      emailConfirmed: json['email_confirmed'] as bool?,
      phone: json['phone'] as String?,
      password: json['password'] as String?,
      customer: json['customer'] as bool?,
      customerNo: json['customer_no'] as String?,
      fullName: json['full_name'] as String?,
      shortName: json['short_name'] as String?,
      gender: json['gender'] as String?,
      avatar: json['avatar'] as String?,
      paymentPercent: json['payment_percent'] as String?,
      status: json['status'] as bool?,
      debt: json['debt'] as bool?,
      register: json['register'] as bool?,
      levelCode: json['level_code'] as String?,
      stationCode: json['station_code'] as String?,
      typeMode: json['type_mode'] as String?,
      permissions: json['permissions'] as String?,
      roles: json['roles'] as List<dynamic>?,
      accountIds: json['account_ids'] as List<dynamic>?,
      deleted: json['deleted'] as bool?,
      social: json['social'] as bool?,
      cancel_bid: json['cancel_bid'] as int?,
      requestChangeSale: json['request_change_sale'] as bool?,
      utmMedium: json['utm_medium'] as String?,
      utmSource: json['utm_source'] as String?,
      utmCampaign: json['utm_campaign'] as String?,
      utmTerm: json['utm_term'] as String?,
      utmContent: json['utm_content'] as String?,
      urlPage: json['url_page'] as String?,
      utmBrowserType: json['utm_browser_type'] as String?,
      qrSignedSuccessAccount: json['qr_signed_success_count'] as int?,
      id: json['id'] as String?,
      createdDate: json['created_date'] as String?,
      updatedDate: json['updated_date'] as String?,
      newUser: json['newUser'] as bool?,
      name: json['name'] as String?,
      vip: json['vip'] as String?,
      setUp: json['setup'] == null
          ? null
          : SetUpDto.fromJson(json['setup'] as Map<String, dynamic>),
      quoteDto: json['qoute'] == null
          ? null
          : QuoteDto.fromJson(json['qoute'] as Map<String, dynamic>),
      expiresIn: json['expires_in'] as int?,
      refreshToken: json['refresh_token'] as String?,
    );

Map<String, dynamic> _$UserDtoToJson(UserDto instance) => <String, dynamic>{
      'email': instance.email,
      'email_confirmed': instance.emailConfirmed,
      'phone': instance.phone,
      'password': instance.password,
      'customer': instance.customer,
      'customer_no': instance.customerNo,
      'full_name': instance.fullName,
      'short_name': instance.shortName,
      'gender': instance.gender,
      'avatar': instance.avatar,
      'payment_percent': instance.paymentPercent,
      'status': instance.status,
      'debt': instance.debt,
      'register': instance.register,
      'level_code': instance.levelCode,
      'station_code': instance.stationCode,
      'type_mode': instance.typeMode,
      'permissions': instance.permissions,
      'roles': instance.roles,
      'account_ids': instance.accountIds,
      'deleted': instance.deleted,
      'social': instance.social,
      'cancel_bid': instance.cancel_bid,
      'request_change_sale': instance.requestChangeSale,
      'utm_medium': instance.utmMedium,
      'utm_source': instance.utmSource,
      'utm_campaign': instance.utmCampaign,
      'utm_term': instance.utmTerm,
      'utm_content': instance.utmContent,
      'url_page': instance.urlPage,
      'utm_browser_type': instance.utmBrowserType,
      'qr_signed_success_count': instance.qrSignedSuccessAccount,
      'id': instance.id,
      'created_date': instance.createdDate,
      'updated_date': instance.updatedDate,
      'newUser': instance.newUser,
      'name': instance.name,
      'vip': instance.vip,
      'setup': instance.setUp,
      'qoute': instance.quoteDto,
      'expires_in': instance.expiresIn,
      'refresh_token': instance.refreshToken,
    };

SetUpDto _$SetUpDtoFromJson(Map<String, dynamic> json) => SetUpDto(
      vipNum: json['vip_num'] as int?,
    );

Map<String, dynamic> _$SetUpDtoToJson(SetUpDto instance) => <String, dynamic>{
      'vip_num': instance.vipNum,
    };

QuoteDto _$QuoteDtoFromJson(Map<String, dynamic> json) => QuoteDto(
      balance: json['balance'] as int?,
    );

Map<String, dynamic> _$QuoteDtoToJson(QuoteDto instance) => <String, dynamic>{
      'balance': instance.balance,
    };
