// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_seller_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchSellerRequest _$SearchSellerRequestFromJson(Map<String, dynamic> json) =>
    SearchSellerRequest(
      typeCode: json['type_code'] as String?,
      query: json['query'] as String?,
      size: json['size'] as String?,
      page: json['page'] as String?,
    );

Map<String, dynamic> _$SearchSellerRequestToJson(
        SearchSellerRequest instance) =>
    <String, dynamic>{
      'query': instance.query,
      'size': instance.size,
      'page': instance.page,
      'type_code': instance.typeCode,
    };

SuggestionRequest _$SuggestionRequestFromJson(Map<String, dynamic> json) =>
    SuggestionRequest(
      sellerId: json['seller_id'] as String?,
      typeCode: json['type_code'] as String?,
      size: json['size'] as String?,
      sort: json['sort'] as String?,
    );

Map<String, dynamic> _$SuggestionRequestToJson(SuggestionRequest instance) =>
    <String, dynamic>{
      'size': instance.size,
      'sort': instance.sort,
      'type_code': instance.typeCode,
      'seller_id': instance.sellerId,
    };
