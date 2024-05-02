// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_extras_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceExtrasDto _$ServiceExtrasDtoFromJson(Map<String, dynamic> json) =>
    ServiceExtrasDto(
      data: (json['data'] as List<dynamic>?)
          ?.map(
              (e) => ItemsServiceExtrasDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ServiceExtrasDtoToJson(ServiceExtrasDto instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

ItemsServiceExtrasDto _$ItemsServiceExtrasDtoFromJson(
        Map<String, dynamic> json) =>
    ItemsServiceExtrasDto(
      json['_id'] as String?,
      json['station'] as String?,
      json['code'] as String?,
      json['name'] as String?,
      json['description'] as String?,
      json['route_code'] as String?,
      json['price'] as int?,
      json['unit'] as String?,
      json['mode'] as String?,
      (json['child_code'] as List<dynamic>?)?.map((e) => e as String).toList(),
      json['show'] as bool?,
      json['groups'] as bool?,
      json['status'] as bool?,
      json['primary'] as bool?,
      json['deleted'] as bool?,
      json['position'] as int?,
      json['created_by'] as String?,
      json['created_date'] as String?,
      json['__v'] as int?,
      json['updated_by'] as String?,
      json['updated_date'] as String?,
      json['id'] as String?,
      json['mode_name'] as String?,
      json['unit_name'] as String?,
      (json['childrens'] as List<dynamic>?)
          ?.map((e) =>
              ChildrenItemsServiceExtrasDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      ItemsServiceExtrasDto._selectedServiceFromJson(
          json['selectedService'] as bool?),
    );

Map<String, dynamic> _$ItemsServiceExtrasDtoToJson(
        ItemsServiceExtrasDto instance) =>
    <String, dynamic>{
      '_id': instance.iid,
      'station': instance.station,
      'code': instance.code,
      'name': instance.name,
      'description': instance.description,
      'route_code': instance.routeCode,
      'price': instance.price,
      'unit': instance.unit,
      'mode': instance.mode,
      'child_code': instance.childCode,
      'show': instance.show,
      'groups': instance.groups,
      'status': instance.status,
      'primary': instance.primary,
      'deleted': instance.deleted,
      'position': instance.position,
      'created_by': instance.createdBy,
      'created_date': instance.createdDate,
      '__v': instance.v,
      'updated_by': instance.updatedBy,
      'updated_date': instance.updatedDate,
      'id': instance.id,
      'mode_name': instance.modeName,
      'unit_name': instance.unitName,
      'childrens': instance.childrens,
      'selectedService': ItemsServiceExtrasDto._selectedServiceToJson(
          instance.selectedService),
    };

ChildrenItemsServiceExtrasDto _$ChildrenItemsServiceExtrasDtoFromJson(
        Map<String, dynamic> json) =>
    ChildrenItemsServiceExtrasDto(
      json['_id'] as String?,
      json['station'] as String?,
      json['code'] as String?,
      json['name'] as String?,
      json['description'] as String?,
      json['route_code'] as String?,
      json['price'] as int?,
      json['unit'] as String?,
      json['mode'] as String?,
      json['child_code'] as List<dynamic>?,
      json['show'] as bool?,
      json['groups'] as bool?,
      json['status'] as bool?,
      json['primary'] as bool?,
      json['deleted'] as bool?,
      json['position'] as int?,
      json['created_by'] as String?,
      json['created_date'] as String?,
      json['__v'] as int?,
      json['updated_by'] as String?,
      json['updated_date'] as String?,
      json['id'] as String?,
      json['mode_name'] as String?,
      json['unit_name'] as String?,
    );

Map<String, dynamic> _$ChildrenItemsServiceExtrasDtoToJson(
        ChildrenItemsServiceExtrasDto instance) =>
    <String, dynamic>{
      '_id': instance.iid,
      'station': instance.station,
      'code': instance.code,
      'name': instance.name,
      'description': instance.description,
      'route_code': instance.routeCode,
      'price': instance.price,
      'unit': instance.unit,
      'mode': instance.mode,
      'child_code': instance.childCode,
      'show': instance.show,
      'groups': instance.groups,
      'status': instance.status,
      'primary': instance.primary,
      'deleted': instance.deleted,
      'position': instance.position,
      'created_by': instance.createdBy,
      'created_date': instance.createdDate,
      '__v': instance.v,
      'updated_by': instance.updatedBy,
      'updated_date': instance.updatedDate,
      'id': instance.id,
      'mode_name': instance.modeName,
      'unit_name': instance.unitName,
    };
