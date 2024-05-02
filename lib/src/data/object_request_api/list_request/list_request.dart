import 'package:json_annotation/json_annotation.dart';

part 'list_request.g.dart';

@JsonSerializable()
class ListRequest {
  ListRequest({
    this.size,
    this.page,
    this.search,
  });

  @JsonKey(
    name: 'size',
  )
  final String? size;
  @JsonKey(
    name: 'page',
  )
  final String? page;
  @JsonKey(
    name: 'search',
  )
  final String? search;


  Map<String, dynamic> toJson() => _$ListRequestToJson(this);
}