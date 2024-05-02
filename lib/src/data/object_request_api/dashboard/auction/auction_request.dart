import 'dart:ffi';

import 'package:jancargo_app/src/app_manager.dart';
import 'package:jancargo_app/src/util/app_convert.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auction_request.g.dart';

@JsonSerializable()
class AuctionRequest {
  @JsonKey(name: 'size')
  final String? size;
  @JsonKey(name: 'page')
  final String? page;
  @JsonKey(name: 'category')
  final String? category;
  @JsonKey(name: 'sort')
  final String? sort;
  @JsonKey(name: 'code')
  final String? code;
  @JsonKey(name: 'ranking')
  final String? ranking;

  AuctionRequest({
    this.sort,
    this.code,
    this.ranking,
    this.category,
    this.size,
    this.page,
  });

  Map<String, dynamic> toJson() => _$AuctionRequestToJson(this);
}

class AuctionSearchRequest {
  final String? size;

  final String? page;

  final String? keyword;

  final String? query;
  final String? priceType;
  final String? minVn;
  final String? maxVn;

  final String? store;

  final String? itemStatus;

  final Map<String, dynamic>? param;

  final Iterable<int>? brandId;

  AuctionSearchRequest({
    this.minVn,
    this.maxVn,
    this.priceType,
    this.store,
    this.itemStatus,
    this.keyword,
    this.query,
    this.size,
    this.page,
    this.param,
    this.brandId,
  });

  Map<String, dynamic> toJson() {
    final effectiveParam = Map.of(param ?? {});
    final priceMax = maxVn!.isNotEmpty
        ? int.parse(maxVn!.toString()) / (AppManager.appSession.exchange ?? 176)
        : 0;
    final priceMin = minVn!.isNotEmpty
        ? int.parse(minVn!.toString()) / (AppManager.appSession.exchange ?? 176)
        : 0;

    if (maxVn != null && maxVn?.isNotEmpty == true) {
      effectiveParam.removeWhere(
          (key, value) => key == 'va' || key == 'p' || key == 'aucmaxprice');
    } else if (brandId != null && brandId!.isNotEmpty && brandId != 0) {
      if (maxVn != null && maxVn?.isNotEmpty == true) {
        effectiveParam.removeWhere((key, value) =>
            key == 'va' ||
            key == 'p' ||
            key == 'aucmaxprice' ||
            key == 'brand_id');
      } else {
        effectiveParam.removeWhere(
            (key, value) => key == 'va' || key == 'p' || key == 'brand_id');
      }
    } else {
      effectiveParam.removeWhere((key, value) => key == 'va' || key == 'p');
    }

    return {
      if (param != null) ...effectiveParam,
      'size': size,
      'page': page,
      'keyword': keyword,
      'query': query,
      if (priceType != null && priceType?.isNotEmpty == true)
        'price_type': priceType,
      if (maxVn != null && maxVn!.isNotEmpty) 'aucmaxprice': priceMax.round(),
      if (minVn != null && minVn!.isNotEmpty) 'aucminprice': priceMin.round(),
      if (maxVn != null && maxVn!.isNotEmpty) 'max': priceMax.round(),
      if (minVn != null && minVn!.isNotEmpty) 'min': priceMin.round(),
      if (brandId != null &&
          brandId!.isNotEmpty &&
          (effectiveParam['brand_id'] == null ||
              effectiveParam['brand_id'] == ''))
        'brand_id': brandId!.join(','),
    };
  }
}
