import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auction_search_dto.g.dart';

@JsonSerializable()
class AuctionSearchDto {
  const AuctionSearchDto({
    this.data,
  }) : super();

  @JsonKey(required: true, name: 'data')
  final AuctionSearchDataDto? data;

  factory AuctionSearchDto.fromJson(Map<String, dynamic> json) => _$AuctionSearchDtoFromJson(json);
}

@JsonSerializable()
class AuctionSearchDataDto {
  const AuctionSearchDataDto({
    this.currentSort,
    this.filtersCount,
    this.filters,
    this.results,
    this.tabs,
    this.sorters,
  }) : super();
  @JsonKey(required: true, name: 'current_sort')
  final String? currentSort;
  @JsonKey(name: 'filters_count')
  final String? filtersCount;
  @JsonKey(name: 'tabs')
  final List<TabsAuctionSearchDataDto>? tabs;
  @JsonKey(required: true, name: 'results')
  final List<AuctionItemSearchDto>? results;
  @JsonKey(required: true, name: 'sorters')
  final List<SortAuctionSearchDataDto>? sorters;
  @JsonKey(required: true, name: 'filters', fromJson: _filtersFromJson)
  final List<AuctionSearchFilterDto>? filters;

  static List<AuctionSearchFilterDto>? _filtersFromJson(
      List<dynamic>? value,
      ) {
    print("object value $value");
    return value
        ?.map((e) {
      print("object value e $e");

      return AuctionSearchFilterDto.fromJson(e as Map<String, dynamic>);
    })
        .whereType<AuctionSearchFilterDto>()
        .toList();
  }

  factory AuctionSearchDataDto.fromJson(Map<String, dynamic> json) => _$AuctionSearchDataDtoFromJson(json);

  Map<String, dynamic>? getFilterParams() {
    if (filters == null) return null;
    return {
      for (final e in filters!) ...?e.getParams(),
    };
  }
}

@JsonSerializable()
class TabsAuctionSearchDataDto {
  const TabsAuctionSearchDataDto( {this.params,
    this.count,
    this.isActive,
    this.label,
  }) : super();

  @JsonKey(name: 'label')
  final String? label;
  @JsonKey(name: 'count')
  final dynamic count;
  @JsonKey(name: 'is_active')
  final bool? isActive;
  @JsonKey(name: 'params')
  final Map<String, dynamic>? params;

  factory TabsAuctionSearchDataDto.fromJson(Map<String, dynamic> json) => _$TabsAuctionSearchDataDtoFromJson(json);
}

@JsonSerializable()
class SortAuctionSearchDataDto {
  const SortAuctionSearchDataDto({
    this.header,
    this.items,
  }) : super();

  @JsonKey(required: true, name: 'header')
  final String? header;
  @JsonKey(required: true, name: 'items')
  final List<ItemsSortAuctionSearchDataDto>? items;

  factory SortAuctionSearchDataDto.fromJson(Map<String, dynamic> json) => _$SortAuctionSearchDataDtoFromJson(json);
}

@JsonSerializable()
class ItemsSortAuctionSearchDataDto {
  const ItemsSortAuctionSearchDataDto({
    this.label,
    this.params,
    this.url,
  }) : super();

  @JsonKey(name: 'label')
  final String? label;
  @JsonKey(name: 'params')
  final Map<String, dynamic>? params;
  @JsonKey(name: 'url')
  final String? url;

  factory ItemsSortAuctionSearchDataDto.fromJson(Map<String, dynamic> json) =>
      _$ItemsSortAuctionSearchDataDtoFromJson(json);
}

@JsonSerializable()
class AuctionSearchFilterDto {
  const AuctionSearchFilterDto({
    this.fetchDataUrl,
    this.header,
    this.dataName,
    this.filters,
    this.selected,
  });

  @JsonKey(required: true, name: 'header')
  final String? header;
  @JsonKey(required: true, name: 'data_name')
  final String? dataName;
  @JsonKey( name: 'selected')
  final List<int>? selected;
  @JsonKey(name: 'fetch_data_url')
  final String? fetchDataUrl;
  @JsonKey(required: true, name: 'filters', fromJson: _filtersFromJson)
  final List<AuctionSearchFilterItemDto>? filters;

  static List<AuctionSearchFilterItemDto>? _filtersFromJson(
      List<dynamic>? value,
      ) {
    if (value == null) return null;

    final List<AuctionSearchFilterItemDto> result = [];

    AuctionSearchFilterItemDto? parentItem;

    for (final e in value) {
      final item = AuctionSearchFilterItemDto.fromJson(e as Map<String, dynamic>);
      if (item.isChildren == true && parentItem != null) {
        parentItem.filters ??= [];
        parentItem.filters!.add(item);
      } else {
        result.add(item);
        parentItem = item;
      }
    }
    return result;
  }

  static AuctionSearchFilterDto? fromJson(Map<String, dynamic> json) {
    return switch (json['data_name']) {
      'item' => OtherOptionsAuctionSearchFilterDto.fromJson(json),
      'category' => CategoryAuctionSearchFilterDto.fromJson(json),
      'brand' => ProducerAuctionSearchFilterDto.fromJson(json),
      'price' => ProductPriceAuctionSearchFilterDto.fromJson(json),
      'itemstatus' => ProductStatusAuctionSearchFilterDto.fromJson(json),
      'seller' => SellerAuctionSearchFilterDto.fromJson(json),
      _ => null,
    };

    /*
    if (json['type'] == 'checkbox') {
      return MultipleSelectionAuctionSearchFilterDto.fromJson(json);
    }

    return null;
    */
  }

  Map<String, dynamic>? getParams() {
    if (filters == null) return null;

    return {
      for (final e in filters!) ...?e.getParams(),
    };
  }
}

@JsonSerializable()
class SingleSelectionAuctionSearchFilterDto extends AuctionSearchFilterDto {
  SingleSelectionAuctionSearchFilterDto({
    super.header,
    super.dataName,
    super.filters,
    super.fetchDataUrl,
    super.selected,

  }) : groupFilter = ValueNotifier(null);

  final ValueNotifier<AuctionSearchFilterItemDto?> groupFilter;

  factory SingleSelectionAuctionSearchFilterDto.fromJson(Map<String, dynamic> json) =>
      _$SingleSelectionAuctionSearchFilterDtoFromJson(json);
}

@JsonSerializable()
class MultipleSelectionAuctionSearchFilterDto extends AuctionSearchFilterDto {
  const MultipleSelectionAuctionSearchFilterDto({
    super.header,
    super.dataName,
    super.filters,
    super.fetchDataUrl,
    super.selected,
  });

  factory MultipleSelectionAuctionSearchFilterDto.fromJson(Map<String, dynamic> json) =>
      _$MultipleSelectionAuctionSearchFilterDtoFromJson(json);
}

/// Tuỳ chọn khác
@JsonSerializable()
class OtherOptionsAuctionSearchFilterDto extends MultipleSelectionAuctionSearchFilterDto {
  const OtherOptionsAuctionSearchFilterDto({
    super.header,
    super.dataName,
    super.filters,
  });

  factory OtherOptionsAuctionSearchFilterDto.fromJson(Map<String, dynamic> json) =>
      _$OtherOptionsAuctionSearchFilterDtoFromJson(json);
}

/// Danh mục
@JsonSerializable()
class CategoryAuctionSearchFilterDto extends SingleSelectionAuctionSearchFilterDto {
  CategoryAuctionSearchFilterDto({
    super.header,
    super.dataName,
    super.filters,
  }) : super();

  factory CategoryAuctionSearchFilterDto.fromJson(Map<String, dynamic> json) =>
      _$CategoryAuctionSearchFilterDtoFromJson(json);
}

/// Giá sản phẩm
@JsonSerializable()
class ProductPriceAuctionSearchFilterDto extends SingleSelectionAuctionSearchFilterDto {
  ProductPriceAuctionSearchFilterDto({
    super.header,
    super.dataName,
    super.filters,
  }) : super();

  factory ProductPriceAuctionSearchFilterDto.fromJson(Map<String, dynamic> json) =>
      _$ProductPriceAuctionSearchFilterDtoFromJson(json);
}

/// Nhà sản xuất/Thương hiệu
@JsonSerializable()
class ProducerAuctionSearchFilterDto extends SingleSelectionAuctionSearchFilterDto {
  ProducerAuctionSearchFilterDto({
    super.header,
    super.dataName,
    super.filters,
    super.fetchDataUrl,
    super.selected,
  }) : super();

  factory ProducerAuctionSearchFilterDto.fromJson(Map<String, dynamic> json) =>
      _$ProducerAuctionSearchFilterDtoFromJson(json);
}

/// Tình trạng sản phẩm
@JsonSerializable()
class ProductStatusAuctionSearchFilterDto extends MultipleSelectionAuctionSearchFilterDto {
  const ProductStatusAuctionSearchFilterDto({
    super.header,
    super.dataName,
    super.filters,
  });

  factory ProductStatusAuctionSearchFilterDto.fromJson(Map<String, dynamic> json) =>
      _$ProductStatusAuctionSearchFilterDtoFromJson(json);
}

///Người bán
@JsonSerializable()
class SellerAuctionSearchFilterDto extends MultipleSelectionAuctionSearchFilterDto {
  const SellerAuctionSearchFilterDto({
    super.header,
    super.dataName,
    super.filters,
  });

  factory SellerAuctionSearchFilterDto.fromJson(Map<String, dynamic> json) =>
      _$SellerAuctionSearchFilterDtoFromJson(json);
}

@JsonSerializable()
class AuctionSearchFilterItemDto {
  AuctionSearchFilterItemDto({
    this.isChildren,
    required this.isActive,
    this.url,
    this.label,
    this.maxPrice,
    this.params,
    this.count,
    required this.checked,
  }) : super();

  @JsonKey(name: 'url')
  final String? url;

  @JsonKey(name: 'label')
  final String? label;

  @JsonKey(name: 'count')
  final int? count;

  @JsonKey(name: 'max_price')
  final int? maxPrice;

  @JsonKey(name: 'is_children')
  final bool? isChildren;

  @JsonKey(
    name: 'is_active',
    fromJson: _selectedActiveFromJson,
    toJson: _selectedActiveToJson,
  )
  final ValueNotifier<bool> isActive;

  @JsonKey(name: 'params')
  final Map<String, dynamic>? params;

  @JsonKey(
    name: 'checked',
    fromJson: _selectedFromJson,
    toJson: _selectedToJson,
  )
  final ValueNotifier<bool> checked;

  List<AuctionSearchFilterItemDto>? filters;

  static ValueNotifier<bool> _selectedFromJson(bool? value) => ValueNotifier<bool>(value ?? false);

  static bool _selectedToJson(ValueNotifier<bool> isSelected) => isSelected.value;

  static ValueNotifier<bool> _selectedActiveFromJson(bool? value) => ValueNotifier<bool>(value ?? false);

  static bool _selectedActiveToJson(ValueNotifier<bool> isSelected) => isSelected.value;

  factory AuctionSearchFilterItemDto.fromJson(Map<String, dynamic> json) => _$AuctionSearchFilterItemDtoFromJson(json);

  Map<String, dynamic>? getParams() {
    if (isActive == true) return params;
    if (checked.value == true) return params;

    return null;
  }
}

@JsonSerializable()
class AuctionItemSearchDto {
  const AuctionItemSearchDto({
    this.code,
    this.name,
    this.url,
    this.image,
    this.price,
    this.priceBuy,
    this.endTime,
    this.sellerId,
    this.bids,
    this.neW,
    this.used,
    this.freeship,
    this.itemType,
  }) : super();

  @JsonKey(name: 'code')
  final String? code;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'url')
  final String? url;
  @JsonKey(name: 'image')
  final String? image;
  @JsonKey(name: 'price')
  final int? price;
  @JsonKey(name: 'price_buy')
  final dynamic priceBuy;
  @JsonKey(name: 'end_time')
  final String? endTime;
  @JsonKey(name: 'seller_id')
  final String? sellerId;
  @JsonKey(name: 'bids')
  final int? bids;
  @JsonKey(name: 'new')
  final bool? neW;
  @JsonKey(name: 'used')
  final bool? used;
  @JsonKey(name: 'freeship')
  final bool? freeship;
  @JsonKey(name: 'item_type')
  final String? itemType;

  factory AuctionItemSearchDto.fromJson(Map<String, dynamic> json) => _$AuctionItemSearchDtoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AuctionItemSearchDtoToJson(this);
}
