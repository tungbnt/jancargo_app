import 'package:json_annotation/json_annotation.dart';

part 'search_suggestion_dto.g.dart';

@JsonSerializable()
class SearchSuggestionDto {
  const SearchSuggestionDto({
    this.data,
  }) : super();

  @JsonKey(name: 'results')
  final List<SearchSuggestionItemDto>? data;


  factory SearchSuggestionDto.fromJson(Map<String, dynamic> json) =>
      _$SearchSuggestionDtoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SearchSuggestionDtoToJson(this);
}
@JsonSerializable()
class SearchSuggestionItemDto {
  const SearchSuggestionItemDto( {
    this.iid, this.position, this.parentId, this.root, this.deleted, this.createdDate, this.slug, this.v, this.image, this.updatedDate, this.parent, this.id, this.lang, this.typeCode, this.categoryId, this.name, this.description, this.metaTitle, this.metaDescription, this.metaKeywords, this.home, this.primary, this.main, this.status,
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
  @JsonKey(name: 'meta_title')
  final String? metaTitle;
  @JsonKey(name: 'meta_description')
  final String? metaDescription;
  @JsonKey(name: 'meta_keywords')
  final String? metaKeywords;
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
  final String? parentId;
  @JsonKey(name: 'root')
  final bool? root;
  @JsonKey(name: 'deleted')
  final bool? deleted;
  @JsonKey(name: 'created_date')
  final String? createdDate;
  @JsonKey(name: 'slug')
  final String? slug;
  @JsonKey(name: '__v')
  final int? v;
  @JsonKey(name: 'image')
  final String? image;
  @JsonKey(name: 'updated_date')
  final String? updatedDate;
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'parent')
  final String? parent;


  factory SearchSuggestionItemDto.fromJson(Map<String, dynamic> json) =>
      _$SearchSuggestionItemDtoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SearchSuggestionItemDtoToJson(this);
}