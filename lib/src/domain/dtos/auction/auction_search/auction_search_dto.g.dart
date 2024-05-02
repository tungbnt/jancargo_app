// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auction_search_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuctionSearchDto _$AuctionSearchDtoFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['data'],
  );
  return AuctionSearchDto(
    data: json['data'] == null
        ? null
        : AuctionSearchDataDto.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$AuctionSearchDtoToJson(AuctionSearchDto instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

AuctionSearchDataDto _$AuctionSearchDataDtoFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['current_sort', 'results', 'sorters', 'filters'],
  );
  return AuctionSearchDataDto(
    currentSort: json['current_sort'] as String?,
    filtersCount: json['filters_count'] as String?,
    filters: AuctionSearchDataDto._filtersFromJson(json['filters'] as List?),
    results: (json['results'] as List<dynamic>?)
        ?.map((e) => AuctionItemSearchDto.fromJson(e as Map<String, dynamic>))
        .toList(),
    tabs: (json['tabs'] as List<dynamic>?)
        ?.map(
            (e) => TabsAuctionSearchDataDto.fromJson(e as Map<String, dynamic>))
        .toList(),
    sorters: (json['sorters'] as List<dynamic>?)
        ?.map(
            (e) => SortAuctionSearchDataDto.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$AuctionSearchDataDtoToJson(
        AuctionSearchDataDto instance) =>
    <String, dynamic>{
      'current_sort': instance.currentSort,
      'filters_count': instance.filtersCount,
      'tabs': instance.tabs,
      'results': instance.results,
      'sorters': instance.sorters,
      'filters': instance.filters,
    };

TabsAuctionSearchDataDto _$TabsAuctionSearchDataDtoFromJson(
        Map<String, dynamic> json) =>
    TabsAuctionSearchDataDto(
      params: json['params'] as Map<String, dynamic>?,
      count: json['count'],
      isActive: json['is_active'] as bool?,
      label: json['label'] as String?,
    );

Map<String, dynamic> _$TabsAuctionSearchDataDtoToJson(
        TabsAuctionSearchDataDto instance) =>
    <String, dynamic>{
      'label': instance.label,
      'count': instance.count,
      'is_active': instance.isActive,
      'params': instance.params,
    };

SortAuctionSearchDataDto _$SortAuctionSearchDataDtoFromJson(
    Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['header', 'items'],
  );
  return SortAuctionSearchDataDto(
    header: json['header'] as String?,
    items: (json['items'] as List<dynamic>?)
        ?.map((e) =>
            ItemsSortAuctionSearchDataDto.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$SortAuctionSearchDataDtoToJson(
        SortAuctionSearchDataDto instance) =>
    <String, dynamic>{
      'header': instance.header,
      'items': instance.items,
    };

ItemsSortAuctionSearchDataDto _$ItemsSortAuctionSearchDataDtoFromJson(
        Map<String, dynamic> json) =>
    ItemsSortAuctionSearchDataDto(
      label: json['label'] as String?,
      params: json['params'] as Map<String, dynamic>?,
      url: json['url'] as String?,
    );

Map<String, dynamic> _$ItemsSortAuctionSearchDataDtoToJson(
        ItemsSortAuctionSearchDataDto instance) =>
    <String, dynamic>{
      'label': instance.label,
      'params': instance.params,
      'url': instance.url,
    };

AuctionSearchFilterDto _$AuctionSearchFilterDtoFromJson(
    Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['header', 'data_name', 'filters'],
  );
  return AuctionSearchFilterDto(
    fetchDataUrl: json['fetch_data_url'] as String?,
    header: json['header'] as String?,
    dataName: json['data_name'] as String?,
    filters: AuctionSearchFilterDto._filtersFromJson(json['filters'] as List?),
    selected:
        (json['selected'] as List<dynamic>?)?.map((e) => e as int).toList(),
  );
}

Map<String, dynamic> _$AuctionSearchFilterDtoToJson(
        AuctionSearchFilterDto instance) =>
    <String, dynamic>{
      'header': instance.header,
      'data_name': instance.dataName,
      'selected': instance.selected,
      'fetch_data_url': instance.fetchDataUrl,
      'filters': instance.filters,
    };

SingleSelectionAuctionSearchFilterDto
    _$SingleSelectionAuctionSearchFilterDtoFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['header', 'data_name', 'filters'],
  );
  return SingleSelectionAuctionSearchFilterDto(
    header: json['header'] as String?,
    dataName: json['data_name'] as String?,
    filters: AuctionSearchFilterDto._filtersFromJson(json['filters'] as List?),
    fetchDataUrl: json['fetch_data_url'] as String?,
    selected:
        (json['selected'] as List<dynamic>?)?.map((e) => e as int).toList(),
  );
}

Map<String, dynamic> _$SingleSelectionAuctionSearchFilterDtoToJson(
        SingleSelectionAuctionSearchFilterDto instance) =>
    <String, dynamic>{
      'header': instance.header,
      'data_name': instance.dataName,
      'selected': instance.selected,
      'fetch_data_url': instance.fetchDataUrl,
      'filters': instance.filters,
    };

MultipleSelectionAuctionSearchFilterDto
    _$MultipleSelectionAuctionSearchFilterDtoFromJson(
        Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['header', 'data_name', 'filters'],
  );
  return MultipleSelectionAuctionSearchFilterDto(
    header: json['header'] as String?,
    dataName: json['data_name'] as String?,
    filters: AuctionSearchFilterDto._filtersFromJson(json['filters'] as List?),
    fetchDataUrl: json['fetch_data_url'] as String?,
    selected:
        (json['selected'] as List<dynamic>?)?.map((e) => e as int).toList(),
  );
}

Map<String, dynamic> _$MultipleSelectionAuctionSearchFilterDtoToJson(
        MultipleSelectionAuctionSearchFilterDto instance) =>
    <String, dynamic>{
      'header': instance.header,
      'data_name': instance.dataName,
      'selected': instance.selected,
      'fetch_data_url': instance.fetchDataUrl,
      'filters': instance.filters,
    };

OtherOptionsAuctionSearchFilterDto _$OtherOptionsAuctionSearchFilterDtoFromJson(
    Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['header', 'data_name', 'filters'],
  );
  return OtherOptionsAuctionSearchFilterDto(
    header: json['header'] as String?,
    dataName: json['data_name'] as String?,
    filters: AuctionSearchFilterDto._filtersFromJson(json['filters'] as List?),
  );
}

Map<String, dynamic> _$OtherOptionsAuctionSearchFilterDtoToJson(
        OtherOptionsAuctionSearchFilterDto instance) =>
    <String, dynamic>{
      'header': instance.header,
      'data_name': instance.dataName,
      'filters': instance.filters,
    };

CategoryAuctionSearchFilterDto _$CategoryAuctionSearchFilterDtoFromJson(
    Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['header', 'data_name', 'filters'],
  );
  return CategoryAuctionSearchFilterDto(
    header: json['header'] as String?,
    dataName: json['data_name'] as String?,
    filters: AuctionSearchFilterDto._filtersFromJson(json['filters'] as List?),
  );
}

Map<String, dynamic> _$CategoryAuctionSearchFilterDtoToJson(
        CategoryAuctionSearchFilterDto instance) =>
    <String, dynamic>{
      'header': instance.header,
      'data_name': instance.dataName,
      'filters': instance.filters,
    };

ProductPriceAuctionSearchFilterDto _$ProductPriceAuctionSearchFilterDtoFromJson(
    Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['header', 'data_name', 'filters'],
  );
  return ProductPriceAuctionSearchFilterDto(
    header: json['header'] as String?,
    dataName: json['data_name'] as String?,
    filters: AuctionSearchFilterDto._filtersFromJson(json['filters'] as List?),
  );
}

Map<String, dynamic> _$ProductPriceAuctionSearchFilterDtoToJson(
        ProductPriceAuctionSearchFilterDto instance) =>
    <String, dynamic>{
      'header': instance.header,
      'data_name': instance.dataName,
      'filters': instance.filters,
    };

ProducerAuctionSearchFilterDto _$ProducerAuctionSearchFilterDtoFromJson(
    Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['header', 'data_name', 'filters'],
  );
  return ProducerAuctionSearchFilterDto(
    header: json['header'] as String?,
    dataName: json['data_name'] as String?,
    filters: AuctionSearchFilterDto._filtersFromJson(json['filters'] as List?),
    fetchDataUrl: json['fetch_data_url'] as String?,
    selected:
        (json['selected'] as List<dynamic>?)?.map((e) => e as int).toList(),
  );
}

Map<String, dynamic> _$ProducerAuctionSearchFilterDtoToJson(
        ProducerAuctionSearchFilterDto instance) =>
    <String, dynamic>{
      'header': instance.header,
      'data_name': instance.dataName,
      'selected': instance.selected,
      'fetch_data_url': instance.fetchDataUrl,
      'filters': instance.filters,
    };

ProductStatusAuctionSearchFilterDto
    _$ProductStatusAuctionSearchFilterDtoFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['header', 'data_name', 'filters'],
  );
  return ProductStatusAuctionSearchFilterDto(
    header: json['header'] as String?,
    dataName: json['data_name'] as String?,
    filters: AuctionSearchFilterDto._filtersFromJson(json['filters'] as List?),
  );
}

Map<String, dynamic> _$ProductStatusAuctionSearchFilterDtoToJson(
        ProductStatusAuctionSearchFilterDto instance) =>
    <String, dynamic>{
      'header': instance.header,
      'data_name': instance.dataName,
      'filters': instance.filters,
    };

SellerAuctionSearchFilterDto _$SellerAuctionSearchFilterDtoFromJson(
    Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['header', 'data_name', 'filters'],
  );
  return SellerAuctionSearchFilterDto(
    header: json['header'] as String?,
    dataName: json['data_name'] as String?,
    filters: AuctionSearchFilterDto._filtersFromJson(json['filters'] as List?),
  );
}

Map<String, dynamic> _$SellerAuctionSearchFilterDtoToJson(
        SellerAuctionSearchFilterDto instance) =>
    <String, dynamic>{
      'header': instance.header,
      'data_name': instance.dataName,
      'filters': instance.filters,
    };

AuctionSearchFilterItemDto _$AuctionSearchFilterItemDtoFromJson(
        Map<String, dynamic> json) =>
    AuctionSearchFilterItemDto(
      isChildren: json['is_children'] as bool?,
      isActive: AuctionSearchFilterItemDto._selectedActiveFromJson(
          json['is_active'] as bool?),
      url: json['url'] as String?,
      label: json['label'] as String?,
      maxPrice: json['max_price'] as int?,
      params: json['params'] as Map<String, dynamic>?,
      count: json['count'] as int?,
      checked: AuctionSearchFilterItemDto._selectedFromJson(
          json['checked'] as bool?),
    )..filters = (json['filters'] as List<dynamic>?)
        ?.map((e) =>
            AuctionSearchFilterItemDto.fromJson(e as Map<String, dynamic>))
        .toList();

Map<String, dynamic> _$AuctionSearchFilterItemDtoToJson(
        AuctionSearchFilterItemDto instance) =>
    <String, dynamic>{
      'url': instance.url,
      'label': instance.label,
      'count': instance.count,
      'max_price': instance.maxPrice,
      'is_children': instance.isChildren,
      'is_active':
          AuctionSearchFilterItemDto._selectedActiveToJson(instance.isActive),
      'params': instance.params,
      'checked': AuctionSearchFilterItemDto._selectedToJson(instance.checked),
      'filters': instance.filters,
    };

AuctionItemSearchDto _$AuctionItemSearchDtoFromJson(
        Map<String, dynamic> json) =>
    AuctionItemSearchDto(
      code: json['code'] as String?,
      name: json['name'] as String?,
      url: json['url'] as String?,
      image: json['image'] as String?,
      price: json['price'] as int?,
      priceBuy: json['price_buy'],
      endTime: json['end_time'] as String?,
      sellerId: json['seller_id'] as String?,
      bids: json['bids'] as int?,
      neW: json['new'] as bool?,
      used: json['used'] as bool?,
      freeship: json['freeship'] as bool?,
      itemType: json['item_type'] as String?,
    );

Map<String, dynamic> _$AuctionItemSearchDtoToJson(
        AuctionItemSearchDto instance) =>
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
      'new': instance.neW,
      'used': instance.used,
      'freeship': instance.freeship,
      'item_type': instance.itemType,
    };
