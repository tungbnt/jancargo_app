import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

part 'location_user_dto.g.dart';

@JsonSerializable()
class ProvinceDto {
  const ProvinceDto({this.data,}) : super();

  @JsonKey(name: 'data')
  final List<ProvincesDto>? data;



  factory ProvinceDto.fromJson(Map<String, dynamic> json) =>
      _$ProvinceDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ProvinceDtoToJson(this);
}
@JsonSerializable()
class ProvincesDto {
  const ProvincesDto({this.iid, this.id, this.name, this.type, this.countryId,}) : super();

  @JsonKey(name: '_id')
  final String? iid;
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'type')
  final String? type;
  @JsonKey(name: 'countryId')
  final int? countryId;

  factory ProvincesDto.fromJson(Map<String, dynamic> json) =>
      _$ProvincesDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ProvincesDtoToJson(this);
}

@JsonSerializable()
class DistrictDto {
  const DistrictDto({this.data,}) : super();

  @JsonKey(name: 'data')
  final List<DistrictsDto>? data;



  factory DistrictDto.fromJson(Map<String, dynamic> json) =>
      _$DistrictDtoFromJson(json);

  Map<String, dynamic> toJson() => _$DistrictDtoToJson(this);
}
@JsonSerializable()
class DistrictsDto {
  const DistrictsDto({this.iid, this.id, this.name, this.type, this.provinceId,}) : super();

  @JsonKey(name: '_id')
  final String? iid;
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'type')
  final String? type;
  @JsonKey(name: 'provinceId')
  final int? provinceId;

  factory DistrictsDto.fromJson(Map<String, dynamic> json) =>
      _$DistrictsDtoFromJson(json);

  Map<String, dynamic> toJson() => _$DistrictsDtoToJson(this);
}

@JsonSerializable()
class WardDto {
  const WardDto({this.data,}) : super();

  @JsonKey(name: 'data')
  final List<WardsDto>? data;



  factory WardDto.fromJson(Map<String, dynamic> json) =>
      _$WardDtoFromJson(json);

  Map<String, dynamic> toJson() => _$WardDtoToJson(this);
}
@JsonSerializable()
class WardsDto {
  const WardsDto({this.iid, this.id, this.name, this.type, this.districtId,}) : super();

  @JsonKey(name: '_id')
  final String? iid;
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'type')
  final String? type;
  @JsonKey(name: 'districtId')
  final int? districtId;

  factory WardsDto.fromJson(Map<String, dynamic> json) =>
      _$WardsDtoFromJson(json);

  Map<String, dynamic> toJson() => _$WardsDtoToJson(this);
}