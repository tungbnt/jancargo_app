// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tran_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TranDto _$TranDtoFromJson(Map<String, dynamic> json) => TranDto(
      balance: json['balance'] as int?,
      freeze: json['freeze'] as int?,
      account: json['account'] as int?,
      primary: json['primary'] as int?,
      paid: json['paid'] as int?,
      total: json['total'] as int?,
      transations: json['transations'] as List<dynamic>?,
    );

Map<String, dynamic> _$TranDtoToJson(TranDto instance) => <String, dynamic>{
      'balance': instance.balance,
      'freeze': instance.freeze,
      'account': instance.account,
      'primary': instance.primary,
      'paid': instance.paid,
      'total': instance.total,
      'transations': instance.transations,
    };
