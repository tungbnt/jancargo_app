import 'package:json_annotation/json_annotation.dart';

part 'base_dto.g.dart';


@JsonSerializable()
class BaseDto {
  @JsonKey( defaultValue: false)
  bool status;
  @JsonKey(required: false, defaultValue: '')
  String message;

  BaseDto(this.status, this.message);

  factory BaseDto.fromJson(Map<String, dynamic> json) =>
      _$BaseDtoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$BaseDtoToJson(this);
}