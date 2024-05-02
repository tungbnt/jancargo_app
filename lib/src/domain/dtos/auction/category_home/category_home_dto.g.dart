// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_home_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryHomeDto _$CategoryHomeDtoFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['data'],
  );
  return CategoryHomeDto(
    data: (json['data'] as List<dynamic>?)
        ?.map((e) => CategoryHomeItemDto.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$CategoryHomeDtoToJson(CategoryHomeDto instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

CategoryHomeItemDto _$CategoryHomeItemDtoFromJson(Map<String, dynamic> json) =>
    CategoryHomeItemDto(
      createdDate: json['created_date'] as String?,
      id: json['id'] as String?,
      iid: json['_id'] as String?,
      lang: json['lang'] as String?,
      typeCode: json['type_code'] as String?,
      categoryId: json['category_id'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      home: json['home'] as bool?,
      primary: json['primary'] as bool?,
      main: json['main'] as bool?,
      status: json['status'] as bool?,
      position: json['position'] as int?,
      parentId: json['parent_id'],
      slug: json['slug'] as String?,
      root: json['root'] as bool?,
      deleted: json['deleted'] as bool?,
      v: json['__v'] as int?,
      image: json['image'] as String?,
      updatedDate: json['updated_date'] as String?,
      icon: json['icon'] as String?,
    );

Map<String, dynamic> _$CategoryHomeItemDtoToJson(
        CategoryHomeItemDto instance) =>
    <String, dynamic>{
      '_id': instance.iid,
      'lang': instance.lang,
      'type_code': instance.typeCode,
      'category_id': instance.categoryId,
      'name': instance.name,
      'description': instance.description,
      'home': instance.home,
      'primary': instance.primary,
      'main': instance.main,
      'status': instance.status,
      'position': instance.position,
      'parent_id': instance.parentId,
      'created_date': instance.createdDate,
      'slug': instance.slug,
      'root': instance.root,
      'deleted': instance.deleted,
      '__v': instance.v,
      'image': instance.image,
      'updated_date': instance.updatedDate,
      'icon': instance.icon,
      'id': instance.id,
    };
