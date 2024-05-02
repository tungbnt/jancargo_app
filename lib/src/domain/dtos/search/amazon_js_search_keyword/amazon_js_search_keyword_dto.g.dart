// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'amazon_js_search_keyword_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AmazonSearchKeyWordDto _$AmazonSearchKeyWordDtoFromJson(
        Map<String, dynamic> json) =>
    AmazonSearchKeyWordDto(
      products: (json['products'] as List<dynamic>?)
          ?.map((e) =>
              AmazonItemsSearchKeyWordDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AmazonSearchKeyWordDtoToJson(
        AmazonSearchKeyWordDto instance) =>
    <String, dynamic>{
      'products': instance.products,
    };

AmazonItemsSearchKeyWordDto _$AmazonItemsSearchKeyWordDtoFromJson(
        Map<String, dynamic> json) =>
    AmazonItemsSearchKeyWordDto(
      code: json['code'] as String?,
      image: json['image'] as String?,
      name: json['name'] as String?,
      link: json['link'] as String?,
      originHref: json['origin_href'] as String?,
      currentPrice: json['current_price'],
      beforePrice: json['before_price'],
      discounted: json['discounted'] as bool?,
      savingsAmount: json['savings_amount'],
      savingsPercent: json['savings_percent'],
      country: json['country'] as String?,
      reviews: json['reviews'] == null
          ? null
          : AmazonReviewSearchKeyWordDto.fromJson(
              json['reviews'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AmazonItemsSearchKeyWordDtoToJson(
        AmazonItemsSearchKeyWordDto instance) =>
    <String, dynamic>{
      'code': instance.code,
      'image': instance.image,
      'name': instance.name,
      'link': instance.link,
      'origin_href': instance.originHref,
      'current_price': instance.currentPrice,
      'before_price': instance.beforePrice,
      'discounted': instance.discounted,
      'savings_amount': instance.savingsAmount,
      'savings_percent': instance.savingsPercent,
      'country': instance.country,
      'reviews': instance.reviews,
    };

AmazonReviewSearchKeyWordDto _$AmazonReviewSearchKeyWordDtoFromJson(
        Map<String, dynamic> json) =>
    AmazonReviewSearchKeyWordDto(
      rating: json['rating'] as int?,
    );

Map<String, dynamic> _$AmazonReviewSearchKeyWordDtoToJson(
        AmazonReviewSearchKeyWordDto instance) =>
    <String, dynamic>{
      'rating': instance.rating,
    };
