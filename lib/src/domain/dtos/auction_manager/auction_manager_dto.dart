import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auction_manager_dto.g.dart';

@JsonSerializable()
class AuctionManagerDto {

  @JsonKey(name: 'data')
  final List<ItemsAuctionManagerDto>? data;
  @JsonKey(name: 'statistic')
  final StatisticAuctionManagerDto? statistic;

  AuctionManagerDto({
    this.data,this.statistic
  });
  factory AuctionManagerDto.fromJson(Map<String, dynamic> json) =>
      _$AuctionManagerDtoFromJson(json);
  Map<String, dynamic> toJson() => _$AuctionManagerDtoToJson(this);
}

@JsonSerializable()
class ItemsAuctionManagerDto {

  @JsonKey(name: '_id')
  final String? iid;
  @JsonKey(name: 'account')
  final String? account;
  @JsonKey(name: 'account_id')
  final String? accountId;
  @JsonKey(name: 'seller_id')
  final String? sellerId;
  @JsonKey(name: 'auction_id')
  final String? auctionId;
  @JsonKey(name: 'auction_ol')
  final String? auctionOl;
  @JsonKey(name: 'winner')
  final bool? winner;
  @JsonKey(name: 'code')
  final String? code;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'url')
  final String? url;
  @JsonKey(name: 'qty')
  final int? qty;
  @JsonKey(name: 'tax')
  final int? tax;
  @JsonKey(name: 'price')
  final int? price;
  @JsonKey(name: 'snipe_price')
  final int? snipePrice;
  @JsonKey(name: 'current_price')
  final int? currentPrice;
  @JsonKey(name: 'shipping_charges')
  final int? shippingCharges;
  @JsonKey(name: 'exchange_rate')
  final int? exchangeRate;
  @JsonKey(name: 'payment_price')
  final int? paymentPrice;
  @JsonKey(name: 'currency')
  final dynamic currency;
  @JsonKey(name: 'sku')
  final String? sku;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'images')
  final List<String>? images;
  @JsonKey(name: 'bids')
  final int? bids;
  @JsonKey(name: 'services_extra')
  final List<String>? servicesExtra;
  @JsonKey(name: 'bid_count')
  final int? bidCount;
  @JsonKey(name: 'mode')
  final String? mode;
  @JsonKey(name: 'ship_mode')
  final String? shipMode;
  @JsonKey(name: 'status')
  final int? status;
  @JsonKey(name: 'process')
  final int? process;
  @JsonKey(name: 'notify')
  final bool? notify;
  @JsonKey(name: 'allow')
  final bool? allow;
  @JsonKey(name: 'vip')
  final bool? vip;
  @JsonKey(name: 'deleted')
  final bool? deleted;
  @JsonKey(name: 'user_id')
  final String? userId;
  @JsonKey(name: 'sale_id')
  final String? saleId;
  @JsonKey(name: 'end_time')
  final String? endTime;
  @JsonKey(name: 'bid_date')
  final String? bidDate;
  @JsonKey(name: 'created_by')
  final String? createdBy;
  @JsonKey(name: 'updated_date')
  final String? updatedDate;
  @JsonKey(name: 'seller_reputation_level')
  final String? sellerReputationLevel;
  @JsonKey(name: 'loadbid_date')
  final String? loadbidDate;
  @JsonKey(name: 'created_date')
  final String? createdDate;
  @JsonKey(name: '__v')
  final int? v;
  @JsonKey(name: 'remark')
  final String? remark;
  @JsonKey(name: 'success_date')
  final String? successDate;
  @JsonKey(name: 'quote_code')
  final String? quoteCode;
  @JsonKey(name: 'last_run_task_at')
  final String? lastRunTaskAt;
  @JsonKey(name: 'finished')
  final bool? finished;
  @JsonKey(name: 'isCanPlaceBid')
  final bool? isCanPlaceBid;
  @JsonKey(name: 'isCanBeAuctioned')
  final bool? isCanBeAuctioned;
  @JsonKey(name: 'isExpired')
  final bool? isExpired;
  @JsonKey(name: 'isCancel')
  final bool? isCancel;
  @JsonKey(name: 'id')
  final String? id;



  ItemsAuctionManagerDto(this.iid, this.account, this.accountId, this.sellerId, this.auctionId, this.auctionOl, this.winner, this.code, this.name, this.url, this.qty, this.tax, this.price, this.snipePrice, this.currentPrice, this.shippingCharges, this.exchangeRate, this.paymentPrice, this.currency, this.sku, this.description, this.images, this.bids, this.servicesExtra, this.bidCount, this.mode, this.shipMode, this.status, this.process, this.notify, this.allow, this.vip, this.deleted, this.userId, this.saleId, this.endTime, this.bidDate, this.createdBy, this.updatedDate, this.sellerReputationLevel, this.loadbidDate, this.createdDate, this.v, this.remark, this.successDate, this.quoteCode, this.lastRunTaskAt, this.finished, this.isCanPlaceBid, this.isCanBeAuctioned, this.isExpired, this.isCancel, this.id,);
  factory ItemsAuctionManagerDto.fromJson(Map<String, dynamic> json) =>
      _$ItemsAuctionManagerDtoFromJson(json);
  Map<String, dynamic> toJson() => _$ItemsAuctionManagerDtoToJson(this);
}

@JsonSerializable()
class StatisticAuctionManagerDto {

  @JsonKey(name: '_id')
  final String? id;
  @JsonKey(name: 'total')
  final int? total;
  @JsonKey(name: 'bidding')
  final int? bidding;
  @JsonKey(name: 'hunting')
  final int? hunting;
  @JsonKey(name: 'finished')
  final int? finished;
  @JsonKey(name: 'successed')
  final int? successed;
  @JsonKey(name: 'paid')
  final int? paid;

  StatisticAuctionManagerDto({
    this.id, this.total, this.bidding, this.hunting, this.finished, this.successed, this.paid,
  });
  factory StatisticAuctionManagerDto.fromJson(Map<String, dynamic> json) =>
      _$StatisticAuctionManagerDtoFromJson(json);
  Map<String, dynamic> toJson() => _$StatisticAuctionManagerDtoToJson(this);
}