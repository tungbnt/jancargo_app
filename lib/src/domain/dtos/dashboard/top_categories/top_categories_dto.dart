import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'top_categories_dto.g.dart';
@JsonSerializable()
class CategoriesDto  {
  const CategoriesDto(  {this.id,this.details, })
      : super();

  @JsonKey(required: true,name: '_id')
  final String? id;

  @JsonKey(required: true, name: 'details')
  final String? details;


  factory CategoriesDto.fromJson(Map<String, dynamic> json) =>
      _$CategoriesDtoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CategoriesDtoToJson(this);
}
@JsonSerializable()
class TopCategoriesDto  {
  const TopCategoriesDto({this.id, this.catId, this.type, this.createdDate, this.deleted, this.isAutoTranslate, this.isPopular, this.productType, this.nameCategoriesDto, this.parentId, this.imageUrl, this.updateDate, this.view,  })
      : super();

  @JsonKey(name: '_id')
  final String? id;
  @JsonKey(name: 'cat_id')
  final String? catId;

  @JsonKey(name: 'type')
  final String? type;
  @JsonKey(name: 'created_date')
  final String? createdDate;

  @JsonKey(name: 'deleted')
  final bool? deleted;
  @JsonKey(name: 'is_auto_translate')
  final bool? isAutoTranslate;
  @JsonKey(name: 'is_popular')
  final bool? isPopular;
  @JsonKey( name: 'product_type')
  final String? productType;
  @JsonKey(name: 'name')
  final NameCategoriesDto? nameCategoriesDto;
  @JsonKey(name: 'parent_id')
  final String? parentId;
  @JsonKey(name: 'image_url')
  final String? imageUrl;
  @JsonKey(name: 'update_date')
  final int? updateDate;
  @JsonKey( name: 'view')
  final int? view;

  factory TopCategoriesDto.fromJson(Map<String, dynamic> json) =>
      _$TopCategoriesDtoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$TopCategoriesDtoToJson(this);
}

@JsonSerializable()
class NameCategoriesDto  {
  const NameCategoriesDto(  {this.ja,this.vn, })
      : super();

  @JsonKey(required: true,name: 'ja')
  final String? ja;

  @JsonKey(required: true, name: 'vi')
  final String? vn;


  factory NameCategoriesDto.fromJson(Map<String, dynamic> json) =>
      _$NameCategoriesDtoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$NameCategoriesDtoToJson(this);
}
