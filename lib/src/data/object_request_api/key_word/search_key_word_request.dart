import 'package:json_annotation/json_annotation.dart';

part 'search_key_word_request.g.dart';

@JsonSerializable()
class SearchKeyWordRequest {
  SearchKeyWordRequest({
    this.query,
    this.keyword,
  });

  @JsonKey(
    name: 'keyword',
  )
  final String? keyword;
  @JsonKey(
    name: 'query',
  )
  final String? query;


  Map<String, dynamic> toJson() => _$SearchKeyWordRequestToJson(this);
}

@JsonSerializable()
class RakutenSearchKeyWordRequest extends SearchKeyWordRequest {
  RakutenSearchKeyWordRequest({
    super.query,
    super.keyword,
    this.sort,
    this.priceFrom,
    this.priceTo,
    this.condition,
    this.size,
    this.page,
  });

  @JsonKey(
    name: 'maxPrice',
  )
  final String? priceFrom;
  @JsonKey(
    name: 'sort',
  )
  final String? sort;

  @JsonKey(
    name: 'minPrice',
  )
  final String? priceTo;

  @JsonKey(
    name: 'condition',
  )
  final String? condition;
  @JsonKey(
    name: 'size',
  )
  final String? size;
  @JsonKey(
    name: 'page',
  )
  final String? page;

  @override
  Map<String, dynamic> toJson() => _$RakutenSearchKeyWordRequestToJson(this);
}
@JsonSerializable()
class YahooShoppingSearchKeyWordRequest extends SearchKeyWordRequest {
  YahooShoppingSearchKeyWordRequest({
    super.query,
    super.keyword,
    this.priceFrom,
    this.priceTo,
    this.condition,
    this.sort,
    this.size,
    this.page,

  });

  @JsonKey(
    name: 'price_from',
  )
  final String? priceFrom;

  @JsonKey(
    name: 'price_to',
  )
  final String? priceTo;

  @JsonKey(
    name: 'sort'
  )
  final String? sort;

  @JsonKey(
    name: 'condition',
  )
  final String? condition;
  @JsonKey(
    name: 'size',
  )
  final String? size;
  @JsonKey(
    name: 'page',
  )
  final String? page;

  @override
  Map<String, dynamic> toJson() => _$YahooShoppingSearchKeyWordRequestToJson(this);
}
