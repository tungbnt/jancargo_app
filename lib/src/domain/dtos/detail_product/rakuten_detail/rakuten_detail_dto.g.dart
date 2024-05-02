// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rakuten_detail_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RakutenDetailDto _$RakutenDetailDtoFromJson(Map<String, dynamic> json) =>
    RakutenDetailDto(
      data: json['data'] == null
          ? null
          : RakutenDetailItemDto.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RakutenDetailDtoToJson(RakutenDetailDto instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

RakutenDetailItemDto _$RakutenDetailItemDtoFromJson(
        Map<String, dynamic> json) =>
    RakutenDetailItemDto(
      code: json['code'] as String?,
      url: json['url'] as String?,
      name: json['name'] as String?,
      price: json['price'] as int?,
      startTime: json['startTime'] as String?,
      endTime: json['endTime'] as String?,
      description: json['description'] as String?,
      catchCopy: json['catchcopy'] as String?,
      availability: json['availability'] as int?,
      taxFlag: json['taxFlag'] as int?,
      pointRate: json['pointRate'] as int?,
      categoryId: json['category_id'] as String?,
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as int).toList(),
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      storeRakuten: json['store'] == null
          ? null
          : StoreRakutenDetailDto.fromJson(
              json['store'] as Map<String, dynamic>),
      ratting: json['ratting'] == null
          ? null
          : RattingRakutenDetailDto.fromJson(
              json['ratting'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RakutenDetailItemDtoToJson(
        RakutenDetailItemDto instance) =>
    <String, dynamic>{
      'code': instance.code,
      'url': instance.url,
      'name': instance.name,
      'price': instance.price,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'description': instance.description,
      'catchcopy': instance.catchCopy,
      'availability': instance.availability,
      'taxFlag': instance.taxFlag,
      'pointRate': instance.pointRate,
      'category_id': instance.categoryId,
      'tags': instance.tags,
      'images': instance.images,
      'store': instance.storeRakuten,
      'ratting': instance.ratting,
    };

StoreRakutenDetailDto _$StoreRakutenDetailDtoFromJson(
        Map<String, dynamic> json) =>
    StoreRakutenDetailDto(
      code: json['code'] as String?,
      name: json['name'] as String?,
      url: json['url'] as String?,
    );

Map<String, dynamic> _$StoreRakutenDetailDtoToJson(
        StoreRakutenDetailDto instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'url': instance.url,
    };

RattingRakutenDetailDto _$RattingRakutenDetailDtoFromJson(
        Map<String, dynamic> json) =>
    RattingRakutenDetailDto(
      count: json['count'] as int?,
      total: (json['total'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$RattingRakutenDetailDtoToJson(
        RattingRakutenDetailDto instance) =>
    <String, dynamic>{
      'count': instance.count,
      'total': instance.total,
    };
