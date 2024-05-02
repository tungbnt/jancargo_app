import 'package:json_annotation/json_annotation.dart';
part 'banner_slider_request.g.dart';

@JsonSerializable()
class BannerSliderRequest {
  @JsonKey(name: 'type_page')
  final String? typePage;
  @JsonKey(name: 'page')
  final String? page;
  @JsonKey(name: 'size')
  final String? size;
  @JsonKey(name: 'status')
  final String? status;



  BannerSliderRequest( {this.typePage, this.status,
    this.page,
    this.size,
  });
  Map<String, dynamic> toJson() => _$BannerSliderRequestToJson(this);

}
