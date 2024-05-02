// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_marcari_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MarcariDetailDto _$MarcariDetailDtoFromJson(Map<String, dynamic> json) =>
    MarcariDetailDto(
      product: json['product'] == null
          ? null
          : ProductMarcariDetailDto.fromJson(
              json['product'] as Map<String, dynamic>),
      relates: (json['relates'] as List<dynamic>?)
          ?.map((e) =>
              RelatesMarcariDetailDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MarcariDetailDtoToJson(MarcariDetailDto instance) =>
    <String, dynamic>{
      'product': instance.product,
      'relates': instance.relates,
    };

ProductMarcariDetailDto _$ProductMarcariDetailDtoFromJson(
        Map<String, dynamic> json) =>
    ProductMarcariDetailDto(
      size: json['size'] == null
          ? null
          : SizeMarcariDetailDto.fromJson(json['size'] as Map<String, dynamic>),
      id: json['id'] as String?,
      code: json['code'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      url: json['url'] as String?,
      price: json['price'] as int?,
      status: json['status'] as String?,
      colors: (json['colors'] as List<dynamic>?)
          ?.map(
              (e) => ColorsMarcariDetailDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      condition: json['condition'] == null
          ? null
          : ConditionMarcariDetailDto.fromJson(
              json['condition'] as Map<String, dynamic>),
      comments: json['comments'] as List<dynamic>?,
      shippingPayer: json['shipping_payer'] == null
          ? null
          : ShippingMarcariDetailDto.fromJson(
              json['shipping_payer'] as Map<String, dynamic>),
      numComment: json['num_comment'] as int?,
      numLike: json['num_like'] as int?,
      liked: json['liked'] as bool?,
      image: json['image'] as String?,
      thumbnails: (json['thumbnails'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      seller: json['seller'] == null
          ? null
          : SellerMarcariDetailDto.fromJson(
              json['seller'] as Map<String, dynamic>),
      shippedByWorker: json['shipped_by_worker'] as bool?,
      shippingClass: json['shipping_class'] == null
          ? null
          : ShippingClassMarcariDetailDto.fromJson(
              json['shipping_class'] as Map<String, dynamic>),
      shippingDuration: json['shipping_duration'] == null
          ? null
          : ShippingDurationMarcariDetailDto.fromJson(
              json['shipping_duration'] as Map<String, dynamic>),
      shippingFromArea: json['shipping_from_area'] == null
          ? null
          : ShippingFromAreaMarcariDetailDto.fromJson(
              json['shipping_from_area'] as Map<String, dynamic>),
      shippingMethod: json['shipping_method'] == null
          ? null
          : ShippingMethodMarcariDetailDto.fromJson(
              json['shipping_method'] as Map<String, dynamic>),
      category: json['category'] == null
          ? null
          : CategoryMarcariDetailDto.fromJson(
              json['category'] as Map<String, dynamic>),
      itemType: json['item_type'] as String?,
    );

Map<String, dynamic> _$ProductMarcariDetailDtoToJson(
        ProductMarcariDetailDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'name': instance.name,
      'description': instance.description,
      'url': instance.url,
      'price': instance.price,
      'status': instance.status,
      'colors': instance.colors,
      'condition': instance.condition,
      'comments': instance.comments,
      'shipping_payer': instance.shippingPayer,
      'num_comment': instance.numComment,
      'num_like': instance.numLike,
      'liked': instance.liked,
      'image': instance.image,
      'thumbnails': instance.thumbnails,
      'seller': instance.seller,
      'shipped_by_worker': instance.shippedByWorker,
      'shipping_class': instance.shippingClass,
      'size': instance.size,
      'shipping_duration': instance.shippingDuration,
      'shipping_from_area': instance.shippingFromArea,
      'shipping_method': instance.shippingMethod,
      'category': instance.category,
      'item_type': instance.itemType,
    };

ConditionMarcariDetailDto _$ConditionMarcariDetailDtoFromJson(
        Map<String, dynamic> json) =>
    ConditionMarcariDetailDto(
      id: json['id'] as int?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$ConditionMarcariDetailDtoToJson(
        ConditionMarcariDetailDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

ShippingMarcariDetailDto _$ShippingMarcariDetailDtoFromJson(
        Map<String, dynamic> json) =>
    ShippingMarcariDetailDto(
      id: json['id'] as int?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$ShippingMarcariDetailDtoToJson(
        ShippingMarcariDetailDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

SizeMarcariDetailDto _$SizeMarcariDetailDtoFromJson(
        Map<String, dynamic> json) =>
    SizeMarcariDetailDto(
      id: json['id'] as int?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$SizeMarcariDetailDtoToJson(
        SizeMarcariDetailDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

SellerMarcariDetailDto _$SellerMarcariDetailDtoFromJson(
        Map<String, dynamic> json) =>
    SellerMarcariDetailDto(
      id: json['id'] as int?,
      name: json['name'] as String?,
      photoUrl: json['photo_url'] as String?,
      photoThumbnailUrl: json['photo_thumbnail_url'] as String?,
      registerSmsConfirmation: json['register_sms_confirmation'] as String?,
      registerSmsConfirmationAt:
          json['register_sms_confirmation_at'] as String?,
      created: json['created'] as int?,
      numSellItems: json['num_sell_items'] as int?,
      ratings: json['ratings'] == null
          ? null
          : RatingsMarcariDetailDto.fromJson(
              json['ratings'] as Map<String, dynamic>),
      numRatings: json['num_ratings'] as int?,
      score: json['score'] as int?,
      isOfficial: json['is_official'] as bool?,
      quickShipper: json['quick_shipper'] as bool?,
      starRatingScore: json['star_rating_score'] as int?,
    );

Map<String, dynamic> _$SellerMarcariDetailDtoToJson(
        SellerMarcariDetailDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'photo_url': instance.photoUrl,
      'photo_thumbnail_url': instance.photoThumbnailUrl,
      'register_sms_confirmation': instance.registerSmsConfirmation,
      'register_sms_confirmation_at': instance.registerSmsConfirmationAt,
      'created': instance.created,
      'num_sell_items': instance.numSellItems,
      'ratings': instance.ratings,
      'num_ratings': instance.numRatings,
      'score': instance.score,
      'is_official': instance.isOfficial,
      'quick_shipper': instance.quickShipper,
      'star_rating_score': instance.starRatingScore,
    };

ShippingClassMarcariDetailDto _$ShippingClassMarcariDetailDtoFromJson(
        Map<String, dynamic> json) =>
    ShippingClassMarcariDetailDto(
      id: json['id'] as int?,
      fee: json['fee'] as int?,
      iconId: json['icon_id'] as int?,
      pickupFee: json['pickup_fee'] as int?,
      shippingFee: json['shipping_fee'] as int?,
      totalFee: json['total_fee'] as int?,
      isPickup: json['is_pickup'] as bool?,
    );

Map<String, dynamic> _$ShippingClassMarcariDetailDtoToJson(
        ShippingClassMarcariDetailDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fee': instance.fee,
      'icon_id': instance.iconId,
      'pickup_fee': instance.pickupFee,
      'shipping_fee': instance.shippingFee,
      'total_fee': instance.totalFee,
      'is_pickup': instance.isPickup,
    };

ShippingDurationMarcariDetailDto _$ShippingDurationMarcariDetailDtoFromJson(
        Map<String, dynamic> json) =>
    ShippingDurationMarcariDetailDto(
      minDays: json['min_days'] as int?,
      maxDays: json['max_days'] as int?,
      id: json['id'] as int?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$ShippingDurationMarcariDetailDtoToJson(
        ShippingDurationMarcariDetailDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'min_days': instance.minDays,
      'max_days': instance.maxDays,
    };

ShippingFromAreaMarcariDetailDto _$ShippingFromAreaMarcariDetailDtoFromJson(
        Map<String, dynamic> json) =>
    ShippingFromAreaMarcariDetailDto(
      id: json['id'] as int?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$ShippingFromAreaMarcariDetailDtoToJson(
        ShippingFromAreaMarcariDetailDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

ShippingMethodMarcariDetailDto _$ShippingMethodMarcariDetailDtoFromJson(
        Map<String, dynamic> json) =>
    ShippingMethodMarcariDetailDto(
      id: json['id'] as int?,
      name: json['name'] as String?,
      isDeprecated: json['is_deprecated'] as String?,
    );

Map<String, dynamic> _$ShippingMethodMarcariDetailDtoToJson(
        ShippingMethodMarcariDetailDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'is_deprecated': instance.isDeprecated,
    };

CategoryMarcariDetailDto _$CategoryMarcariDetailDtoFromJson(
        Map<String, dynamic> json) =>
    CategoryMarcariDetailDto(
      id: json['id'] as int?,
      name: json['name'] as String?,
      displayOrder: json['display_order'] as int?,
      parentCategoryId: json['parent_category_id'] as int?,
      parentCategoryName: json['parent_category_name'] as String?,
      rootCategoryId: json['root_category_id'] as int?,
      rootCategoryName: json['root_category_name'] as String?,
    );

Map<String, dynamic> _$CategoryMarcariDetailDtoToJson(
        CategoryMarcariDetailDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'display_order': instance.displayOrder,
      'parent_category_id': instance.parentCategoryId,
      'parent_category_name': instance.parentCategoryName,
      'root_category_id': instance.rootCategoryId,
      'root_category_name': instance.rootCategoryName,
    };

RatingsMarcariDetailDto _$RatingsMarcariDetailDtoFromJson(
        Map<String, dynamic> json) =>
    RatingsMarcariDetailDto(
      good: json['good'] as int?,
      normal: json['normal'] as int?,
      bad: json['bad'] as int?,
    );

Map<String, dynamic> _$RatingsMarcariDetailDtoToJson(
        RatingsMarcariDetailDto instance) =>
    <String, dynamic>{
      'good': instance.good,
      'normal': instance.normal,
      'bad': instance.bad,
    };

RelatesMarcariDetailDto _$RelatesMarcariDetailDtoFromJson(
        Map<String, dynamic> json) =>
    RelatesMarcariDetailDto(
      id: json['id'] as String?,
      code: json['code'] as String?,
      name: json['name'] as String?,
      image: json['image'] as String?,
      price: json['price'] as int?,
      numComments: json['num_comments'] as int?,
      numLikes: json['num_likes'] as int?,
      pagerId: json['pager_id'] as int?,
      status: json['status'] as String?,
      url: json['url'] as String?,
      item_type: json['item_type'] as String?,
    );

Map<String, dynamic> _$RelatesMarcariDetailDtoToJson(
        RelatesMarcariDetailDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'name': instance.name,
      'image': instance.image,
      'price': instance.price,
      'num_comments': instance.numComments,
      'num_likes': instance.numLikes,
      'pager_id': instance.pagerId,
      'status': instance.status,
      'url': instance.url,
      'item_type': instance.item_type,
    };

ColorsMarcariDetailDto _$ColorsMarcariDetailDtoFromJson(
        Map<String, dynamic> json) =>
    ColorsMarcariDetailDto(
      rgb: json['rgb'] as String?,
      id: json['id'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$ColorsMarcariDetailDtoToJson(
        ColorsMarcariDetailDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'rgb': instance.rgb,
    };
