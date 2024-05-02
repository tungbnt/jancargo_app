// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_suggestion_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchSuggestionDto _$SearchSuggestionDtoFromJson(Map<String, dynamic> json) =>
    SearchSuggestionDto(
      data: (json['results'] as List<dynamic>?)
          ?.map((e) =>
              SearchSuggestionItemDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SearchSuggestionDtoToJson(
        SearchSuggestionDto instance) =>
    <String, dynamic>{
      'results': instance.data,
    };

SearchSuggestionItemDto _$SearchSuggestionItemDtoFromJson(
        Map<String, dynamic> json) =>
    SearchSuggestionItemDto(
      iid: json['_id'] as String?,
      position: json['position'] as int?,
      parentId: json['parent_id'] as String?,
      root: json['root'] as bool?,
      deleted: json['deleted'] as bool?,
      createdDate: json['created_date'] as String?,
      slug: json['slug'] as String?,
      v: json['__v'] as int?,
      image: json['image'] as String?,
      updatedDate: json['updated_date'] as String?,
      parent: json['parent'] as String?,
      id: json['id'] as String?,
      lang: json['lang'] as String?,
      typeCode: json['type_code'] as String?,
      categoryId: json['category_id'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      metaTitle: json['meta_title'] as String?,
      metaDescription: json['meta_description'] as String?,
      metaKeywords: json['meta_keywords'] as String?,
      home: json['home'] as bool?,
      primary: json['primary'] as bool?,
      main: json['main'] as bool?,
      status: json['status'] as bool?,
    );

Map<String, dynamic> _$SearchSuggestionItemDtoToJson(
        SearchSuggestionItemDto instance) =>
    <String, dynamic>{
      '_id': instance.iid,
      'lang': instance.lang,
      'type_code': instance.typeCode,
      'category_id': instance.categoryId,
      'name': instance.name,
      'description': instance.description,
      'meta_title': instance.metaTitle,
      'meta_description': instance.metaDescription,
      'meta_keywords': instance.metaKeywords,
      'home': instance.home,
      'primary': instance.primary,
      'main': instance.main,
      'status': instance.status,
      'position': instance.position,
      'parent_id': instance.parentId,
      'root': instance.root,
      'deleted': instance.deleted,
      'created_date': instance.createdDate,
      'slug': instance.slug,
      '__v': instance.v,
      'image': instance.image,
      'updated_date': instance.updatedDate,
      'id': instance.id,
      'parent': instance.parent,
    };
