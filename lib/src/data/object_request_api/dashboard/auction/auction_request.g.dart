// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auction_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuctionRequest _$AuctionRequestFromJson(Map<String, dynamic> json) =>
    AuctionRequest(
      sort: json['sort'] as String?,
      code: json['code'] as String?,
      ranking: json['ranking'] as String?,
      category: json['category'] as String?,
      size: json['size'] as String?,
      page: json['page'] as String?,
    );

Map<String, dynamic> _$AuctionRequestToJson(AuctionRequest instance) =>
    <String, dynamic>{
      'size': instance.size,
      'page': instance.page,
      'category': instance.category,
      'sort': instance.sort,
      'code': instance.code,
      'ranking': instance.ranking,
    };
