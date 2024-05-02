import 'package:json_annotation/json_annotation.dart';
part 'quick_request.g.dart';

@JsonSerializable()
class QuickRequest {

  @JsonKey(name: 'page')
  final String? page;
  @JsonKey(name: 'size')
  final String? size;
  @JsonKey(name: 'status')
  final String? status;



  QuickRequest({this.status,
    this.page,
    this.size,
  });
  Map<String, dynamic> toJson() => _$QuickRequestToJson(this);

}
