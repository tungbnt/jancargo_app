import 'package:json_annotation/json_annotation.dart';
part'auction_manager_request.g.dart';
@JsonSerializable()
class AuctionManagementRequest {
  AuctionManagementRequest({
    this.sort, this.order, this.size, this.page, this.from, this.to, this.type,this.search
  });

  @JsonKey(name: 'size',)
  final String? size;
  @JsonKey(name: 'page',)
  final String? page;
  @JsonKey(name: 'from',)
  final String? from;
  @JsonKey(name: 'to',)
  final String? to;
  @JsonKey(name: 'type',)
  final String? type;
  @JsonKey(name: 'sort',)
  final String? sort;
  @JsonKey(name: 'order',)
  final String? order;
  @JsonKey(name: 'search',)
  final String? search;


  Map<String, dynamic> toJson() => _$AuctionManagementRequestToJson(this);
}