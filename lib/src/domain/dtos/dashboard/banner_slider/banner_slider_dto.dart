import 'package:json_annotation/json_annotation.dart';

part 'banner_slider_dto.g.dart';
@JsonSerializable()
class BannerSliderDto  {
  const BannerSliderDto( {this.results, this.pagination,})
      : super();

  @JsonKey(required: true,name: 'results')
  final List<BannerDto>? results;

  @JsonKey(required: true, name: 'pagination')
  final PaginationDto? pagination;

  factory BannerSliderDto.fromJson(Map<String, dynamic> json) =>
      _$BannerSliderDtoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$BannerSliderDtoToJson(this);
}

@JsonSerializable()
class BannerDto  {
  const BannerDto( {this.id, this.type, this.name, this.typePage, this.btnType, this.url, this.image, this.status, this.deleted,this.v, this.idM,this.lastViewed })
      : super();

  @JsonKey(required: true,name: '_id')
  final String? id;

  @JsonKey(required: true, name: 'type')
  final String? type;
  @JsonKey( name: 'name')
  final String? name;

  @JsonKey( name: 'type_page')
  final String? typePage;
  @JsonKey( name: 'btn_type')
  final String? btnType;
  @JsonKey( name: 'url')
  final String? url;
  @JsonKey(name: 'image')
  final String? image;
  @JsonKey(name: 'status')
  final bool? status;
  @JsonKey( name: 'deleted')
  final bool? deleted;
  @JsonKey( name: 'created_date')
  final String? lastViewed;
  @JsonKey(name: '__v')
  final int? v;
  @JsonKey(name: 'id')
  final String? idM;


  factory BannerDto.fromJson(Map<String, dynamic> json) =>
      _$BannerDtoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$BannerDtoToJson(this);
}


@JsonSerializable()
class PaginationDto  {
  const PaginationDto( {this.size, this.page, this.total,})
      : super();

  @JsonKey(name: 'size')
  final int? size;
  @JsonKey(name: 'page')
  final int? page;
  @JsonKey( name: 'total')
  final int? total;

  factory PaginationDto.fromJson(Map<String, dynamic> json) =>
      _$PaginationDtoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PaginationDtoToJson(this);
}
