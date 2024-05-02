// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_mercari_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchMercariDto _$SearchMercariDtoFromJson(Map<String, dynamic> json) =>
    SearchMercariDto(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => MercarisDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: json['meta'] == null
          ? null
          : MetaDto.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SearchMercariDtoToJson(SearchMercariDto instance) =>
    <String, dynamic>{
      'data': instance.data,
      'meta': instance.meta,
    };

MercarisDto _$MercarisDtoFromJson(Map<String, dynamic> json) => MercarisDto(
      isItemSavedCart: json['isItemSavedCart'] as bool?,
      price: json['price'] as int?,
      numComments: json['num_comments'] as int?,
      numLikes: json['num_likes'] as int?,
      pagerId: json['pager_id'] as int?,
      status: json['status'] as String?,
      url: json['url'] as String?,
      id: json['id'] as String?,
      code: json['code'] as String?,
      image: json['image'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$MercarisDtoToJson(MercarisDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'image': instance.image,
      'isItemSavedCart': instance.isItemSavedCart,
      'name': instance.name,
      'price': instance.price,
      'num_comments': instance.numComments,
      'num_likes': instance.numLikes,
      'pager_id': instance.pagerId,
      'status': instance.status,
      'url': instance.url,
    };

MetaDto _$MetaDtoFromJson(Map<String, dynamic> json) => MetaDto(
      hasNextPage: json['hasNextPage'] as bool?,
      endCursor: json['endCursor'] as int?,
    );

Map<String, dynamic> _$MetaDtoToJson(MetaDto instance) => <String, dynamic>{
      'hasNextPage': instance.hasNextPage,
      'endCursor': instance.endCursor,
    };
