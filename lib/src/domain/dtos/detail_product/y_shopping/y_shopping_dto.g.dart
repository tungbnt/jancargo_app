// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'y_shopping_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

YShoppingDetailDto _$YShoppingDetailDtoFromJson(Map<String, dynamic> json) =>
    YShoppingDetailDto(
      code: json['code'] as String?,
      name: json['name'] as String?,
      url: json['url'] as String?,
      condition: json['condition'] as String?,
      headline: json['headline'] as String?,
      description: json['description'] as String?,
      caption: json['caption'] as String?,
      releaseDate: json['releaseDate'] as String?,
      additional1: json['additional1'] as String?,
      additional2: json['additional2'] as String?,
      additional3: json['additional3'] as String?,
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      price: json['price'] as int?,
      priceLabel: json['priceLabel'] == null
          ? null
          : PriceLabelYShoppingDetailDto.fromJson(
              json['priceLabel'] as Map<String, dynamic>),
      shipping: json['shipping'] == null
          ? null
          : ShippingYShoppingDetailDto.fromJson(
              json['shipping'] as Map<String, dynamic>),
      point: json['point'] == null
          ? null
          : PointDetailDto.fromJson(json['point'] as Map<String, dynamic>),
      review: json['review'] == null
          ? null
          : ReviewYShoppingDetailDto.fromJson(
              json['review'] as Map<String, dynamic>),
      store: json['store'] == null
          ? null
          : StoreYShoppingDetailDto.fromJson(
              json['store'] as Map<String, dynamic>),
      orders: (json['orders'] as List<dynamic>?)
          ?.map((e) =>
              OdersYShoppingDetailDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      categoryId: json['category_id'] as String?,
      availability: json['availability'] as String?,
    );

Map<String, dynamic> _$YShoppingDetailDtoToJson(YShoppingDetailDto instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'url': instance.url,
      'condition': instance.condition,
      'headline': instance.headline,
      'description': instance.description,
      'caption': instance.caption,
      'releaseDate': instance.releaseDate,
      'additional1': instance.additional1,
      'additional2': instance.additional2,
      'additional3': instance.additional3,
      'images': instance.images,
      'price': instance.price,
      'priceLabel': instance.priceLabel,
      'shipping': instance.shipping,
      'point': instance.point,
      'review': instance.review,
      'store': instance.store,
      'orders': instance.orders,
      'category_id': instance.categoryId,
      'availability': instance.availability,
    };

PriceLabelYShoppingDetailDto _$PriceLabelYShoppingDetailDtoFromJson(
        Map<String, dynamic> json) =>
    PriceLabelYShoppingDetailDto(
      fixedPrice: json['FixedPrice'],
      defaultPrice: json['DefaultPrice'] as int?,
      taxExcludedDefaultPrice: json['TaxExcludedDefaultPrice'] as int?,
      salePrice: json['SalePrice'] as String?,
      taxExcludedSalePrice: json['TaxExcludedSalePrice'] as String?,
      memberPrice: json['MemberPrice'],
      taxExcludedMemberPrice: json['taxExcludedMemberPrice'] as String?,
      periodStart: json['PeriodStart'] as String?,
      periodEnd: json['PeriodEnd'] as String?,
      subscriptionPrice: json['SubscriptionPrice'] as String?,
      taxExcludedSubscriptionPrice:
          json['TaxExcludedSubscriptionPrice'] as String?,
    );

Map<String, dynamic> _$PriceLabelYShoppingDetailDtoToJson(
        PriceLabelYShoppingDetailDto instance) =>
    <String, dynamic>{
      'FixedPrice': instance.fixedPrice,
      'DefaultPrice': instance.defaultPrice,
      'TaxExcludedDefaultPrice': instance.taxExcludedDefaultPrice,
      'SalePrice': instance.salePrice,
      'TaxExcludedSalePrice': instance.taxExcludedSalePrice,
      'MemberPrice': instance.memberPrice,
      'taxExcludedMemberPrice': instance.taxExcludedMemberPrice,
      'PeriodStart': instance.periodStart,
      'PeriodEnd': instance.periodEnd,
      'SubscriptionPrice': instance.subscriptionPrice,
      'TaxExcludedSubscriptionPrice': instance.taxExcludedSubscriptionPrice,
    };

ShippingYShoppingDetailDto _$ShippingYShoppingDetailDtoFromJson(
        Map<String, dynamic> json) =>
    ShippingYShoppingDetailDto(
      code: json['Code'] as String?,
      name: json['Name'] as String?,
    );

Map<String, dynamic> _$ShippingYShoppingDetailDtoToJson(
        ShippingYShoppingDetailDto instance) =>
    <String, dynamic>{
      'Code': instance.code,
      'Name': instance.name,
    };

PointDetailDto _$PointDetailDtoFromJson(Map<String, dynamic> json) =>
    PointDetailDto(
      mount: json['amount'] as int?,
      times: json['Times'] as int?,
      premiumAmount: json['PremiumAmount'] as int?,
      premiumTimes: json['PremiumTimes'] as int?,
      premiumCpAmount: json['PremiumCpAmount'],
      appCpAmount: json['AppCpAmount'] as String?,
      preAppCpAmount: json['PreAppCpAmount'] as String?,
      premiumCpTimes: json['PremiumCpTimes'] as int?,
      appCpTimes: json['AppCpTimes'] as String?,
      preAppCpTimes: json['PreAppCpTimes'] as String?,
    );

Map<String, dynamic> _$PointDetailDtoToJson(PointDetailDto instance) =>
    <String, dynamic>{
      'amount': instance.mount,
      'Times': instance.times,
      'PremiumAmount': instance.premiumAmount,
      'PremiumTimes': instance.premiumTimes,
      'PremiumCpAmount': instance.premiumCpAmount,
      'AppCpAmount': instance.appCpAmount,
      'PreAppCpAmount': instance.preAppCpAmount,
      'PremiumCpTimes': instance.premiumCpTimes,
      'AppCpTimes': instance.appCpTimes,
      'PreAppCpTimes': instance.preAppCpTimes,
    };

ReviewYShoppingDetailDto _$ReviewYShoppingDetailDtoFromJson(
        Map<String, dynamic> json) =>
    ReviewYShoppingDetailDto(
      rate: json['Rate'] as String?,
      count: json['Count'] as String?,
      url: json['Url'] as String?,
    );

Map<String, dynamic> _$ReviewYShoppingDetailDtoToJson(
        ReviewYShoppingDetailDto instance) =>
    <String, dynamic>{
      'Rate': instance.rate,
      'Count': instance.count,
      'Url': instance.url,
    };

StoreYShoppingDetailDto _$StoreYShoppingDetailDtoFromJson(
        Map<String, dynamic> json) =>
    StoreYShoppingDetailDto(
      id: json['id'] as String?,
      name: json['name'] as String?,
      sellerType: json['sellerType'] as String?,
      url: json['url'] as String?,
      ratings: json['ratings'] == null
          ? null
          : RatingStoreYShoppingDetailDto.fromJson(
              json['ratings'] as Map<String, dynamic>),
      image: json['image'] as String?,
      point: json['point'] == null
          ? null
          : PointStoreYShoppingDetailDto.fromJson(
              json['point'] as Map<String, dynamic>),
      inventoryMessage: json['inventoryMessage'] as String?,
      sameDayDelivery: json['sameDayDelivery'] == null
          ? null
          : SamDayStoreYShoppingDetailDto.fromJson(
              json['sameDayDelivery'] as Map<String, dynamic>),
      expressDelivery: json['expressDelivery'] == null
          ? null
          : ExpressStoreYShoppingDetailDto.fromJson(
              json['expressDelivery'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$StoreYShoppingDetailDtoToJson(
        StoreYShoppingDetailDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'sellerType': instance.sellerType,
      'url': instance.url,
      'ratings': instance.ratings,
      'image': instance.image,
      'point': instance.point,
      'inventoryMessage': instance.inventoryMessage,
      'sameDayDelivery': instance.sameDayDelivery,
      'expressDelivery': instance.expressDelivery,
    };

RatingStoreYShoppingDetailDto _$RatingStoreYShoppingDetailDtoFromJson(
        Map<String, dynamic> json) =>
    RatingStoreYShoppingDetailDto(
      rate: json['Rate'] as String?,
      count: json['Count'] as String?,
      total: json['Total'] as String?,
      detailRate: json['DetailRate'] as String?,
    );

Map<String, dynamic> _$RatingStoreYShoppingDetailDtoToJson(
        RatingStoreYShoppingDetailDto instance) =>
    <String, dynamic>{
      'Rate': instance.rate,
      'Count': instance.count,
      'Total': instance.total,
      'DetailRate': instance.detailRate,
    };

PointStoreYShoppingDetailDto _$PointStoreYShoppingDetailDtoFromJson(
        Map<String, dynamic> json) =>
    PointStoreYShoppingDetailDto(
      grant: json['Grant'] as String?,
      accept: json['Accept'] as String?,
    );

Map<String, dynamic> _$PointStoreYShoppingDetailDtoToJson(
        PointStoreYShoppingDetailDto instance) =>
    <String, dynamic>{
      'Grant': instance.grant,
      'Accept': instance.accept,
    };

SamDayStoreYShoppingDetailDto _$SamDayStoreYShoppingDetailDtoFromJson(
        Map<String, dynamic> json) =>
    SamDayStoreYShoppingDetailDto(
      areas: json['Areas'] as String?,
      deadline: json['Deadline'] as String?,
      conditions: json['Conditions'] as String?,
    );

Map<String, dynamic> _$SamDayStoreYShoppingDetailDtoToJson(
        SamDayStoreYShoppingDetailDto instance) =>
    <String, dynamic>{
      'Areas': instance.areas,
      'Deadline': instance.deadline,
      'Conditions': instance.conditions,
    };

ExpressStoreYShoppingDetailDto _$ExpressStoreYShoppingDetailDtoFromJson(
        Map<String, dynamic> json) =>
    ExpressStoreYShoppingDetailDto(
      areas: json['Areas'] as String?,
      deadline: json['Deadline'] as String?,
      conditions: json['Conditions'] as String?,
    );

Map<String, dynamic> _$ExpressStoreYShoppingDetailDtoToJson(
        ExpressStoreYShoppingDetailDto instance) =>
    <String, dynamic>{
      'Areas': instance.areas,
      'Deadline': instance.deadline,
      'Conditions': instance.conditions,
    };

OdersYShoppingDetailDto _$OdersYShoppingDetailDtoFromJson(
        Map<String, dynamic> json) =>
    OdersYShoppingDetailDto(
      name: json['Name'] as String?,
      options: (json['Options'] as List<dynamic>?)
          ?.map((e) =>
              OptionOdersYShoppingDetailDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OdersYShoppingDetailDtoToJson(
        OdersYShoppingDetailDto instance) =>
    <String, dynamic>{
      'Name': instance.name,
      'Options': instance.options,
    };

OptionOdersYShoppingDetailDto _$OptionOdersYShoppingDetailDtoFromJson(
        Map<String, dynamic> json) =>
    OptionOdersYShoppingDetailDto(
      value: json['Value'] as String?,
    );

Map<String, dynamic> _$OptionOdersYShoppingDetailDtoToJson(
        OptionOdersYShoppingDetailDto instance) =>
    <String, dynamic>{
      'Value': instance.value,
    };
