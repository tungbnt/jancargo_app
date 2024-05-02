// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'producer_search_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProducerSearchDto _$ProducerSearchDtoFromJson(Map<String, dynamic> json) =>
    ProducerSearchDto(
      brand: json['brand'] == null
          ? null
          : BrandProducerSearchDto.fromJson(
              json['brand'] as Map<String, dynamic>),
      price: json['price'] == null
          ? null
          : PriceProducerSearchDto.fromJson(
              json['price'] as Map<String, dynamic>),
      category: json['category'] == null
          ? null
          : CategoryProducerSearchDto.fromJson(
              json['category'] as Map<String, dynamic>),
      initialBrand: json['initialBrand'] == null
          ? null
          : InitialBrandProducerSearchDto.fromJson(
              json['initialBrand'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProducerSearchDtoToJson(ProducerSearchDto instance) =>
    <String, dynamic>{
      'brand': instance.brand,
      'price': instance.price,
      'category': instance.category,
      'initialBrand': instance.initialBrand,
    };

BrandProducerSearchDto _$BrandProducerSearchDtoFromJson(
        Map<String, dynamic> json) =>
    BrandProducerSearchDto(
      path: json['path'] as List<dynamic>?,
      childDepth: json['childDepth'] as int?,
      children: (json['children'] as List<dynamic>?)
          ?.map((e) => ChildrenBrandProducerSearchDto.fromJson(
              e as Map<String, dynamic>))
          .toList(),
      brand1: json['brand1'] as List<dynamic>?,
    );

Map<String, dynamic> _$BrandProducerSearchDtoToJson(
        BrandProducerSearchDto instance) =>
    <String, dynamic>{
      'brand1': instance.brand1,
      'path': instance.path,
      'childDepth': instance.childDepth,
      'children': instance.children,
    };

ChildrenBrandProducerSearchDto _$ChildrenBrandProducerSearchDtoFromJson(
        Map<String, dynamic> json) =>
    ChildrenBrandProducerSearchDto(
      path: json['path'] as List<dynamic>?,
      auctions: json['auctions'] == null
          ? null
          : AuctionsChildrenBrandProducerSearchDto.fromJson(
              json['auctions'] as Map<String, dynamic>),
      count: json['count'] as int?,
      englishName: json['englishName'] as String?,
      id: json['id'] as int?,
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      kanaName: json['kanaName'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$ChildrenBrandProducerSearchDtoToJson(
        ChildrenBrandProducerSearchDto instance) =>
    <String, dynamic>{
      'count': instance.count,
      'englishName': instance.englishName,
      'id': instance.id,
      'kanaName': instance.kanaName,
      'name': instance.name,
      'auctions': instance.auctions,
      'images': instance.images,
      'path': instance.path,
    };

AuctionsChildrenBrandProducerSearchDto
    _$AuctionsChildrenBrandProducerSearchDtoFromJson(
            Map<String, dynamic> json) =>
        AuctionsChildrenBrandProducerSearchDto(
          images: json['images'] as List<dynamic>?,
        );

Map<String, dynamic> _$AuctionsChildrenBrandProducerSearchDtoToJson(
        AuctionsChildrenBrandProducerSearchDto instance) =>
    <String, dynamic>{
      'images': instance.images,
    };

CategoryProducerSearchDto _$CategoryProducerSearchDtoFromJson(
        Map<String, dynamic> json) =>
    CategoryProducerSearchDto(
      current: json['current'] == null
          ? null
          : CurrentCategoryProducerSearchDto.fromJson(
              json['current'] as Map<String, dynamic>),
      parent: json['parent'] == null
          ? null
          : ParentCategoryProducerSearchDto.fromJson(
              json['parent'] as Map<String, dynamic>),
      children: json['children'] as List<dynamic>?,
    );

Map<String, dynamic> _$CategoryProducerSearchDtoToJson(
        CategoryProducerSearchDto instance) =>
    <String, dynamic>{
      'children': instance.children,
      'current': instance.current,
      'parent': instance.parent,
    };

CurrentCategoryProducerSearchDto _$CurrentCategoryProducerSearchDtoFromJson(
        Map<String, dynamic> json) =>
    CurrentCategoryProducerSearchDto(
      id: json['id'] as int?,
      name: json['name'] as String?,
      depth: json['depth'] as int?,
      count: json['count'] as int?,
      isLeaf: json['isLeaf'] as bool?,
    );

Map<String, dynamic> _$CurrentCategoryProducerSearchDtoToJson(
        CurrentCategoryProducerSearchDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'depth': instance.depth,
      'count': instance.count,
      'isLeaf': instance.isLeaf,
    };

ParentCategoryProducerSearchDto _$ParentCategoryProducerSearchDtoFromJson(
        Map<String, dynamic> json) =>
    ParentCategoryProducerSearchDto(
      id: json['id'] as int?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$ParentCategoryProducerSearchDtoToJson(
        ParentCategoryProducerSearchDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

InitialBrandProducerSearchDto _$InitialBrandProducerSearchDtoFromJson(
        Map<String, dynamic> json) =>
    InitialBrandProducerSearchDto(
      initials: (json['initials'] as List<dynamic>?)
          ?.map((e) => InitialBrandItemsProducerSearchDto.fromJson(
              e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$InitialBrandProducerSearchDtoToJson(
        InitialBrandProducerSearchDto instance) =>
    <String, dynamic>{
      'initials': instance.initials,
    };

InitialBrandItemsProducerSearchDto _$InitialBrandItemsProducerSearchDtoFromJson(
        Map<String, dynamic> json) =>
    InitialBrandItemsProducerSearchDto(
      character: json['character'] as String?,
      children: (json['children'] as List<dynamic>?)
          ?.map((e) => InitialBrandChildrenItemProducerSearchDto.fromJson(
              e as Map<String, dynamic>))
          .toList(),
      count: json['count'] as int?,
    );

Map<String, dynamic> _$InitialBrandItemsProducerSearchDtoToJson(
        InitialBrandItemsProducerSearchDto instance) =>
    <String, dynamic>{
      'character': instance.character,
      'children': instance.children,
      'count': instance.count,
    };

InitialBrandChildrenItemProducerSearchDto
    _$InitialBrandChildrenItemProducerSearchDtoFromJson(
            Map<String, dynamic> json) =>
        InitialBrandChildrenItemProducerSearchDto(
          englishName: json['englishName'] as String?,
          id: json['id'] as int?,
          kanaName: json['kanaName'] as String?,
          name: json['name'] as String?,
          count: json['count'] as int?,
        );

Map<String, dynamic> _$InitialBrandChildrenItemProducerSearchDtoToJson(
        InitialBrandChildrenItemProducerSearchDto instance) =>
    <String, dynamic>{
      'count': instance.count,
      'englishName': instance.englishName,
      'id': instance.id,
      'kanaName': instance.kanaName,
      'name': instance.name,
    };

PriceProducerSearchDto _$PriceProducerSearchDtoFromJson(
        Map<String, dynamic> json) =>
    PriceProducerSearchDto(
      ranges: json['ranges'] as List<dynamic>?,
    );

Map<String, dynamic> _$PriceProducerSearchDtoToJson(
        PriceProducerSearchDto instance) =>
    <String, dynamic>{
      'ranges': instance.ranges,
    };

ShoppingSpecsProducerSearchDto _$ShoppingSpecsProducerSearchDtoFromJson(
        Map<String, dynamic> json) =>
    ShoppingSpecsProducerSearchDto(
      ranges: json['ranges'] as List<dynamic>?,
    );

Map<String, dynamic> _$ShoppingSpecsProducerSearchDtoToJson(
        ShoppingSpecsProducerSearchDto instance) =>
    <String, dynamic>{
      'ranges': instance.ranges,
    };
