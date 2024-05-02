// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressUserDto _$AddressUserDtoFromJson(Map<String, dynamic> json) =>
    AddressUserDto(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ItemsAddressUser.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AddressUserDtoToJson(AddressUserDto instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

ItemsAddressUser _$ItemsAddressUserFromJson(Map<String, dynamic> json) =>
    ItemsAddressUser(
      createdAt: json['created_at'] as String?,
      deleted: json['deleted'] as bool?,
      district: json['district'] as String?,
      districtId: json['district_id'] as int?,
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      primary: json['primary'] as bool?,
      province: json['province'] as String?,
      provinceId: json['province_id'] as int?,
      status: ItemsAddressUser._selectedStatusFromJson(json['status'] as bool?),
      type: json['type'] as String?,
      updatedAt: json['updated_at'] as String?,
      user: json['user'] as String?,
      ward: json['ward'] as String?,
      wardId: json['ward_id'] as int?,
      v: json['__v'] as int?,
      id: json['_id'],
      address: json['address'] as String?,
      remark: json['remark'] as String?,
    );

Map<String, dynamic> _$ItemsAddressUserToJson(ItemsAddressUser instance) =>
    <String, dynamic>{
      'address': instance.address,
      'created_at': instance.createdAt,
      'deleted': instance.deleted,
      'district': instance.district,
      'district_id': instance.districtId,
      'name': instance.name,
      'phone': instance.phone,
      'primary': instance.primary,
      'province': instance.province,
      'province_id': instance.provinceId,
      'status': ItemsAddressUser._selectedStatusToJson(instance.status),
      'type': instance.type,
      'updated_at': instance.updatedAt,
      'user': instance.user,
      'remark': instance.remark,
      'ward': instance.ward,
      'ward_id': instance.wardId,
      '__v': instance.v,
      '_id': instance.id,
    };
