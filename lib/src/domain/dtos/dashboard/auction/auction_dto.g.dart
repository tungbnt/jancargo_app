// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auction_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuctionDto _$AuctionDtoFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['results', 'pagination'],
  );
  return AuctionDto(
    category: json['category'] as String?,
    todayEnds: (json['today_ends'] as List<dynamic>?)
        ?.map((e) => e as String)
        .toList(),
    results: (json['results'] as List<dynamic>?)
        ?.map((e) => AuctionItemsDto.fromJson(e as Map<String, dynamic>))
        .toList(),
    pagination: json['pagination'] == null
        ? null
        : PaginationDto.fromJson(json['pagination'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$AuctionDtoToJson(AuctionDto instance) =>
    <String, dynamic>{
      'results': instance.results,
      'category': instance.category,
      'pagination': instance.pagination,
      'today_ends': instance.todayEnds,
    };

AuctionItemsDto _$AuctionItemsDtoFromJson(Map<String, dynamic> json) =>
    AuctionItemsDto(
      AuctionItemsDto._favoriteFromJson(json['favorite'] as bool?),
      code: json['code'] as String?,
      name: json['name'] as String?,
      url: json['url'] as String?,
      image: json['image'] as String?,
      price: json['price'] as int?,
      priceBuy: json['price_buy'],
      endTime: json['end_time'] as String?,
      sellerId: json['seller_id'] as String?,
      bids: json['bids'] as String?,
      newW: json['newW'] as bool?,
      used: json['used'] as bool?,
      freeShip: json['freeship'] as bool?,
    );

Map<String, dynamic> _$AuctionItemsDtoToJson(AuctionItemsDto instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'url': instance.url,
      'image': instance.image,
      'price': instance.price,
      'price_buy': instance.priceBuy,
      'end_time': instance.endTime,
      'seller_id': instance.sellerId,
      'bids': instance.bids,
      'newW': instance.newW,
      'used': instance.used,
      'favorite': AuctionItemsDto._favoriteToJson(instance.favorite),
      'freeship': instance.freeShip,
    };

PaginationDto _$PaginationDtoFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['size', 'page', 'total'],
  );
  return PaginationDto(
    size: json['size'] as int?,
    page: json['page'] as int?,
    total: json['total'] as int?,
  );
}

Map<String, dynamic> _$PaginationDtoToJson(PaginationDto instance) =>
    <String, dynamic>{
      'size': instance.size,
      'page': instance.page,
      'total': instance.total,
    };

PageRenderDto _$PageRenderDtoFromJson(Map<String, dynamic> json) =>
    PageRenderDto(
      page: json['page'] as String?,
      disabled: json['disabled'] as bool?,
    );

Map<String, dynamic> _$PageRenderDtoToJson(PageRenderDto instance) =>
    <String, dynamic>{
      'page': instance.page,
      'disabled': instance.disabled,
    };

CategoriesDto _$CategoriesDtoFromJson(Map<String, dynamic> json) =>
    CategoriesDto(
      href: json['href'] as String?,
      text: json['text'] as String?,
      vModule: json['_cl_vmodule'] as String?,
      clLink: json['_cl_link'] as String?,
      catId: json['catid'] as String?,
    );

Map<String, dynamic> _$CategoriesDtoToJson(CategoriesDto instance) =>
    <String, dynamic>{
      'href': instance.href,
      'text': instance.text,
      '_cl_vmodule': instance.vModule,
      '_cl_link': instance.clLink,
      'catid': instance.catId,
    };

PopularBrandsDto _$PopularBrandsDtoFromJson(Map<String, dynamic> json) =>
    PopularBrandsDto(
      title: json['title'] as String?,
      image: json['image'] as String?,
      originUrl: json['origin_url'] as String?,
      query: json['query'] == null
          ? null
          : QueryDto.fromJson(json['query'] as Map<String, dynamic>),
      category: json['category'] as String?,
    );

Map<String, dynamic> _$PopularBrandsDtoToJson(PopularBrandsDto instance) =>
    <String, dynamic>{
      'title': instance.title,
      'image': instance.image,
      'origin_url': instance.originUrl,
      'query': instance.query,
      'category': instance.category,
    };

QueryDto _$QueryDtoFromJson(Map<String, dynamic> json) => QueryDto(
      brandId: json['brand_id'] as String?,
    );

Map<String, dynamic> _$QueryDtoToJson(QueryDto instance) => <String, dynamic>{
      'brand_id': instance.brandId,
    };
