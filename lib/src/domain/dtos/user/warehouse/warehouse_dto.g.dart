// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'warehouse_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WareHouseDto _$WareHouseDtoFromJson(Map<String, dynamic> json) => WareHouseDto(
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => WareHouseDataDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      paginationDto: json['pagination'] == null
          ? null
          : PaginationDto.fromJson(json['pagination'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WareHouseDtoToJson(WareHouseDto instance) =>
    <String, dynamic>{
      'results': instance.results,
      'pagination': instance.paginationDto,
    };

WareHouseDataDto _$WareHouseDataDtoFromJson(Map<String, dynamic> json) =>
    WareHouseDataDto(
      id_: json['_id'] as String?,
      station: json['station'] as String?,
      code: json['code'] as String?,
      name: json['name'] as String?,
      route: json['route'] as String?,
      description: json['description'] as String?,
      transMode: json['trans_mode'] as String?,
      location: json['location'] as String?,
      status: json['status'] as bool?,
      deleted: json['deleted'] as bool?,
      createdDate: json['created_date'] as String?,
      v: json['__v'] as int?,
      shipMode: (json['ship_mode'] as List<dynamic>?)
          ?.map((e) => ShipModeDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      id: json['id'] as String?,
      trans: json['trans'] as String?,
    );

Map<String, dynamic> _$WareHouseDataDtoToJson(WareHouseDataDto instance) =>
    <String, dynamic>{
      '_id': instance.id_,
      'station': instance.station,
      'code': instance.code,
      'name': instance.name,
      'route': instance.route,
      'description': instance.description,
      'trans_mode': instance.transMode,
      'location': instance.location,
      'status': instance.status,
      'deleted': instance.deleted,
      'created_date': instance.createdDate,
      '__v': instance.v,
      'ship_mode': instance.shipMode,
      'id': instance.id,
      'trans': instance.trans,
    };

ShipModeDto _$ShipModeDtoFromJson(Map<String, dynamic> json) => ShipModeDto(
      selectedShip: ShipModeDto._selectedFromJson(json['isCheck'] as bool?),
      priceEst: json['price_est'] as String?,
      value: json['value'] as String?,
      label: json['label'] as String?,
      description: json['description'] as String?,
      active: json['active'] as bool?,
      defaultt: json['default'] as bool?,
      shortLabel: json['short_label'] as String?,
      timeEst: json['time_est'] == null
          ? null
          : TimeEstDto.fromJson(json['time_est'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ShipModeDtoToJson(ShipModeDto instance) =>
    <String, dynamic>{
      'value': instance.value,
      'label': instance.label,
      'description': instance.description,
      'active': instance.active,
      'default': instance.defaultt,
      'short_label': instance.shortLabel,
      'time_est': instance.timeEst,
      'price_est': instance.priceEst,
      'isCheck': ShipModeDto._selectedToJson(instance.selectedShip),
    };

TimeEstDto _$TimeEstDtoFromJson(Map<String, dynamic> json) => TimeEstDto(
      min: json['min'] as int?,
      max: json['max'] as int?,
    );

Map<String, dynamic> _$TimeEstDtoToJson(TimeEstDto instance) =>
    <String, dynamic>{
      'min': instance.min,
      'max': instance.max,
    };

PaginationDto _$PaginationDtoFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['size', 'page', 'total'],
  );
  return PaginationDto(
    size: json['size'] as int?,
    page: json['page'] as int?,
    total: json['total'] as int?,
  );
}

Map<String, dynamic> _$PaginationDtoToJson(PaginationDto instance) =>
    <String, dynamic>{
      'size': instance.size,
      'page': instance.page,
      'total': instance.total,
    };
