// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_seller_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavoriteSellerRequest _$FavoriteSellerRequestFromJson(
        Map<String, dynamic> json) =>
    FavoriteSellerRequest(
      code: json['code'] as String?,
      description: json['description'] as String?,
      image: json['image'] as String?,
      name: json['name'] as String?,
      remark: json['remark'] as String?,
      url: json['url'] as String?,
      siteCode: json['site_code'] as String?,
    );

Map<String, dynamic> _$FavoriteSellerRequestToJson(
        FavoriteSellerRequest instance) =>
    <String, dynamic>{
      'code': instance.code,
      'description': instance.description,
      'image': instance.image,
      'name': instance.name,
      'remark': instance.remark,
      'url': instance.url,
      'site_code': instance.siteCode,
    };
