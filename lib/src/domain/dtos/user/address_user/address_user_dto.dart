import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'address_user_dto.g.dart';

@JsonSerializable()
class AddressUserDto {

  @JsonKey(name: 'data')
  final List<ItemsAddressUser>? data;

  AddressUserDto({
    this.data,
  });
  factory AddressUserDto.fromJson(Map<String, dynamic> json) =>
      _$AddressUserDtoFromJson(json);
  Map<String, dynamic> toJson() => _$AddressUserDtoToJson(this);
}
@JsonSerializable()
class ItemsAddressUser {
  @JsonKey(name: 'address')
  final String? address;
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @JsonKey(name: 'deleted')
  final bool? deleted;
  @JsonKey(name: 'district')
  final String? district;
  @JsonKey(name: 'district_id')
  final int? districtId;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'phone')
  final String? phone;
  @JsonKey(name: 'primary')
  final bool? primary;
  @JsonKey(name: 'province')
  final String? province;
  @JsonKey(name: 'province_id')
  final int? provinceId;
  @JsonKey(name: 'status',fromJson: _selectedStatusFromJson,toJson: _selectedStatusToJson)
  final ValueNotifier<bool> status;
  @JsonKey(name: 'type')
  final String? type;
  @JsonKey(name: 'updated_at')
  final String? updatedAt;
  @JsonKey(name: 'user')
  final String? user;
  @JsonKey(name: 'remark')
  final String? remark;
  @JsonKey(name: 'ward')
  final String? ward;
  @JsonKey(name: 'ward_id')
  final int? wardId;
  @JsonKey(name: '__v')
  final int? v;
  @JsonKey(name: '_id')
  final dynamic id;

  ItemsAddressUser({
    this.createdAt,
    this.deleted,
    this.district,
    this.districtId,
    this.name,
    this.phone,
    this.primary,
    this.province,
    this.provinceId,
    required this.status,
    this.type,
    this.updatedAt,
    this.user,
    this.ward,
    this.wardId,
    this.v,
    this.id,
    this.address,
    this.remark,
  });

  static ValueNotifier<bool> _selectedStatusFromJson(bool? value) =>
      ValueNotifier<bool>(value ?? false);

  static bool _selectedStatusToJson(ValueNotifier<bool> selectedStatus) =>
      selectedStatus.value;
  factory ItemsAddressUser.fromJson(Map<String, dynamic> json) =>
      _$ItemsAddressUserFromJson(json);

  Map<String, dynamic> toJson() => _$ItemsAddressUserToJson(this);
}