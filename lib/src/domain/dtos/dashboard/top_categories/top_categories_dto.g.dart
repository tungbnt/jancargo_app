// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'top_categories_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoriesDto _$CategoriesDtoFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['_id', 'details'],
  );
  return CategoriesDto(
    id: json['_id'] as String?,
    details: json['details'] as String?,
  );
}

Map<String, dynamic> _$CategoriesDtoToJson(CategoriesDto instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'details': instance.details,
    };

TopCategoriesDto _$TopCategoriesDtoFromJson(Map<String, dynamic> json) =>
    TopCategoriesDto(
      id: json['_id'] as String?,
      catId: json['cat_id'] as String?,
      type: json['type'] as String?,
      createdDate: json['created_date'] as String?,
      deleted: json['deleted'] as bool?,
      isAutoTranslate: json['is_auto_translate'] as bool?,
      isPopular: json['is_popular'] as bool?,
      productType: json['product_type'] as String?,
      nameCategoriesDto: json['name'] == null
          ? null
          : NameCategoriesDto.fromJson(json['name'] as Map<String, dynamic>),
      parentId: json['parent_id'] as String?,
      imageUrl: json['image_url'] as String?,
      updateDate: json['update_date'] as int?,
      view: json['view'] as int?,
    );

Map<String, dynamic> _$TopCategoriesDtoToJson(TopCategoriesDto instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'cat_id': instance.catId,
      'type': instance.type,
      'created_date': instance.createdDate,
      'deleted': instance.deleted,
      'is_auto_translate': instance.isAutoTranslate,
      'is_popular': instance.isPopular,
      'product_type': instance.productType,
      'name': instance.nameCategoriesDto,
      'parent_id': instance.parentId,
      'image_url': instance.imageUrl,
      'update_date': instance.updateDate,
      'view': instance.view,
    };

NameCategoriesDto _$NameCategoriesDtoFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['ja', 'vi'],
  );
  return NameCategoriesDto(
    ja: json['ja'] as String?,
    vn: json['vi'] as String?,
  );
}

Map<String, dynamic> _$NameCategoriesDtoToJson(NameCategoriesDto instance) =>
    <String, dynamic>{
      'ja': instance.ja,
      'vi': instance.vn,
    };
