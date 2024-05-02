import 'package:json_annotation/json_annotation.dart';

part 'detail_marcari_dto.g.dart';

@JsonSerializable()
class MarcariDetailDto  {
  const MarcariDetailDto( {this.product, this.relates,})
      : super();

  @JsonKey(name: 'product')
  final ProductMarcariDetailDto? product;
  @JsonKey(name: 'relates')
  final List<RelatesMarcariDetailDto>? relates;


  factory MarcariDetailDto.fromJson(Map<String, dynamic> json) =>
      _$MarcariDetailDtoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MarcariDetailDtoToJson(this);
}

@JsonSerializable()
class ProductMarcariDetailDto  {
  const ProductMarcariDetailDto( {this.size,this.id, this.code, this.name, this.description, this.url, this.price, this.status, this.colors, this.condition, this.comments, this.shippingPayer, this.numComment, this.numLike, this.liked, this.image, this.thumbnails, this.seller, this.shippedByWorker, this.shippingClass, this.shippingDuration, this.shippingFromArea, this.shippingMethod, this.category, this.itemType, })
      : super();

  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'code')
  final String? code;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'url')
  final String? url;
  @JsonKey(name: 'price')
  final int? price;
  @JsonKey(name: 'status')
  final String? status;
  @JsonKey(name: 'colors')
  final List<ColorsMarcariDetailDto>? colors;
  @JsonKey(name: 'condition')
  final ConditionMarcariDetailDto? condition;
  @JsonKey(name: 'comments')
  final List<dynamic>? comments;
  @JsonKey(name: 'shipping_payer')
  final ShippingMarcariDetailDto? shippingPayer;
  @JsonKey(name: 'num_comment')
  final int? numComment;
  @JsonKey(name: 'num_like')
  final int? numLike;
  @JsonKey(name: 'liked')
  final bool? liked;
  @JsonKey(name: 'image')
  final String? image;
  @JsonKey(name: 'thumbnails')
  final List<String>? thumbnails;
  @JsonKey(name: 'seller')
  final SellerMarcariDetailDto? seller;
  @JsonKey(name: 'shipped_by_worker')
  final bool? shippedByWorker;
  @JsonKey(name: 'shipping_class')
  final ShippingClassMarcariDetailDto? shippingClass;
  @JsonKey(name: 'size')
  final SizeMarcariDetailDto? size;
  @JsonKey(name: 'shipping_duration')
  final ShippingDurationMarcariDetailDto? shippingDuration;
  @JsonKey(name: 'shipping_from_area')
  final ShippingFromAreaMarcariDetailDto? shippingFromArea;
  @JsonKey(name: 'shipping_method')
  final ShippingMethodMarcariDetailDto? shippingMethod;
  @JsonKey(name: 'category')
  final CategoryMarcariDetailDto? category;
  @JsonKey(name: 'item_type')
  final String? itemType;




  factory ProductMarcariDetailDto.fromJson(Map<String, dynamic> json) =>
      _$ProductMarcariDetailDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ProductMarcariDetailDtoToJson(this);
}

@JsonSerializable()
class ConditionMarcariDetailDto  {
  const ConditionMarcariDetailDto({this.id,this.name})
      : super();

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'name')
  final String? name;



  factory ConditionMarcariDetailDto.fromJson(Map<String, dynamic> json) =>
      _$ConditionMarcariDetailDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ConditionMarcariDetailDtoToJson(this);
}

@JsonSerializable()
class ShippingMarcariDetailDto  {
  const ShippingMarcariDetailDto({this.id,this.name})
      : super();

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'name')
  final String? name;



  factory ShippingMarcariDetailDto.fromJson(Map<String, dynamic> json) =>
      _$ShippingMarcariDetailDtoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ShippingMarcariDetailDtoToJson(this);
}

@JsonSerializable()
class SizeMarcariDetailDto  {
  const SizeMarcariDetailDto({this.id,this.name})
      : super();

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'name')
  final String? name;



  factory SizeMarcariDetailDto.fromJson(Map<String, dynamic> json) =>
      _$SizeMarcariDetailDtoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SizeMarcariDetailDtoToJson(this);
}


@JsonSerializable()
class SellerMarcariDetailDto  {
  const SellerMarcariDetailDto( {this.id, this.name, this.photoUrl, this.photoThumbnailUrl, this.registerSmsConfirmation, this.registerSmsConfirmationAt, this.created, this.numSellItems, this.ratings, this.numRatings, this.score, this.isOfficial, this.quickShipper, this.starRatingScore,})
      : super();

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'photo_url')
  final String? photoUrl;
  @JsonKey(name: 'photo_thumbnail_url')
  final String? photoThumbnailUrl;
  @JsonKey(name: 'register_sms_confirmation')
  final String? registerSmsConfirmation;
  @JsonKey(name: 'register_sms_confirmation_at')
  final String? registerSmsConfirmationAt;
  @JsonKey(name: 'created')
  final int? created;
  @JsonKey(name: 'num_sell_items')
  final int? numSellItems;
  @JsonKey(name: 'ratings')
  final RatingsMarcariDetailDto? ratings;
  @JsonKey(name: 'num_ratings')
  final int? numRatings;
  @JsonKey(name: 'score')
  final int? score;
  @JsonKey(name: 'is_official')
  final bool? isOfficial;
  @JsonKey(name: 'quick_shipper')
  final bool? quickShipper;
  @JsonKey(name: 'star_rating_score')
  final int? starRatingScore;



  factory SellerMarcariDetailDto.fromJson(Map<String, dynamic> json) =>
      _$SellerMarcariDetailDtoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SellerMarcariDetailDtoToJson(this);
}

@JsonSerializable()
class ShippingClassMarcariDetailDto  {
  const ShippingClassMarcariDetailDto( {this.id, this.fee, this.iconId, this.pickupFee, this.shippingFee, this.totalFee, this.isPickup,})
      : super();

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'fee')
  final int? fee;
  @JsonKey(name: 'icon_id')
  final int? iconId;
  @JsonKey(name: 'pickup_fee')
  final int? pickupFee;
  @JsonKey(name: 'shipping_fee')
  final int? shippingFee;
  @JsonKey(name: 'total_fee')
  final int? totalFee;
  @JsonKey(name: 'is_pickup')
  final bool? isPickup;



  factory ShippingClassMarcariDetailDto.fromJson(Map<String, dynamic> json) =>
      _$ShippingClassMarcariDetailDtoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ShippingClassMarcariDetailDtoToJson(this);
}

@JsonSerializable()
class ShippingDurationMarcariDetailDto  {
  const ShippingDurationMarcariDetailDto({this.minDays, this.maxDays, this.id,this.name})
      : super();

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'min_days')
  final int? minDays;
  @JsonKey(name: 'max_days')
  final int? maxDays;



  factory ShippingDurationMarcariDetailDto.fromJson(Map<String, dynamic> json) =>
      _$ShippingDurationMarcariDetailDtoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ShippingDurationMarcariDetailDtoToJson(this);
}

@JsonSerializable()
class ShippingFromAreaMarcariDetailDto  {
  const ShippingFromAreaMarcariDetailDto({this.id,this.name})
      : super();

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'name')
  final String? name;



  factory ShippingFromAreaMarcariDetailDto.fromJson(Map<String, dynamic> json) =>
      _$ShippingFromAreaMarcariDetailDtoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ShippingFromAreaMarcariDetailDtoToJson(this);
}

@JsonSerializable()
class ShippingMethodMarcariDetailDto  {
  const ShippingMethodMarcariDetailDto({this.id,this.name,this.isDeprecated})
      : super();

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'is_deprecated')
  final String? isDeprecated;



  factory ShippingMethodMarcariDetailDto.fromJson(Map<String, dynamic> json) =>
      _$ShippingMethodMarcariDetailDtoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ShippingMethodMarcariDetailDtoToJson(this);
}
@JsonSerializable()
class CategoryMarcariDetailDto  {
  const CategoryMarcariDetailDto( {this.id, this.name, this.displayOrder, this.parentCategoryId, this.parentCategoryName, this.rootCategoryId, this.rootCategoryName,})
      : super();

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'display_order')
  final int? displayOrder;
  @JsonKey(name: 'parent_category_id')
  final int? parentCategoryId;
  @JsonKey(name: 'parent_category_name')
  final String? parentCategoryName;
  @JsonKey(name: 'root_category_id')
  final int? rootCategoryId;
  @JsonKey(name: 'root_category_name')
  final String? rootCategoryName;



  factory CategoryMarcariDetailDto.fromJson(Map<String, dynamic> json) =>
      _$CategoryMarcariDetailDtoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CategoryMarcariDetailDtoToJson(this);
}

@JsonSerializable()
class RatingsMarcariDetailDto  {
  const RatingsMarcariDetailDto({this.good, this.normal, this.bad, })
      : super();

  @JsonKey(name: 'good')
  final int? good;
  @JsonKey(name: 'normal')
  final int? normal;
  @JsonKey(name: 'bad')
  final int? bad;



  factory RatingsMarcariDetailDto.fromJson(Map<String, dynamic> json) =>
      _$RatingsMarcariDetailDtoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$RatingsMarcariDetailDtoToJson(this);
}

@JsonSerializable()
class RelatesMarcariDetailDto  {
  const RelatesMarcariDetailDto( {this.id, this.code, this.name, this.image, this.price, this.numComments, this.numLikes, this.pagerId, this.status, this.url, this.item_type,})
      : super();

  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'code')
  final String? code;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'image')
  final String? image;
  @JsonKey(name: 'price')
  final int? price;
  @JsonKey(name: 'num_comments')
  final int? numComments;
  @JsonKey(name: 'num_likes')
  final int? numLikes;
  @JsonKey(name: 'pager_id')
  final int? pagerId;
  @JsonKey(name: 'status')
  final String? status;
  @JsonKey(name: 'url')
  final String? url;
  @JsonKey(name: 'item_type')
  final String? item_type;



  factory RelatesMarcariDetailDto.fromJson(Map<String, dynamic> json) =>
      _$RelatesMarcariDetailDtoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$RelatesMarcariDetailDtoToJson(this);
}

@JsonSerializable()
class ColorsMarcariDetailDto  {
  const ColorsMarcariDetailDto({this.rgb, this.id, this.name,})
      : super();

  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'rgb')
  final String? rgb;


  factory ColorsMarcariDetailDto.fromJson(Map<String, dynamic> json) =>
      _$ColorsMarcariDetailDtoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ColorsMarcariDetailDtoToJson(this);
}