import 'package:json_annotation/json_annotation.dart';

part 'recently_viewed_dto.g.dart';
@JsonSerializable()
class RecentlyDto  {
  const RecentlyDto( {this.result, this.pagination,})
      : super();

  @JsonKey(required: true,name: 'results')
  final List<RecentlyViewedDto>? result;

  @JsonKey(required: true, name: 'pagination')
  final PaginationDto? pagination;

  factory RecentlyDto.fromJson(Map<String, dynamic> json) =>
      _$RecentlyDtoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$RecentlyDtoToJson(this);
}

@JsonSerializable()
class RecentlyViewedDto  {
  const RecentlyViewedDto({this.v, this.idM, this.price, this.images, this.id, this.userId, this.productId, this.productName, this.productUrl, this.currencyUnit, this.source, this.createdBy, this.createdDate, this.lastViewed })
      : super();

  @JsonKey(name: '_id')
  final String? id;

  @JsonKey(name: 'user_id')
  final String? userId;
  @JsonKey( name: 'product_id')
  final String? productId;

  @JsonKey( name: 'product_name')
  final String? productName;
  @JsonKey(name: 'product_url')
  final String? productUrl;
  @JsonKey( name: 'currency_unit')
  final String? currencyUnit;
  @JsonKey(name: 'source')
  final String? source;
  @JsonKey( name: 'created_by')
  final String? createdBy;
  @JsonKey( name: 'created_date')
  final String? createdDate;
  @JsonKey( name: 'last_viewed')
  final String? lastViewed;
  @JsonKey( name: '__v')
  final int? v;
  @JsonKey(name: 'id')
  final String? idM;
  @JsonKey( name: 'price')
  final int? price;
  @JsonKey( name: 'images')
  final List<String>? images;

  factory RecentlyViewedDto.fromJson(Map<String, dynamic> json) =>
      _$RecentlyViewedDtoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$RecentlyViewedDtoToJson(this);
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
