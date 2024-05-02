// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProvinceDto _$ProvinceDtoFromJson(Map<String, dynamic> json) => ProvinceDto(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ProvincesDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProvinceDtoToJson(ProvinceDto instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

ProvincesDto _$ProvincesDtoFromJson(Map<String, dynamic> json) => ProvincesDto(
      iid: json['_id'] as String?,
      id: json['id'] as int?,
      name: json['name'] as String?,
      type: json['type'] as String?,
      countryId: json['countryId'] as int?,
    );

Map<String, dynamic> _$ProvincesDtoToJson(ProvincesDto instance) =>
    <String, dynamic>{
      '_id': instance.iid,
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'countryId': instance.countryId,
    };

DistrictDto _$DistrictDtoFromJson(Map<String, dynamic> json) => DistrictDto(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => DistrictsDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DistrictDtoToJson(DistrictDto instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

DistrictsDto _$DistrictsDtoFromJson(Map<String, dynamic> json) => DistrictsDto(
      iid: json['_id'] as String?,
      id: json['id'] as int?,
      name: json['name'] as String?,
      type: json['type'] as String?,
      provinceId: json['provinceId'] as int?,
    );

Map<String, dynamic> _$DistrictsDtoToJson(DistrictsDto instance) =>
    <String, dynamic>{
      '_id': instance.iid,
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'provinceId': instance.provinceId,
    };

WardDto _$WardDtoFromJson(Map<String, dynamic> json) => WardDto(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => WardsDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WardDtoToJson(WardDto instance) => <String, dynamic>{
      'data': instance.data,
    };

WardsDto _$WardsDtoFromJson(Map<String, dynamic> json) => WardsDto(
      iid: json['_id'] as String?,
      id: json['id'] as int?,
      name: json['name'] as String?,
      type: json['type'] as String?,
      districtId: json['districtId'] as int?,
    );

Map<String, dynamic> _$WardsDtoToJson(WardsDto instance) => <String, dynamic>{
      '_id': instance.iid,
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'districtId': instance.districtId,
    };
