// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_item_cart_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateItemCartRequest _$UpdateItemCartRequestFromJson(
        Map<String, dynamic> json) =>
    UpdateItemCartRequest(
      items: (json['items'] as List<dynamic>?)
          ?.map((e) =>
              ListUpdateItemCartRequest.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UpdateItemCartRequestToJson(
        UpdateItemCartRequest instance) =>
    <String, dynamic>{
      'items': instance.items,
    };

ListUpdateItemCartRequest _$ListUpdateItemCartRequestFromJson(
        Map<String, dynamic> json) =>
    ListUpdateItemCartRequest(
      id: json['id'] as String?,
      qty: json['qty'] as int?,
      selected: json['selected'] as bool?,
    );

Map<String, dynamic> _$ListUpdateItemCartRequestToJson(
        ListUpdateItemCartRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'qty': instance.qty,
      'selected': instance.selected,
    };
