import 'package:json_annotation/json_annotation.dart';

part 'search_popular_dto.g.dart';

@JsonSerializable()
class SearchPopularDto {
  const SearchPopularDto({
    this.data,
  }) : super();

  @JsonKey(name: 'results')
  final List<SearchPopularItemDto>? data;


  factory SearchPopularDto.fromJson(Map<String, dynamic> json) =>
      _$SearchPopularDtoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SearchPopularDtoToJson(this);
}
@JsonSerializable()
class SearchPopularItemDto {
  const SearchPopularItemDto( {
    this.keyword, this.name, this.number, this.role, this.updatedDate, this.id, this.isAutoTranslation, this.numberOdn,  this.iid,  this.createdDate, this.slug, this.v, this.typeCode,  this.home, this.primary, this.main, this.status,
  }) : super();

  @JsonKey(name: '_id')
  final String? iid;
  @JsonKey(name: 'type_code')
  final String? typeCode;
  @JsonKey(name: 'keyword')
  final String? keyword;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'number')
  final int? number;
  @JsonKey(name: 'home')
  final bool? home;
  @JsonKey(name: 'primary')
  final bool? primary;
  @JsonKey(name: 'main')
  final bool? main;
  @JsonKey(name: 'status')
  final bool? status;
  @JsonKey(name: 'role')
  final String? role;
  @JsonKey(name: 'created_date')
  final String? createdDate;
  @JsonKey(name: 'slug')
  final String? slug;
  @JsonKey(name: '__v')
  final int? v;
  @JsonKey(name: 'updated_date')
  final String? updatedDate;
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'is_auto_translation')
  final bool? isAutoTranslation;
  @JsonKey(name: 'number_odn')
  final int? numberOdn;

  factory SearchPopularItemDto.fromJson(Map<String, dynamic> json) =>
      _$SearchPopularItemDtoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SearchPopularItemDtoToJson(this);
}