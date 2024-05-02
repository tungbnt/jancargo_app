// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auction_manager_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuctionManagementRequest _$AuctionManagementRequestFromJson(
        Map<String, dynamic> json) =>
    AuctionManagementRequest(
      sort: json['sort'] as String?,
      order: json['order'] as String?,
      size: json['size'] as String?,
      page: json['page'] as String?,
      from: json['from'] as String?,
      to: json['to'] as String?,
      type: json['type'] as String?,
      search: json['search'] as String?,
    );

Map<String, dynamic> _$AuctionManagementRequestToJson(
        AuctionManagementRequest instance) =>
    <String, dynamic>{
      'size': instance.size,
      'page': instance.page,
      'from': instance.from,
      'to': instance.to,
      'type': instance.type,
      'sort': instance.sort,
      'order': instance.order,
      'search': instance.search,
    };
