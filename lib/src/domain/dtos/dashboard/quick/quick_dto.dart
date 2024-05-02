import 'package:json_annotation/json_annotation.dart';

part 'quick_dto.g.dart';
@JsonSerializable()
class QuickDto  {
  const QuickDto({this.pagination,  this.results,})
      : super();

  @JsonKey(required: true,name: 'results')
  final List<QuickTypeDto>? results;
  @JsonKey(required: true,name: 'pagination')
  final PaginationDto? pagination;

  factory QuickDto.fromJson(Map<String, dynamic> json) =>
      _$QuickDtoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$QuickDtoToJson(this);
}

@JsonSerializable()
class QuickTypeDto  {
  const QuickTypeDto( {this.createdDate,this.id, this.url, this.slug, this.type, this.name, this.description, this.position, this.status, this.deleted, this.icon, this.updateDate, this.idM, })
      : super();

  @JsonKey(name: '_id')
  final String? id;

  @JsonKey(name: 'url')
  final String? url;
  @JsonKey( name: 'slug')
  final String? slug;

  @JsonKey( name: 'type')
  final String? type;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey( name: 'description')
  final String? description;
  @JsonKey(name: 'position')
  final int? position;
  @JsonKey( name: 'status')
  final bool? status;
  @JsonKey(name: 'deleted')
  final bool? deleted;
  @JsonKey( name: 'created_date')
  final String? createdDate;
  @JsonKey( name: 'icon')
  final String? icon;
  @JsonKey( name: 'update_date')
  final String? updateDate;
  @JsonKey(name: 'id')
  final String? idM;


  factory QuickTypeDto.fromJson(Map<String, dynamic> json) =>
      _$QuickTypeDtoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$QuickTypeDtoToJson(this);
}


@JsonSerializable()
class PaginationDto  {
  const PaginationDto( {this.size, this.page, this.total,})
      : super();

  @JsonKey(required: true, name: 'size')
  final int? size;
  @JsonKey(required: true, name: 'page')
  final int? page;
  @JsonKey(required: true, name: 'total')
  final int? total;

  factory PaginationDto.fromJson(Map<String, dynamic> json) =>
      _$PaginationDtoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PaginationDtoToJson(this);
}
