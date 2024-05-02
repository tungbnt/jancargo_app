import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'service_extras_dto.g.dart';

@JsonSerializable()
class ServiceExtrasDto {
  const ServiceExtrasDto({this.data}) : super();

  @JsonKey(name: 'data')
  final List<ItemsServiceExtrasDto>? data;

  factory ServiceExtrasDto.fromJson(Map<String, dynamic> json) =>
      _$ServiceExtrasDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceExtrasDtoToJson(this);
}

@JsonSerializable()
class ItemsServiceExtrasDto {
  ItemsServiceExtrasDto(
      this.iid,
      this.station,
      this.code,
      this.name,
      this.description,
      this.routeCode,
      this.price,
      this.unit,
      this.mode,
      this.childCode,
      this.show,
      this.groups,
      this.status,
      this.primary,
      this.deleted,
      this.position,
      this.createdBy,
      this.createdDate,
      this.v,
      this.updatedBy,
      this.updatedDate,
      this.id,
      this.modeName,
      this.unitName,
      this.childrens, this.selectedService)
      : super();

  @JsonKey(name: '_id')
  final String? iid;
  @JsonKey(name: 'station')
  final String? station;
  @JsonKey(name: 'code')
  final String? code;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'route_code')
  final String? routeCode;
  @JsonKey(name: 'price')
  final int? price;
  @JsonKey(name: 'unit')
  final String? unit;
  @JsonKey(name: 'mode')
  final String? mode;
  @JsonKey(name: 'child_code')
  final List<String>? childCode;
  @JsonKey(name: 'show')
  final bool? show;
  @JsonKey(name: 'groups')
  final bool? groups;
  @JsonKey(name: 'status')
  final bool? status;
  @JsonKey(name: 'primary')
  final bool? primary;
  @JsonKey(name: 'deleted')
  final bool? deleted;
  @JsonKey(name: 'position')
  final int? position;
  @JsonKey(name: 'created_by')
  final String? createdBy;
  @JsonKey(name: 'created_date')
  final String? createdDate;
  @JsonKey(name: '__v')
  final int? v;
  @JsonKey(name: 'updated_by')
  final String? updatedBy;
  @JsonKey(name: 'updated_date')
  final String? updatedDate;
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'mode_name')
  final String? modeName;
  @JsonKey(name: 'unit_name')
  final String? unitName;
  @JsonKey(name: 'childrens',)
  final List<ChildrenItemsServiceExtrasDto>? childrens;
  @JsonKey(
    name: 'selectedService',
    fromJson: _selectedServiceFromJson,
    toJson: _selectedServiceToJson,
  )
  final ValueNotifier<bool> selectedService;



  static ValueNotifier<bool> _selectedServiceFromJson(bool? value) =>
      ValueNotifier<bool>(value ?? false);

  static bool _selectedServiceToJson(ValueNotifier<bool> selectedAmount) =>
      selectedAmount.value;

  factory ItemsServiceExtrasDto.fromJson(Map<String, dynamic> json) {
    if (json['childrens'] is List<dynamic>) {
      final List<dynamic> childrensList = json['childrens'];
      final List<Map<String, dynamic>> parsedChildrens = [];
      for (var childJson in childrensList) {
        if (childJson is Map<String, dynamic>) {
          parsedChildrens.add(childJson);
        }
      }
      return _$ItemsServiceExtrasDtoFromJson({...json, 'childrens': parsedChildrens});
    } else {
      return _$ItemsServiceExtrasDtoFromJson(json);
    }
  }

  Map<String, dynamic> toJson() => _$ItemsServiceExtrasDtoToJson(this);
}

@JsonSerializable()
class ChildrenItemsServiceExtrasDto {
  const ChildrenItemsServiceExtrasDto(
      this.iid,
      this.station,
      this.code,
      this.name,
      this.description,
      this.routeCode,
      this.price,
      this.unit,
      this.mode,
      this.childCode,
      this.show,
      this.groups,
      this.status,
      this.primary,
      this.deleted,
      this.position,
      this.createdBy,
      this.createdDate,
      this.v,
      this.updatedBy,
      this.updatedDate,
      this.id,
      this.modeName,
      this.unitName)
      : super();

  @JsonKey(name: '_id')
  final String? iid;
  @JsonKey(name: 'station')
  final String? station;
  @JsonKey(name: 'code')
  final String? code;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'route_code')
  final String? routeCode;
  @JsonKey(name: 'price')
  final int? price;
  @JsonKey(name: 'unit')
  final String? unit;
  @JsonKey(name: 'mode')
  final String? mode;
  @JsonKey(name: 'child_code')
  final List<dynamic>? childCode;
  @JsonKey(name: 'show')
  final bool? show;
  @JsonKey(name: 'groups')
  final bool? groups;
  @JsonKey(name: 'status')
  final bool? status;
  @JsonKey(name: 'primary')
  final bool? primary;
  @JsonKey(name: 'deleted')
  final bool? deleted;
  @JsonKey(name: 'position')
  final int? position;
  @JsonKey(name: 'created_by')
  final String? createdBy;
  @JsonKey(name: 'created_date')
  final String? createdDate;
  @JsonKey(name: '__v')
  final int? v;
  @JsonKey(name: 'updated_by')
  final String? updatedBy;
  @JsonKey(name: 'updated_date')
  final String? updatedDate;
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'mode_name')
  final String? modeName;
  @JsonKey(name: 'unit_name')
  final String? unitName;

  factory ChildrenItemsServiceExtrasDto.fromJson(Map<String, dynamic> json) =>
      _$ChildrenItemsServiceExtrasDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ChildrenItemsServiceExtrasDtoToJson(this);
}
