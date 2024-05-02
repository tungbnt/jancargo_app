// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_key_word_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchKeyWordRequest _$SearchKeyWordRequestFromJson(
        Map<String, dynamic> json) =>
    SearchKeyWordRequest(
      query: json['query'] as String?,
      keyword: json['keyword'] as String?,
    );

Map<String, dynamic> _$SearchKeyWordRequestToJson(
        SearchKeyWordRequest instance) =>
    <String, dynamic>{
      'keyword': instance.keyword,
      'query': instance.query,
    };

RakutenSearchKeyWordRequest _$RakutenSearchKeyWordRequestFromJson(
        Map<String, dynamic> json) =>
    RakutenSearchKeyWordRequest(
      query: json['query'] as String?,
      keyword: json['keyword'] as String?,
      sort: json['sort'] as String?,
      priceFrom: json['maxPrice'] as String?,
      priceTo: json['minPrice'] as String?,
      condition: json['condition'] as String?,
      size: json['size'] as String?,
      page: json['page'] as String?,
    );

Map<String, dynamic> _$RakutenSearchKeyWordRequestToJson(
        RakutenSearchKeyWordRequest instance) =>
    <String, dynamic>{
      'keyword': instance.keyword,
      'query': instance.query,
      'maxPrice': instance.priceFrom,
      'sort': instance.sort,
      'minPrice': instance.priceTo,
      'condition': instance.condition,
      'size': instance.size,
      'page': instance.page,
    };

YahooShoppingSearchKeyWordRequest _$YahooShoppingSearchKeyWordRequestFromJson(
        Map<String, dynamic> json) =>
    YahooShoppingSearchKeyWordRequest(
      query: json['query'] as String?,
      keyword: json['keyword'] as String?,
      priceFrom: json['price_from'] as String?,
      priceTo: json['price_to'] as String?,
      condition: json['condition'] as String?,
      sort: json['sort'] as String?,
      size: json['size'] as String?,
      page: json['page'] as String?,
    );

Map<String, dynamic> _$YahooShoppingSearchKeyWordRequestToJson(
        YahooShoppingSearchKeyWordRequest instance) =>
    <String, dynamic>{
      'keyword': instance.keyword,
      'query': instance.query,
      'price_from': instance.priceFrom,
      'price_to': instance.priceTo,
      'sort': instance.sort,
      'condition': instance.condition,
      'size': instance.size,
      'page': instance.page,
    };
