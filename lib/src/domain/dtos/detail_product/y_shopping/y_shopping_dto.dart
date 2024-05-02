import 'package:json_annotation/json_annotation.dart';

part 'y_shopping_dto.g.dart';

@JsonSerializable()
class YShoppingDetailDto  {
  const YShoppingDetailDto({this.code, this.name, this.url, this.condition, this.headline, this.description, this.caption, this.releaseDate, this.additional1, this.additional2, this.additional3, this.images, this.price, this.priceLabel, this.shipping, this.point, this.review, this.store, this.orders, this.categoryId, this.availability, })
      : super();

  @JsonKey(name: 'code')
  final String? code;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'url')
  final String? url;
  @JsonKey(name: 'condition')
  final String? condition;
  @JsonKey(name: 'headline')
  final String? headline;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'caption')
  final String? caption;
  @JsonKey(name: 'releaseDate')
  final String? releaseDate;
  @JsonKey(name: 'additional1')
  final String? additional1;
  @JsonKey(name: 'additional2')
  final String? additional2;
  @JsonKey(name: 'additional3')
  final String? additional3;
  @JsonKey(name: 'images')
  final List<String>? images;
  @JsonKey(name: 'price')
  final int? price;
  @JsonKey(name: 'priceLabel')
  final PriceLabelYShoppingDetailDto? priceLabel;
  @JsonKey(name: 'shipping')
  final ShippingYShoppingDetailDto? shipping;
  @JsonKey(name: 'point')
  final PointDetailDto? point;
  @JsonKey(name: 'review')
  final ReviewYShoppingDetailDto? review;
  @JsonKey(name: 'store')
  final StoreYShoppingDetailDto? store;
  @JsonKey(name: 'orders')
  final List<OdersYShoppingDetailDto>? orders;
  @JsonKey(name: 'category_id')
  final String? categoryId;
  @JsonKey(name: 'availability')
  final String? availability;





  factory YShoppingDetailDto.fromJson(Map<String, dynamic> json) =>
      _$YShoppingDetailDtoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$YShoppingDetailDtoToJson(this);
}

@JsonSerializable()
class PriceLabelYShoppingDetailDto  {
  const PriceLabelYShoppingDetailDto({this.fixedPrice, this.defaultPrice, this.taxExcludedDefaultPrice, this.salePrice, this.taxExcludedSalePrice, this.memberPrice, this.taxExcludedMemberPrice, this.periodStart, this.periodEnd, this.subscriptionPrice, this.taxExcludedSubscriptionPrice, })
      : super();

  @JsonKey(name: 'FixedPrice')
  final dynamic fixedPrice;
  @JsonKey(name: 'DefaultPrice')
  final int? defaultPrice;
  @JsonKey(name: 'TaxExcludedDefaultPrice')
  final int? taxExcludedDefaultPrice;
  @JsonKey(name: 'SalePrice')
  final String? salePrice;
  @JsonKey(name: 'TaxExcludedSalePrice')
  final String? taxExcludedSalePrice;
  @JsonKey(name: 'MemberPrice')
  final dynamic memberPrice;
  @JsonKey(name: 'taxExcludedMemberPrice')
  final String? taxExcludedMemberPrice;
  @JsonKey(name: 'PeriodStart')
  final String? periodStart;
@JsonKey(name: 'PeriodEnd')
final String? periodEnd;
@JsonKey(name: 'SubscriptionPrice')
final String? subscriptionPrice;
@JsonKey(name: 'TaxExcludedSubscriptionPrice')
final String? taxExcludedSubscriptionPrice;




  factory PriceLabelYShoppingDetailDto.fromJson(Map<String, dynamic> json) =>
      _$PriceLabelYShoppingDetailDtoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PriceLabelYShoppingDetailDtoToJson(this);
}

@JsonSerializable()
class ShippingYShoppingDetailDto  {
  const ShippingYShoppingDetailDto({this.code, this.name,})
      : super();

  @JsonKey(name: 'Code')
  final String? code;
  @JsonKey(name: 'Name')
  final String? name;

  factory ShippingYShoppingDetailDto.fromJson(Map<String, dynamic> json) =>
      _$ShippingYShoppingDetailDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ShippingYShoppingDetailDtoToJson(this);
}

@JsonSerializable()
class PointDetailDto  {
  const PointDetailDto( { this.mount, this.times, this.premiumAmount, this.premiumTimes, this.premiumCpAmount, this.appCpAmount, this.preAppCpAmount, this.premiumCpTimes, this.appCpTimes, this.preAppCpTimes,})
      : super();

  @JsonKey(name: 'amount')
  final int? mount;
  @JsonKey(name: 'Times')
  final int? times;
  @JsonKey(name: 'PremiumAmount')
  final int? premiumAmount;
  @JsonKey(name: 'PremiumTimes')
  final int? premiumTimes;
  @JsonKey(name: 'PremiumCpAmount')
  final dynamic premiumCpAmount;
  @JsonKey(name: 'AppCpAmount')
  final String? appCpAmount;
  @JsonKey(name: 'PreAppCpAmount')
  final String? preAppCpAmount;
  @JsonKey(name: 'PremiumCpTimes')
  final int? premiumCpTimes;
  @JsonKey(name: 'AppCpTimes')
  final String? appCpTimes;
  @JsonKey(name: 'PreAppCpTimes')
  final String? preAppCpTimes;


  factory PointDetailDto.fromJson(Map<String, dynamic> json) =>
      _$PointDetailDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PointDetailDtoToJson(this);
}


@JsonSerializable()
class ReviewYShoppingDetailDto  {
  const ReviewYShoppingDetailDto( { this.rate, this.count, this.url, })
      : super();

  @JsonKey(name: 'Rate')
  final String? rate;
  @JsonKey(name: 'Count')
  final String? count;
  @JsonKey(name: 'Url')
  final String? url;

  factory ReviewYShoppingDetailDto.fromJson(Map<String, dynamic> json) =>
      _$ReviewYShoppingDetailDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewYShoppingDetailDtoToJson(this);
}

@JsonSerializable()
class StoreYShoppingDetailDto  {
  const StoreYShoppingDetailDto( {this.id, this.name, this.sellerType, this.url, this.ratings, this.image, this.point, this.inventoryMessage, this.sameDayDelivery, this.expressDelivery,})
      : super();

  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'sellerType')
  final String? sellerType;
  @JsonKey(name: 'url')
  final String? url;
  @JsonKey(name: 'ratings')
  final RatingStoreYShoppingDetailDto? ratings;
  @JsonKey(name: 'image')
  final String? image;
  @JsonKey(name: 'point')
  final PointStoreYShoppingDetailDto? point;
  @JsonKey(name: 'inventoryMessage')
  final String? inventoryMessage;
  @JsonKey(name: 'sameDayDelivery')
  final SamDayStoreYShoppingDetailDto? sameDayDelivery;
  @JsonKey(name: 'expressDelivery')
  final ExpressStoreYShoppingDetailDto? expressDelivery;


  factory StoreYShoppingDetailDto.fromJson(Map<String, dynamic> json) =>
      _$StoreYShoppingDetailDtoFromJson(json);

  Map<String, dynamic> toJson() => _$StoreYShoppingDetailDtoToJson(this);
}

@JsonSerializable()
class RatingStoreYShoppingDetailDto  {
  const RatingStoreYShoppingDetailDto( {  this.rate, this.count, this.total, this.detailRate, })
      : super();

  @JsonKey(name: 'Rate')
  final String? rate;
  @JsonKey(name: 'Count')
  final String? count;
  @JsonKey(name: 'Total')
  final String? total;
  @JsonKey(name: 'DetailRate')
  final String? detailRate;



  factory RatingStoreYShoppingDetailDto.fromJson(Map<String, dynamic> json) =>
      _$RatingStoreYShoppingDetailDtoFromJson(json);

  Map<String, dynamic> toJson() => _$RatingStoreYShoppingDetailDtoToJson(this);
}

@JsonSerializable()
class PointStoreYShoppingDetailDto  {
  const PointStoreYShoppingDetailDto( { this.grant, this.accept, })
      : super();

  @JsonKey(name: 'Grant')
  final String? grant;
  @JsonKey(name: 'Accept')
  final String? accept;

  factory PointStoreYShoppingDetailDto.fromJson(Map<String, dynamic> json) =>
      _$PointStoreYShoppingDetailDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PointStoreYShoppingDetailDtoToJson(this);
}

@JsonSerializable()
class SamDayStoreYShoppingDetailDto  {
  const SamDayStoreYShoppingDetailDto( { this.areas, this.deadline, this.conditions, })
      : super();

  @JsonKey(name: 'Areas')
  final String? areas;
  @JsonKey(name: 'Deadline')
  final String? deadline;
  @JsonKey(name: 'Conditions')
  final String? conditions;

  factory SamDayStoreYShoppingDetailDto.fromJson(Map<String, dynamic> json) =>
      _$SamDayStoreYShoppingDetailDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SamDayStoreYShoppingDetailDtoToJson(this);
}

@JsonSerializable()
class ExpressStoreYShoppingDetailDto  {
  const ExpressStoreYShoppingDetailDto( { this.areas, this.deadline, this.conditions, })
      : super();

  @JsonKey(name: 'Areas')
  final String? areas;
  @JsonKey(name: 'Deadline')
  final String? deadline;
  @JsonKey(name: 'Conditions')
  final String? conditions;

  factory ExpressStoreYShoppingDetailDto.fromJson(Map<String, dynamic> json) =>
      _$ExpressStoreYShoppingDetailDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ExpressStoreYShoppingDetailDtoToJson(this);
}

@JsonSerializable()
class OdersYShoppingDetailDto  {
  const OdersYShoppingDetailDto( { this.name, this.options, })
      : super();

  @JsonKey(name: 'Name')
  final String? name;
  @JsonKey(name: 'Options')
  final List<OptionOdersYShoppingDetailDto>? options;


  factory OdersYShoppingDetailDto.fromJson(Map<String, dynamic> json) =>
      _$OdersYShoppingDetailDtoFromJson(json);

  Map<String, dynamic> toJson() => _$OdersYShoppingDetailDtoToJson(this);
}

@JsonSerializable()
class OptionOdersYShoppingDetailDto  {
  const OptionOdersYShoppingDetailDto( { this.value,})
      : super();

  @JsonKey(name: 'Value')
  final String? value;

  factory OptionOdersYShoppingDetailDto.fromJson(Map<String, dynamic> json) =>
      _$OptionOdersYShoppingDetailDtoFromJson(json);

  Map<String, dynamic> toJson() => _$OptionOdersYShoppingDetailDtoToJson(this);
}