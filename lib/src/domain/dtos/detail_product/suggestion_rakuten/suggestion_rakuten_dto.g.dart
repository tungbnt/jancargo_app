// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'suggestion_rakuten_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SuggestionRakutenDto _$SuggestionRakutenDtoFromJson(
        Map<String, dynamic> json) =>
    SuggestionRakutenDto(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) =>
              ItemsSuggestionRakutenDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SuggestionRakutenDtoToJson(
        SuggestionRakutenDto instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

ItemsSuggestionRakutenDto _$ItemsSuggestionRakutenDtoFromJson(
        Map<String, dynamic> json) =>
    ItemsSuggestionRakutenDto(
      shopUrl: json['shopUrl'] as String?,
      smallImageUrls: (json['smallImageUrls'] as List<dynamic>?)
          ?.map((e) => SmallImageUrlsSuggestionRakutenDto.fromJson(
              e as Map<String, dynamic>))
          .toList(),
      startTime: json['startTime'] as String?,
      taxFlag: json['taxFlag'] as int?,
      reviewAverage: json['reviewAverage'] as String?,
      reviewCount: json['reviewCount'] as int?,
      shipOverseasArea: json['shipOverseasArea'] as String?,
      shipOverseasFlag: json['shipOverseasFlag'] as int?,
      shopAffiliateUrl: json['shopAffiliateUrl'] as String?,
      shopCode: json['shopCode'] as String?,
      shopName: json['shopName'] as String?,
      shopOfTheYearFlag: json['shopOfTheYearFlag'] as int?,
      imageFlag: json['imageFlag'] as int?,
      itemCode: json['itemCode'] as String?,
      itemName: json['itemName'] as String?,
      itemPrice: json['itemPrice'] as String?,
      itemUrl: json['itemUrl'] as String?,
      mediumImageUrls: (json['mediumImageUrls'] as List<dynamic>?)
          ?.map((e) => MediumImageUrlsSuggestionRakutenDto.fromJson(
              e as Map<String, dynamic>))
          .toList(),
      pointRate: json['pointRate'] as int?,
      pointRateEndTime: json['pointRateEndTime'] as String?,
      pointRateStartTime: json['pointRateStartTime'] as String?,
      postageFlag: json['postageFlag'] as int?,
      rank: json['rank'] as int?,
      affiliateRate: json['affiliateRate'] as String?,
      affiliateUrl: json['affiliateUrl'] as String?,
      asurakuArea: json['asurakuArea'] as String?,
      asurakuClosingTime: json['asurakuClosingTime'] as String?,
      asurakuFlag: json['asurakuFlag'] as int?,
      carrier: json['carrier'] as int?,
      catchcopy: json['catchcopy'] as String?,
      creditCardFlag: json['creditCardFlag'] as int?,
      endTime: json['endTime'] as String?,
      genreId: json['genreId'] as String?,
      itemCaption: json['itemCaption'] as String?,
      availability: json['availability'] as int?,
    );

Map<String, dynamic> _$ItemsSuggestionRakutenDtoToJson(
        ItemsSuggestionRakutenDto instance) =>
    <String, dynamic>{
      'affiliateRate': instance.affiliateRate,
      'affiliateUrl': instance.affiliateUrl,
      'asurakuArea': instance.asurakuArea,
      'asurakuClosingTime': instance.asurakuClosingTime,
      'asurakuFlag': instance.asurakuFlag,
      'availability': instance.availability,
      'carrier': instance.carrier,
      'catchcopy': instance.catchcopy,
      'creditCardFlag': instance.creditCardFlag,
      'endTime': instance.endTime,
      'genreId': instance.genreId,
      'itemCaption': instance.itemCaption,
      'imageFlag': instance.imageFlag,
      'itemCode': instance.itemCode,
      'itemName': instance.itemName,
      'itemPrice': instance.itemPrice,
      'itemUrl': instance.itemUrl,
      'mediumImageUrls': instance.mediumImageUrls,
      'pointRate': instance.pointRate,
      'pointRateEndTime': instance.pointRateEndTime,
      'pointRateStartTime': instance.pointRateStartTime,
      'postageFlag': instance.postageFlag,
      'rank': instance.rank,
      'reviewAverage': instance.reviewAverage,
      'reviewCount': instance.reviewCount,
      'shipOverseasArea': instance.shipOverseasArea,
      'shipOverseasFlag': instance.shipOverseasFlag,
      'shopAffiliateUrl': instance.shopAffiliateUrl,
      'shopCode': instance.shopCode,
      'shopName': instance.shopName,
      'shopOfTheYearFlag': instance.shopOfTheYearFlag,
      'shopUrl': instance.shopUrl,
      'smallImageUrls': instance.smallImageUrls,
      'startTime': instance.startTime,
      'taxFlag': instance.taxFlag,
    };

MediumImageUrlsSuggestionRakutenDto
    _$MediumImageUrlsSuggestionRakutenDtoFromJson(Map<String, dynamic> json) =>
        MediumImageUrlsSuggestionRakutenDto(
          imageUrl: json['imageUrl'] as String?,
        );

Map<String, dynamic> _$MediumImageUrlsSuggestionRakutenDtoToJson(
        MediumImageUrlsSuggestionRakutenDto instance) =>
    <String, dynamic>{
      'imageUrl': instance.imageUrl,
    };

SmallImageUrlsSuggestionRakutenDto _$SmallImageUrlsSuggestionRakutenDtoFromJson(
        Map<String, dynamic> json) =>
    SmallImageUrlsSuggestionRakutenDto(
      imageUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$SmallImageUrlsSuggestionRakutenDtoToJson(
        SmallImageUrlsSuggestionRakutenDto instance) =>
    <String, dynamic>{
      'imageUrl': instance.imageUrl,
    };
