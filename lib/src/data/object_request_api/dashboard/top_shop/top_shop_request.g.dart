// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'top_shop_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoadItemRequest _$LoadItemRequestFromJson(Map<String, dynamic> json) =>
    LoadItemRequest(
      source: json['source'] as String?,
      codeProduct: json['viewing_product_id'] as String?,
      site: json['site_code'] as String?,
      page: json['page'] as String?,
      size: json['size'] as String?,
      search: json['search'] as String?,
    );

Map<String, dynamic> _$LoadItemRequestToJson(LoadItemRequest instance) =>
    <String, dynamic>{
      'page': instance.page,
      'size': instance.size,
      'site_code': instance.site,
      'source': instance.source,
      'search': instance.search,
      'viewing_product_id': instance.codeProduct,
    };
