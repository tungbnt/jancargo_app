// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_seller_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavoriteSellerDto _$FavoriteSellerDtoFromJson(Map<String, dynamic> json) =>
    FavoriteSellerDto(
      code: json['code'] as int?,
      data: (json['data'] as List<dynamic>?)
          ?.map(
              (e) => FavoriteSellerItemDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FavoriteSellerDtoToJson(FavoriteSellerDto instance) =>
    <String, dynamic>{
      'code': instance.code,
      'data': instance.data,
    };

FavoriteSellerItemDto _$FavoriteSellerItemDtoFromJson(
        Map<String, dynamic> json) =>
    FavoriteSellerItemDto(
      code: json['code'] as String?,
      id: json['_id'] as String?,
      avatar: json['avatar'] as String?,
      createdDate: json['created_date'] as String?,
      deleted: json['deleted'] as bool?,
      description: json['description'] as String?,
      expireAt: json['expireAt'] as String?,
      name: json['name'] as String?,
      remark: json['remark'] as String?,
      siteCode: json['site_code'] as String?,
      status: json['status'] as bool?,
      type: json['type'] as String?,
      url: json['url'] as String?,
      userId: json['user_id'] as String?,
    );

Map<String, dynamic> _$FavoriteSellerItemDtoToJson(
        FavoriteSellerItemDto instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'avatar': instance.avatar,
      'code': instance.code,
      'created_date': instance.createdDate,
      'deleted': instance.deleted,
      'description': instance.description,
      'expireAt': instance.expireAt,
      'name': instance.name,
      'remark': instance.remark,
      'site_code': instance.siteCode,
      'status': instance.status,
      'type': instance.type,
      'url': instance.url,
      'user_id': instance.userId,
    };
