// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auction_manager_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuctionManagerDto _$AuctionManagerDtoFromJson(Map<String, dynamic> json) =>
    AuctionManagerDto(
      data: (json['data'] as List<dynamic>?)
          ?.map(
              (e) => ItemsAuctionManagerDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      statistic: json['statistic'] == null
          ? null
          : StatisticAuctionManagerDto.fromJson(
              json['statistic'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AuctionManagerDtoToJson(AuctionManagerDto instance) =>
    <String, dynamic>{
      'data': instance.data,
      'statistic': instance.statistic,
    };

ItemsAuctionManagerDto _$ItemsAuctionManagerDtoFromJson(
        Map<String, dynamic> json) =>
    ItemsAuctionManagerDto(
      json['_id'] as String?,
      json['account'] as String?,
      json['account_id'] as String?,
      json['seller_id'] as String?,
      json['auction_id'] as String?,
      json['auction_ol'] as String?,
      json['winner'] as bool?,
      json['code'] as String?,
      json['name'] as String?,
      json['url'] as String?,
      json['qty'] as int?,
      json['tax'] as int?,
      json['price'] as int?,
      json['snipe_price'] as int?,
      json['current_price'] as int?,
      json['shipping_charges'] as int?,
      json['exchange_rate'] as int?,
      json['payment_price'] as int?,
      json['currency'],
      json['sku'] as String?,
      json['description'] as String?,
      (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      json['bids'] as int?,
      (json['services_extra'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      json['bid_count'] as int?,
      json['mode'] as String?,
      json['ship_mode'] as String?,
      json['status'] as int?,
      json['process'] as int?,
      json['notify'] as bool?,
      json['allow'] as bool?,
      json['vip'] as bool?,
      json['deleted'] as bool?,
      json['user_id'] as String?,
      json['sale_id'] as String?,
      json['end_time'] as String?,
      json['bid_date'] as String?,
      json['created_by'] as String?,
      json['updated_date'] as String?,
      json['seller_reputation_level'] as String?,
      json['loadbid_date'] as String?,
      json['created_date'] as String?,
      json['__v'] as int?,
      json['remark'] as String?,
      json['success_date'] as String?,
      json['quote_code'] as String?,
      json['last_run_task_at'] as String?,
      json['finished'] as bool?,
      json['isCanPlaceBid'] as bool?,
      json['isCanBeAuctioned'] as bool?,
      json['isExpired'] as bool?,
      json['isCancel'] as bool?,
      json['id'] as String?,
    );

Map<String, dynamic> _$ItemsAuctionManagerDtoToJson(
        ItemsAuctionManagerDto instance) =>
    <String, dynamic>{
      '_id': instance.iid,
      'account': instance.account,
      'account_id': instance.accountId,
      'seller_id': instance.sellerId,
      'auction_id': instance.auctionId,
      'auction_ol': instance.auctionOl,
      'winner': instance.winner,
      'code': instance.code,
      'name': instance.name,
      'url': instance.url,
      'qty': instance.qty,
      'tax': instance.tax,
      'price': instance.price,
      'snipe_price': instance.snipePrice,
      'current_price': instance.currentPrice,
      'shipping_charges': instance.shippingCharges,
      'exchange_rate': instance.exchangeRate,
      'payment_price': instance.paymentPrice,
      'currency': instance.currency,
      'sku': instance.sku,
      'description': instance.description,
      'images': instance.images,
      'bids': instance.bids,
      'services_extra': instance.servicesExtra,
      'bid_count': instance.bidCount,
      'mode': instance.mode,
      'ship_mode': instance.shipMode,
      'status': instance.status,
      'process': instance.process,
      'notify': instance.notify,
      'allow': instance.allow,
      'vip': instance.vip,
      'deleted': instance.deleted,
      'user_id': instance.userId,
      'sale_id': instance.saleId,
      'end_time': instance.endTime,
      'bid_date': instance.bidDate,
      'created_by': instance.createdBy,
      'updated_date': instance.updatedDate,
      'seller_reputation_level': instance.sellerReputationLevel,
      'loadbid_date': instance.loadbidDate,
      'created_date': instance.createdDate,
      '__v': instance.v,
      'remark': instance.remark,
      'success_date': instance.successDate,
      'quote_code': instance.quoteCode,
      'last_run_task_at': instance.lastRunTaskAt,
      'finished': instance.finished,
      'isCanPlaceBid': instance.isCanPlaceBid,
      'isCanBeAuctioned': instance.isCanBeAuctioned,
      'isExpired': instance.isExpired,
      'isCancel': instance.isCancel,
      'id': instance.id,
    };

StatisticAuctionManagerDto _$StatisticAuctionManagerDtoFromJson(
        Map<String, dynamic> json) =>
    StatisticAuctionManagerDto(
      id: json['_id'] as String?,
      total: json['total'] as int?,
      bidding: json['bidding'] as int?,
      hunting: json['hunting'] as int?,
      finished: json['finished'] as int?,
      successed: json['successed'] as int?,
      paid: json['paid'] as int?,
    );

Map<String, dynamic> _$StatisticAuctionManagerDtoToJson(
        StatisticAuctionManagerDto instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'total': instance.total,
      'bidding': instance.bidding,
      'hunting': instance.hunting,
      'finished': instance.finished,
      'successed': instance.successed,
      'paid': instance.paid,
    };
