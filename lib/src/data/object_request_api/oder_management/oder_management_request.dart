import 'package:json_annotation/json_annotation.dart';
part'oder_management_request.g.dart';
@JsonSerializable()
class OderManagementRequest {
  OderManagementRequest( {
    this.size, this.page, this.from, this.to, this.step,
  });

  @JsonKey(name: 'size',)
  final int? size;
  @JsonKey(name: 'page',)
  final int? page;
  @JsonKey(name: 'from',)
  final String? from;
  @JsonKey(name: 'to',)
  final String? to;
  @JsonKey(name: 'step',)
  final double? step;


  Map<String, dynamic> toJson() => _$OderManagementRequestToJson(this);
}