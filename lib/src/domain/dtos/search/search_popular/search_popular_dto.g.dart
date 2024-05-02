// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_popular_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchPopularDto _$SearchPopularDtoFromJson(Map<String, dynamic> json) =>
    SearchPopularDto(
      data: (json['results'] as List<dynamic>?)
          ?.map((e) => SearchPopularItemDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SearchPopularDtoToJson(SearchPopularDto instance) =>
    <String, dynamic>{
      'results': instance.data,
    };

SearchPopularItemDto _$SearchPopularItemDtoFromJson(
        Map<String, dynamic> json) =>
    SearchPopularItemDto(
      keyword: json['keyword'] as String?,
      name: json['name'] as String?,
      number: json['number'] as int?,
      role: json['role'] as String?,
      updatedDate: json['updated_date'] as String?,
      id: json['id'] as String?,
      isAutoTranslation: json['is_auto_translation'] as bool?,
      numberOdn: json['number_odn'] as int?,
      iid: json['_id'] as String?,
      createdDate: json['created_date'] as String?,
      slug: json['slug'] as String?,
      v: json['__v'] as int?,
      typeCode: json['type_code'] as String?,
      home: json['home'] as bool?,
      primary: json['primary'] as bool?,
      main: json['main'] as bool?,
      status: json['status'] as bool?,
    );

Map<String, dynamic> _$SearchPopularItemDtoToJson(
        SearchPopularItemDto instance) =>
    <String, dynamic>{
      '_id': instance.iid,
      'type_code': instance.typeCode,
      'keyword': instance.keyword,
      'name': instance.name,
      'number': instance.number,
      'home': instance.home,
      'primary': instance.primary,
      'main': instance.main,
      'status': instance.status,
      'role': instance.role,
      'created_date': instance.createdDate,
      'slug': instance.slug,
      '__v': instance.v,
      'updated_date': instance.updatedDate,
      'id': instance.id,
      'is_auto_translation': instance.isAutoTranslation,
      'number_odn': instance.numberOdn,
    };
