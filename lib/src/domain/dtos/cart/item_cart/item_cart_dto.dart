import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'item_cart_dto.g.dart';

@JsonSerializable()
class CartDto {
  const CartDto({this.data}) : super();

  @JsonKey(name: 'data')
  final List<ItemCartDto>? data;

  factory CartDto.fromJson(Map<String, dynamic> json) => _$CartDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CartDtoToJson(this);
}

@JsonSerializable()
class ItemCartDto {
  ItemCartDto({
    this.id,
    this.siteCode,
    this.code,
    this.name,
    this.url,
    this.qty,
    this.price,
    this.currency,
    this.sku,
    this.images,
    this.shipMode,
    this.status,
    this.deleted,
    this.userId,
    this.options,
    this.createdDate,
    this.expireAt,
    this.v,
    required this.isSelected,
    required this.selectedAmount,
    required this.selectedShip,
    required this.selectedService,
  }) : super();

  @JsonKey(name: '_id')
  final String? id;
  @JsonKey(name: 'site_code')
  final String? siteCode;
  @JsonKey(name: 'code')
  final String? code;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'url')
  final String? url;
  @JsonKey(name: 'qtyy')
  int? qty;
  @JsonKey(
    name: 'qty',
    fromJson: _selectedAmountFromJson,
    toJson: _selectedAmountToJson,
  )
  final ValueNotifier<int> selectedAmount;
  @JsonKey(
    name: 'selectedShip',
    fromJson: _selectedShipFromJson,
    toJson: _selectedShipToJson,
  )
  ValueNotifier<int?> selectedShip;
  @JsonKey(
    name: 'selectedService',
    fromJson: _selectedServiceFromJson,
    toJson: _selectedServiceToJson,
  )
  ValueNotifier<int> selectedService;
  @JsonKey(name: 'price')
  final int? price;
  @JsonKey(name: 'currency')
  final String? currency;
  @JsonKey(name: 'sku')
  final String? sku;
  @JsonKey(name: 'images')
  final List<String>? images;
  @JsonKey(name: 'ship_mode')
  final String? shipMode;
  @JsonKey(name: 'status')
  final bool? status;
  @JsonKey(name: 'deleted')
  final bool? deleted;
  @JsonKey(name: 'user_id')
  final String? userId;
  @JsonKey(
    name: 'selected',
    fromJson: _selectedFromJson,
    toJson: _selectedToJson,
  )
  final ValueNotifier<bool> isSelected;
  @JsonKey(name: 'options')
  final List<dynamic>? options;
  @JsonKey(name: 'created_date')
  final String? createdDate;
  @JsonKey(name: 'expireAt')
  final String? expireAt;
  @JsonKey(name: '__v')
  final int? v;

  static ValueNotifier<bool> _selectedFromJson(bool? value) => ValueNotifier<bool>(value ?? false);

  static bool _selectedToJson(ValueNotifier<bool> isSelected) => isSelected.value;

  static ValueNotifier<int> _selectedAmountFromJson(int? value) => ValueNotifier<int>(value ?? 0);

  static int _selectedAmountToJson(ValueNotifier<int> selectedAmount) => selectedAmount.value;

  static ValueNotifier<int> _selectedServiceFromJson(int? value) => ValueNotifier<int>(value ?? 0);

  static int _selectedServiceToJson(ValueNotifier<int> selectedAmount) => selectedAmount.value;

  static ValueNotifier<int> _selectedShipFromJson(int? value) => ValueNotifier<int>(value ?? 0);

  static int? _selectedShipToJson(ValueNotifier<int?> selectedAmount) => selectedAmount.value;

  factory ItemCartDto.fromJson(Map<String, dynamic> json) => _$ItemCartDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ItemCartDtoToJson(this);
}

@JsonSerializable()
class GroupCartsDto {
  GroupCartsDto({this.code, this.data}) : super() {
    isSelected = ValueNotifier(data?.any((e) => e.isSelected.value) ?? false);
  }

  @JsonKey(name: 'data')
  final List<ItemCartDto>? data;
  @JsonKey(name: 'code')
  final String? code;

  @JsonKey(
    name: 'selected',
    fromJson: _selectedFromJson,
    toJson: _selectedToJson,
  )
  late final ValueNotifier<bool> isSelected;

  int get selectedCount => data?.where((e) => e.isSelected.value).length ?? 0;

  ValueNotifier<int> get total {
    return ValueNotifier(data
        ?.where((e) => e.isSelected.value)
        .fold(0, (previousValue, e) => (previousValue ?? 0) + e.selectedAmount.value * e.price!) ??
        0);
  }

  static ValueNotifier<bool> _selectedFromJson(bool? value) => ValueNotifier<bool>(value ?? false);

  static bool _selectedToJson(ValueNotifier<bool> isSelected) => isSelected.value;

  factory GroupCartsDto.fromJson(Map<String, dynamic> json) => _$GroupCartsDtoFromJson(json);

  Map<String, dynamic> toJson() => _$GroupCartsDtoToJson(this);

  GroupCartsDto clone() {
    final result = GroupCartsDto(
      code: code,
      data: data?.toList(),
    );

    result.isSelected.value = isSelected.value;

    return result;
  }
}
