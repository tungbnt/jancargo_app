import 'package:json_annotation/json_annotation.dart';
part 'search_seller_request.g.dart';

@JsonSerializable()
class SearchSellerRequest {
  @JsonKey(name: 'query')
  final String? query;
  @JsonKey(name: 'size')
  final String? size;
  @JsonKey(name: 'page')
  final String? page;
  @JsonKey(name: 'type_code')
  final String? typeCode;


  SearchSellerRequest(  {this.typeCode,
    this.query,
    this.size,
    this.page,
  });
  Map<String, dynamic> toJson() => _$SearchSellerRequestToJson(this);

}

@JsonSerializable()
class SuggestionRequest {

  @JsonKey(name: 'size')
  final String? size;
  @JsonKey(name: 'sort')
  final String? sort;
  @JsonKey(name: 'type_code')
  final String? typeCode;
  @JsonKey(name: 'seller_id')
  final String? sellerId;

  SuggestionRequest(  {this.sellerId,this.typeCode,
    this.size,
    this.sort,
  });
  Map<String, dynamic> toJson() => _$SuggestionRequestToJson(this);

}
