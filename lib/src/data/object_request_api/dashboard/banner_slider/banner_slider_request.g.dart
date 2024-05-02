// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'banner_slider_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BannerSliderRequest _$BannerSliderRequestFromJson(Map<String, dynamic> json) =>
    BannerSliderRequest(
      typePage: json['type_page'] as String?,
      status: json['status'] as String?,
      page: json['page'] as String?,
      size: json['size'] as String?,
    );

Map<String, dynamic> _$BannerSliderRequestToJson(
        BannerSliderRequest instance) =>
    <String, dynamic>{
      'type_page': instance.typePage,
      'page': instance.page,
      'size': instance.size,
      'status': instance.status,
    };
