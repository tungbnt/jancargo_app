import 'package:json_annotation/json_annotation.dart';

part 'suggestion_rakuten_dto.g.dart';

@JsonSerializable()
class SuggestionRakutenDto  {
  const SuggestionRakutenDto({this.data, })
      : super();

  @JsonKey(name: 'data')
  final List<ItemsSuggestionRakutenDto>? data;


  factory SuggestionRakutenDto.fromJson(Map<String, dynamic> json) =>
      _$SuggestionRakutenDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SuggestionRakutenDtoToJson(this);
}

@JsonSerializable()
class ItemsSuggestionRakutenDto  {
  const ItemsSuggestionRakutenDto({ this.shopUrl, this.smallImageUrls, this.startTime, this.taxFlag, this.reviewAverage, this.reviewCount, this.shipOverseasArea, this.shipOverseasFlag, this.shopAffiliateUrl, this.shopCode, this.shopName, this.shopOfTheYearFlag, this.imageFlag, this.itemCode, this.itemName, this.itemPrice, this.itemUrl, this.mediumImageUrls, this.pointRate, this.pointRateEndTime, this.pointRateStartTime, this.postageFlag, this.rank,  this.affiliateRate, this.affiliateUrl, this.asurakuArea, this.asurakuClosingTime, this.asurakuFlag, this.carrier, this.catchcopy, this.creditCardFlag, this.endTime, this.genreId, this.itemCaption, this.availability, })
      : super();

  @JsonKey(name: 'affiliateRate')
  final String? affiliateRate;
  @JsonKey(name: 'affiliateUrl')
  final String? affiliateUrl;
  @JsonKey(name: 'asurakuArea')
  final String? asurakuArea;
  @JsonKey(name: 'asurakuClosingTime')
  final String? asurakuClosingTime;
  @JsonKey(name: 'asurakuFlag')
  final int? asurakuFlag;
  @JsonKey(name: 'availability')
  final int? availability;
  @JsonKey(name: 'carrier')
  final int? carrier;
  @JsonKey(name: 'catchcopy')
  final String? catchcopy;
  @JsonKey(name: 'creditCardFlag')
  final int? creditCardFlag;
  @JsonKey(name: 'endTime')
  final String? endTime;
  @JsonKey(name: 'genreId')
  final String? genreId;
  @JsonKey(name: 'itemCaption')
  final String? itemCaption;
  @JsonKey(name: 'imageFlag')
  final int? imageFlag;
  @JsonKey(name: 'itemCode')
  final String? itemCode;
  @JsonKey(name: 'itemName')
  final String? itemName;
  @JsonKey(name: 'itemPrice')
  final String? itemPrice;
  @JsonKey(name: 'itemUrl')
  final String? itemUrl;
  @JsonKey(name: 'mediumImageUrls')
  final List<MediumImageUrlsSuggestionRakutenDto>? mediumImageUrls;
  @JsonKey(name: 'pointRate')
  final int? pointRate;
  @JsonKey(name: 'pointRateEndTime')
  final String? pointRateEndTime;
  @JsonKey(name: 'pointRateStartTime')
  final String? pointRateStartTime;
  @JsonKey(name: 'postageFlag')
  final int? postageFlag;
  @JsonKey(name: 'rank')
  final int? rank;
  @JsonKey(name: 'reviewAverage')
  final String? reviewAverage;
  @JsonKey(name: 'reviewCount')
  final int? reviewCount;
  @JsonKey(name: 'shipOverseasArea')
  final String? shipOverseasArea;
  @JsonKey(name: 'shipOverseasFlag')
  final int? shipOverseasFlag;
  @JsonKey(name: 'shopAffiliateUrl')
  final String? shopAffiliateUrl;
  @JsonKey(name: 'shopCode')
  final String? shopCode;
  @JsonKey(name: 'shopName')
  final String? shopName;
  @JsonKey(name: 'shopOfTheYearFlag')
  final int? shopOfTheYearFlag;
  @JsonKey(name: 'shopUrl')
  final String? shopUrl;
  @JsonKey(name: 'smallImageUrls')
  final List<SmallImageUrlsSuggestionRakutenDto>? smallImageUrls;
  @JsonKey(name: 'startTime')
  final String? startTime;
  @JsonKey(name: 'taxFlag')
  final int? taxFlag;


  factory ItemsSuggestionRakutenDto.fromJson(Map<String, dynamic> json) =>
      _$ItemsSuggestionRakutenDtoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ItemsSuggestionRakutenDtoToJson(this);
}

@JsonSerializable()
class MediumImageUrlsSuggestionRakutenDto  {
  const MediumImageUrlsSuggestionRakutenDto({this.imageUrl, })
      : super();

  @JsonKey(name: 'imageUrl')
  final String? imageUrl;


  factory MediumImageUrlsSuggestionRakutenDto.fromJson(Map<String, dynamic> json) =>
      _$MediumImageUrlsSuggestionRakutenDtoFromJson(json);

  Map<String, dynamic> toJson() => _$MediumImageUrlsSuggestionRakutenDtoToJson(this);
}

@JsonSerializable()
class SmallImageUrlsSuggestionRakutenDto  {
  const SmallImageUrlsSuggestionRakutenDto({this.imageUrl, })
      : super();

  @JsonKey(name: 'imageUrl')
  final String? imageUrl;


  factory SmallImageUrlsSuggestionRakutenDto.fromJson(Map<String, dynamic> json) =>
      _$SmallImageUrlsSuggestionRakutenDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SmallImageUrlsSuggestionRakutenDtoToJson(this);
}
