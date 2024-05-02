import 'package:json_annotation/json_annotation.dart';

part 'create_oder_request.g.dart';

@JsonSerializable()
class CreateOderRequest {
  @JsonKey(name: 'address')
  final AddressCreateOderRequest? address;
  @JsonKey(name: 'quotes')
  final List<QuotesCreateOderRequest>? quotes;

  CreateOderRequest({
    this.address,
    this.quotes,
  });

  Map<String, dynamic> toJson() => _$CreateOderRequestToJson(this);
}

@JsonSerializable()
class AddressCreateOderRequest {
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
  @JsonKey(name: 'status')
  final bool? status;
  @JsonKey(name: 'type')
  final String? type;
  @JsonKey(name: 'updated_at')
  final String? updatedAt;
  @JsonKey(name: 'user')
  final String? user;
  @JsonKey(name: 'ward')
  final String? ward;
  @JsonKey(name: 'ward_id')
  final int? wardId;
  @JsonKey(name: '__v')
  final int? v;
  @JsonKey(name: '_id')
  final int? id;

  AddressCreateOderRequest({
    this.createdAt,
    this.deleted,
    this.district,
    this.districtId,
    this.name,
    this.phone,
    this.primary,
    this.province,
    this.provinceId,
    this.status,
    this.type,
    this.updatedAt,
    this.user,
    this.ward,
    this.wardId,
    this.v,
    this.id,
    this.address,
  });
  factory AddressCreateOderRequest.fromJson(Map<String, dynamic> json) =>
      _$AddressCreateOderRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddressCreateOderRequestToJson(this);
}

@JsonSerializable()
class QuotesCreateOderRequest {
  @JsonKey(name: 'allow')
  final bool? allow;
  @JsonKey(name: 'currency')
  final String? currency;
  @JsonKey(name: 'exchange_rate')
  final int? exchangeRate;
  @JsonKey(name: 'goods_values')
  final int? goodsValues;
  @JsonKey(name: 'link')
  final String? link;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'note')
  final String? note;
  @JsonKey(name: 'percent_rate')
  final double? percentRate;
  @JsonKey(name: 'quality')
  final int? quality;
  @JsonKey(name: 'route_code')
  final String? routeCode;
  @JsonKey(name: 'services_extra')
  final List<String>? servicesExtra;
  @JsonKey(name: 'ship_mode')
  final String? shipMode;
  @JsonKey(name: 'web_code')
  final String? webCode;
  @JsonKey(name: 'weight')
  final double? weight;

  QuotesCreateOderRequest({
    this.allow,
    this.currency,
    this.exchangeRate,
    this.goodsValues,
    this.link,
    this.name,
    this.note,
    this.percentRate,
    this.quality,
    this.routeCode,
    this.servicesExtra,
    this.shipMode,
    this.webCode,
    this.weight,
  });
  factory QuotesCreateOderRequest.fromJson(Map<String, dynamic> json) =>
      _$QuotesCreateOderRequestFromJson(json);


  Map<String, dynamic> toJson() => _$QuotesCreateOderRequestToJson(this);
}
