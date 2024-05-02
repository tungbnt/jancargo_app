// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SessionDto _$SessionDtoFromJson(Map<String, dynamic> json) => SessionDto(
      code: json['code'] as int?,
      data: json['data'] == null
          ? null
          : SessionUserDto.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SessionDtoToJson(SessionDto instance) =>
    <String, dynamic>{
      'code': instance.code,
      'data': instance.data,
    };

SessionUserDto _$SessionUserDtoFromJson(Map<String, dynamic> json) =>
    SessionUserDto(
      birthdate: json['birthdate'] as String?,
      id: json['id'] as String?,
      username: json['username'] as String?,
      name: json['name'] as String?,
      shortName: json['short_name'] as String?,
      fullName: json['full_name'] as String?,
      avatar: json['avatar'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      emailConfirmed: json['email_confirmed'] as bool?,
      permission: json['permission'] as String?,
      role: json['role'] as String?,
      roles:
          (json['roles'] as List<dynamic>?)?.map((e) => e as String).toList(),
      gender: json['gender'] as String?,
      address: json['address'] as String?,
      social: json['social'] as bool?,
      sale: json['sale'] == null
          ? null
          : SaleSessionDto.fromJson(json['sale'] as Map<String, dynamic>),
      saleId: json['sale_id'] as String?,
      activeVip: json['activeVip'] == null
          ? null
          : ActiveVipSessionDto.fromJson(
              json['activeVip'] as Map<String, dynamic>),
      vip: json['vip'] as bool?,
      newUser: json['newUser'] as bool?,
      paymentPercent: (json['payment_percent'] as num?)?.toDouble(),
      percent: json['percent'] as int?,
      cancelBid: json['cancel_bid'] as int?,
      pwdHasBeenSet: json['pwdHasBeenSet'] as bool?,
      level: json['level'] == null
          ? null
          : LevelSessionDto.fromJson(json['level'] as Map<String, dynamic>),
      wallet: json['wallet'] == null
          ? null
          : WalletSessionDto.fromJson(json['wallet'] as Map<String, dynamic>),
      customerNo: json['customer_no'] as String?,
      requestChangeSale: json['request_change_sale'] as bool?,
      lastLogin: json['last_login'] as String?,
      lastCollectNotification: json['last_collect_notification'] as String?,
      rewardLevel: json['reward_level'] == null
          ? null
          : RewardSessionDto.fromJson(
              json['reward_level'] as Map<String, dynamic>),
      hasSpecialPriceList: json['has_special_price_list'] as bool?,
    );

Map<String, dynamic> _$SessionUserDtoToJson(SessionUserDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'name': instance.name,
      'short_name': instance.shortName,
      'full_name': instance.fullName,
      'avatar': instance.avatar,
      'email': instance.email,
      'phone': instance.phone,
      'email_confirmed': instance.emailConfirmed,
      'permission': instance.permission,
      'role': instance.role,
      'roles': instance.roles,
      'gender': instance.gender,
      'address': instance.address,
      'social': instance.social,
      'sale': instance.sale,
      'sale_id': instance.saleId,
      'activeVip': instance.activeVip,
      'vip': instance.vip,
      'newUser': instance.newUser,
      'payment_percent': instance.paymentPercent,
      'percent': instance.percent,
      'cancel_bid': instance.cancelBid,
      'pwdHasBeenSet': instance.pwdHasBeenSet,
      'level': instance.level,
      'wallet': instance.wallet,
      'customer_no': instance.customerNo,
      'birthdate': instance.birthdate,
      'request_change_sale': instance.requestChangeSale,
      'last_login': instance.lastLogin,
      'last_collect_notification': instance.lastCollectNotification,
      'reward_level': instance.rewardLevel,
      'has_special_price_list': instance.hasSpecialPriceList,
    };

SaleSessionDto _$SaleSessionDtoFromJson(Map<String, dynamic> json) =>
    SaleSessionDto(
      iid: json['_id'] as String?,
      fullName: json['full_name'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      shortName: json['short_name'] as String?,
      staffCode: json['staff_code'] as String?,
      id: json['id'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$SaleSessionDtoToJson(SaleSessionDto instance) =>
    <String, dynamic>{
      '_id': instance.iid,
      'full_name': instance.fullName,
      'email': instance.email,
      'phone': instance.phone,
      'short_name': instance.shortName,
      'staff_code': instance.staffCode,
      'id': instance.id,
      'name': instance.name,
    };

ActiveVipSessionDto _$ActiveVipSessionDtoFromJson(Map<String, dynamic> json) =>
    ActiveVipSessionDto(
      code: json['code'] as String?,
      price: json['price'] as int?,
      status: json['status'] as bool?,
      id: json['_id'] as String?,
      maxQuote: json['max_quote'] as int?,
      maxPrice: json['max_price'] as int?,
      maxTotal: json['max_total'] as int?,
      activeDate: json['active_date'] as String?,
      updatedAt: json['updatedAt'] as String?,
      createdAt: json['createdAt'] as String?,
    );

Map<String, dynamic> _$ActiveVipSessionDtoToJson(
        ActiveVipSessionDto instance) =>
    <String, dynamic>{
      'code': instance.code,
      'price': instance.price,
      'status': instance.status,
      'max_quote': instance.maxQuote,
      'max_price': instance.maxPrice,
      'max_total': instance.maxTotal,
      'active_date': instance.activeDate,
      'updatedAt': instance.updatedAt,
      'createdAt': instance.createdAt,
      '_id': instance.id,
    };

LevelSessionDto _$LevelSessionDtoFromJson(Map<String, dynamic> json) =>
    LevelSessionDto(
      code: json['code'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$LevelSessionDtoToJson(LevelSessionDto instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
    };

WalletSessionDto _$WalletSessionDtoFromJson(Map<String, dynamic> json) =>
    WalletSessionDto(
      count: json['count'] as int?,
      paid: (json['paid'] as num?)?.toDouble(),
      primary: json['primary'] as int?,
      total: json['total'] as int?,
      balance: json['balance'] as int?,
      freeze: json['freeze'] as int?,
    );

Map<String, dynamic> _$WalletSessionDtoToJson(WalletSessionDto instance) =>
    <String, dynamic>{
      'balance': instance.balance,
      'freeze': instance.freeze,
      'count': instance.count,
      'paid': instance.paid,
      'primary': instance.primary,
      'total': instance.total,
    };

RewardSessionDto _$RewardSessionDtoFromJson(Map<String, dynamic> json) =>
    RewardSessionDto(
      levelCode: json['level_code'] as String?,
      levelName: json['level_name'] as String?,
    );

Map<String, dynamic> _$RewardSessionDtoToJson(RewardSessionDto instance) =>
    <String, dynamic>{
      'level_code': instance.levelCode,
      'level_name': instance.levelName,
    };
