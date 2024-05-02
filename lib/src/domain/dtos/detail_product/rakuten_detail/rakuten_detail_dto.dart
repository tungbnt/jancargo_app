import 'package:json_annotation/json_annotation.dart';

part 'rakuten_detail_dto.g.dart';

@JsonSerializable()
class RakutenDetailDto  {
  const RakutenDetailDto({this.data})
      : super();

  @JsonKey(name: 'data')
  final RakutenDetailItemDto? data;



  factory RakutenDetailDto.fromJson(Map<String, dynamic> json) =>
      _$RakutenDetailDtoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$RakutenDetailDtoToJson(this);
}
@JsonSerializable()
class RakutenDetailItemDto  {
  const RakutenDetailItemDto({this.code, this.url, this.name, this.price, this.startTime, this.endTime, this.description, this.catchCopy, this.availability, this.taxFlag, this.pointRate, this.categoryId, this.tags, this.images, this.storeRakuten, this.ratting, })
      : super();

  @JsonKey(name: 'code')
  final String? code;
  @JsonKey(name: 'url')
  final String? url;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'price')
  final int? price;
  @JsonKey(name: 'startTime')
  final String? startTime;
  @JsonKey(name: 'endTime')
  final String? endTime;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'catchcopy')
  final String? catchCopy;
  @JsonKey(name: 'availability')
  final int? availability;
  @JsonKey(name: 'taxFlag')
  final int? taxFlag;
  @JsonKey(name: 'pointRate')
  final int? pointRate;
  @JsonKey(name: 'category_id')
  final String? categoryId;
  @JsonKey(name: 'tags')
  final List<int>? tags;
  @JsonKey(name: 'images')
  final List<String>? images;
  @JsonKey(name: 'store')
  final StoreRakutenDetailDto? storeRakuten;
  @JsonKey(name: 'ratting')
  final RattingRakutenDetailDto? ratting;




  factory RakutenDetailItemDto.fromJson(Map<String, dynamic> json) =>
      _$RakutenDetailItemDtoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$RakutenDetailItemDtoToJson(this);
}
@JsonSerializable()
class StoreRakutenDetailDto  {
  const StoreRakutenDetailDto( {this.code, this.name, this.url,})
      : super();

  @JsonKey(name: 'code')
  final String? code;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'url')
  final String? url;



  factory StoreRakutenDetailDto.fromJson(Map<String, dynamic> json) =>
      _$StoreRakutenDetailDtoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$StoreRakutenDetailDtoToJson(this);
}
@JsonSerializable()
class RattingRakutenDetailDto  {
  const RattingRakutenDetailDto( {this.count, this.total,})
      : super();

  @JsonKey(name: 'count')
  final int? count;
  @JsonKey(name: 'total')
  final double? total;




  factory RattingRakutenDetailDto.fromJson(Map<String, dynamic> json) =>
      _$RattingRakutenDetailDtoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$RattingRakutenDetailDtoToJson(this);
}