import 'package:json_annotation/json_annotation.dart';

part 'category_home_dto.g.dart';

@JsonSerializable()
class CategoryHomeDto {
  const CategoryHomeDto({
    this.data,
  }) : super();

  @JsonKey(required: true, name: 'data')
  final List<CategoryHomeItemDto>? data;

  factory CategoryHomeDto.fromJson(Map<String, dynamic> json) =>
      _$CategoryHomeDtoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CategoryHomeDtoToJson(this);
}

@JsonSerializable()
class CategoryHomeItemDto {
  const CategoryHomeItemDto({
    this.createdDate,
    this.id,
    this.iid,
    this.lang,
    this.typeCode,
    this.categoryId,
    this.name,
    this.description,
    this.home,
    this.primary,
    this.main,
    this.status,
    this.position,
    this.parentId,
    this.slug,
    this.root,
    this.deleted,
    this.v,
    this.image,
    this.updatedDate,
    this.icon,
  }) : super();

  @JsonKey(name: '_id')
  final String? iid;
  @JsonKey(name: 'lang')
  final String? lang;
  @JsonKey(name: 'type_code')
  final String? typeCode;
  @JsonKey(name: 'category_id')
  final String? categoryId;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'home')
  final bool? home;
  @JsonKey(name: 'primary')
  final bool? primary;
  @JsonKey(name: 'main')
  final bool? main;
  @JsonKey(name: 'status')
  final bool? status;
  @JsonKey(name: 'position')
  final int? position;
  @JsonKey(name: 'parent_id')
  final dynamic parentId;
  @JsonKey(name: 'created_date')
  final String? createdDate;
  @JsonKey(name: 'slug')
  final String? slug;
  @JsonKey(name: 'root')
  final bool? root;
  @JsonKey(name: 'deleted')
  final bool? deleted;
  @JsonKey(name: '__v')
  final int? v;
  @JsonKey(name: 'image')
  final String? image;
  @JsonKey(name: 'updated_date')
  final String? updatedDate;
  @JsonKey(name: 'icon')
  final String? icon;
  @JsonKey(name: 'id')
  final String? id;

  factory CategoryHomeItemDto.fromJson(Map<String, dynamic> json) =>
      _$CategoryHomeItemDtoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CategoryHomeItemDtoToJson(this);
}
