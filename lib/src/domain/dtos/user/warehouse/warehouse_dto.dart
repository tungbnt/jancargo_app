import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

part 'warehouse_dto.g.dart';

@JsonSerializable()
class WareHouseDto {
  const WareHouseDto({this.results, this.paginationDto,}) : super();

  @JsonKey(name: 'results')
  final List<WareHouseDataDto>? results;
  @JsonKey(name: 'pagination')
  final PaginationDto? paginationDto;


  factory WareHouseDto.fromJson(Map<String, dynamic> json) =>
      _$WareHouseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$WareHouseDtoToJson(this);
}
@JsonSerializable()
class WareHouseDataDto {
  const WareHouseDataDto({this.id_, this.station, this.code, this.name, this.route, this.description, this.transMode, this.location, this.status, this.deleted, this.createdDate, this.v, this.shipMode, this.id, this.trans, }) : super();

  @JsonKey(name: '_id')
  final String? id_;
  @JsonKey(name: 'station')
  final String? station;
  @JsonKey(name: 'code')
  final String? code;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'route')
  final String? route;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'trans_mode')
  final String? transMode;
  @JsonKey(name: 'location')
  final String? location;
  @JsonKey(name: 'status')
  final bool? status;
  @JsonKey(name: 'deleted')
  final bool? deleted;
  @JsonKey(name: 'created_date')
  final String? createdDate;
  @JsonKey(name: '__v')
  final int? v;
  @JsonKey(name: 'ship_mode')
  final List<ShipModeDto>? shipMode;
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'trans')
  final String? trans;


  factory WareHouseDataDto.fromJson(Map<String, dynamic> json) =>
      _$WareHouseDataDtoFromJson(json);

  Map<String, dynamic> toJson() => _$WareHouseDataDtoToJson(this);
}

@JsonSerializable()
class ShipModeDto  {
  const ShipModeDto( {required this.selectedShip, this.priceEst, this.value, this.label, this.description, this.active, this.defaultt, this.shortLabel, this.timeEst, })
      : super();

  @JsonKey(name: 'value')
  final String? value;
  @JsonKey( name: 'label')
  final String? label;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey( name: 'active')
  final bool? active;
  @JsonKey( name: 'default')
  final bool? defaultt;
  @JsonKey(name: 'short_label')
  final String? shortLabel;
  @JsonKey(name: 'time_est')
  final TimeEstDto? timeEst;
  @JsonKey(name: 'price_est')
  final String? priceEst;
  @JsonKey(name: 'isCheck',fromJson: _selectedFromJson,toJson: _selectedToJson)
  final ValueNotifier<bool> selectedShip;

  static ValueNotifier<bool> _selectedFromJson(bool? value) =>
      ValueNotifier<bool>(value ?? false);

  static bool _selectedToJson(ValueNotifier<bool> selectedShip) =>
      selectedShip.value;

  factory ShipModeDto.fromJson(Map<String, dynamic> json) =>
      _$ShipModeDtoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ShipModeDtoToJson(this);
}

@JsonSerializable()
class TimeEstDto  {
  const TimeEstDto( {this.min, this.max, })
      : super();

  @JsonKey(name: 'min')
  final int? min;
  @JsonKey( name: 'max')
  final int? max;


  factory TimeEstDto.fromJson(Map<String, dynamic> json) =>
      _$TimeEstDtoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$TimeEstDtoToJson(this);
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