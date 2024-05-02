// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_shopping_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchShoppingDto _$SearchShoppingDtoFromJson(Map<String, dynamic> json) =>
    SearchShoppingDto(
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => ItemsShoppingDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      pagination: json['pagination'] == null
          ? null
          : PaginationDto.fromJson(json['pagination'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SearchShoppingDtoToJson(SearchShoppingDto instance) =>
    <String, dynamic>{
      'results': instance.results,
      'pagination': instance.pagination,
    };

ItemsShoppingDto _$ItemsShoppingDtoFromJson(Map<String, dynamic> json) =>
    ItemsShoppingDto(
      isItemSavedCart: json['isItemSavedCart'] as bool?,
      code: json['code'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      category: json['category'] == null
          ? null
          : CategoriesDto.fromJson(json['category'] as Map<String, dynamic>),
      brand: json['brand'] == null
          ? null
          : BrandDto.fromJson(json['brand'] as Map<String, dynamic>),
      stock: json['stock'] as bool?,
      price: json['price'] as int?,
      priceLabel: json['priceLabel'] == null
          ? null
          : PriceLabelDto.fromJson(json['priceLabel'] as Map<String, dynamic>),
      releaseDate: json['releaseDate'] as int?,
      review: json['review'] == null
          ? null
          : ReviewedDto.fromJson(json['review'] as Map<String, dynamic>),
      seller: json['seller'] == null
          ? null
          : SellerDto.fromJson(json['seller'] as Map<String, dynamic>),
      url: json['url'] as String?,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$ItemsShoppingDtoToJson(ItemsShoppingDto instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'description': instance.description,
      'category': instance.category,
      'brand': instance.brand,
      'stock': instance.stock,
      'isItemSavedCart': instance.isItemSavedCart,
      'price': instance.price,
      'priceLabel': instance.priceLabel,
      'releaseDate': instance.releaseDate,
      'review': instance.review,
      'seller': instance.seller,
      'url': instance.url,
      'image': instance.image,
    };

CategoriesDto _$CategoriesDtoFromJson(Map<String, dynamic> json) =>
    CategoriesDto(
      id: json['id'] as int?,
      name: json['name'] as String?,
      depth: json['depth'] as int?,
    );

Map<String, dynamic> _$CategoriesDtoToJson(CategoriesDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'depth': instance.depth,
    };

BrandDto _$BrandDtoFromJson(Map<String, dynamic> json) => BrandDto(
      id: (json['id'] as num?)?.toDouble(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$BrandDtoToJson(BrandDto instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

PriceLabelDto _$PriceLabelDtoFromJson(Map<String, dynamic> json) =>
    PriceLabelDto(
      taxable: json['taxable'] as bool?,
      defaultPrice: json['defaultPrice'] as int?,
      discountedPrice: json['discountedPrice'] as int?,
      fixedPrice: json['fixedPrice'] as int?,
      premiumPrice: json['premiumPrice'] as int?,
      periodStart: json['periodStart'] as int?,
      periodEnd: json['periodEnd'] as int?,
    );

Map<String, dynamic> _$PriceLabelDtoToJson(PriceLabelDto instance) =>
    <String, dynamic>{
      'taxable': instance.taxable,
      'defaultPrice': instance.defaultPrice,
      'discountedPrice': instance.discountedPrice,
      'fixedPrice': instance.fixedPrice,
      'premiumPrice': instance.premiumPrice,
      'periodStart': instance.periodStart,
      'periodEnd': instance.periodEnd,
    };

ReviewedDto _$ReviewedDtoFromJson(Map<String, dynamic> json) => ReviewedDto(
      count: json['count'] as int?,
      url: json['url'] as String?,
      rate: (json['rate'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ReviewedDtoToJson(ReviewedDto instance) =>
    <String, dynamic>{
      'count': instance.count,
      'url': instance.url,
      'rate': instance.rate,
    };

SellerDto _$SellerDtoFromJson(Map<String, dynamic> json) => SellerDto(
      sellerId: json['sellerId'] as String?,
      name: json['name'] as String?,
      url: json['url'] as String?,
      isBestSeller: json['isBestSeller'] as bool?,
      review: json['review'] == null
          ? null
          : ReviewSellerDto.fromJson(json['review'] as Map<String, dynamic>),
      imageId: json['imageId'] as String?,
    );

Map<String, dynamic> _$SellerDtoToJson(SellerDto instance) => <String, dynamic>{
      'sellerId': instance.sellerId,
      'name': instance.name,
      'url': instance.url,
      'isBestSeller': instance.isBestSeller,
      'review': instance.review,
      'imageId': instance.imageId,
    };

ReviewSellerDto _$ReviewSellerDtoFromJson(Map<String, dynamic> json) =>
    ReviewSellerDto(
      count: json['count'] as int?,
      rate: (json['rate'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ReviewSellerDtoToJson(ReviewSellerDto instance) =>
    <String, dynamic>{
      'rate': instance.rate,
      'count': instance.count,
    };

PaginationDto _$PaginationDtoFromJson(Map<String, dynamic> json) =>
    PaginationDto(
      size: json['size'] as int?,
      page: json['page'] as int?,
      total: json['total'] as int?,
    );

Map<String, dynamic> _$PaginationDtoToJson(PaginationDto instance) =>
    <String, dynamic>{
      'size': instance.size,
      'page': instance.page,
      'total': instance.total,
    };
