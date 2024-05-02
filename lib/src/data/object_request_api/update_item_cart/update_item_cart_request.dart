import 'package:json_annotation/json_annotation.dart';
part 'update_item_cart_request.g.dart';

@JsonSerializable()
class UpdateItemCartRequest {
  @JsonKey(name: 'items',)
  final List<ListUpdateItemCartRequest>? items;


  UpdateItemCartRequest({
  this.items
  });
  Map<String, dynamic> toJson() => _$UpdateItemCartRequestToJson(this);
}

@JsonSerializable()
class ListUpdateItemCartRequest {
  @JsonKey(name: 'id',)
  final String? id;
  @JsonKey(name: 'qty')
  final int? qty;
  @JsonKey(name: 'selected')
  final bool? selected;


  ListUpdateItemCartRequest( {
    this.id, this.qty, this.selected,
});

  factory ListUpdateItemCartRequest.fromJson(Map<String, dynamic> json) =>
      _$ListUpdateItemCartRequestFromJson(json);

Map<String, dynamic> toJson() => _$ListUpdateItemCartRequestToJson(this);
}