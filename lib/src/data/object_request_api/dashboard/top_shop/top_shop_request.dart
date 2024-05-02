import 'package:json_annotation/json_annotation.dart';
part 'top_shop_request.g.dart';

@JsonSerializable()
class LoadItemRequest {
  @JsonKey(name: 'page')
  final String? page;
  @JsonKey(name: 'size')
  final String? size;
  @JsonKey(name: 'site_code')
  final String? site;
  @JsonKey(name: 'source')
  final String? source;
  @JsonKey(name: 'search')
  final String? search;
  @JsonKey(name: 'viewing_product_id')
  final String? codeProduct;


  LoadItemRequest( {this.source, this.codeProduct,
    this.site,
    this.page,
    this.size,
    this.search,
  });
  Map<String, dynamic> toJson() => _$LoadItemRequestToJson(this);

}
