import 'package:json_annotation/json_annotation.dart';

part 'time_formatter.g.dart';


@JsonSerializable()
class TimerDto {
  @JsonKey( name: 'day')
  final String? day;
  @JsonKey(name: 'hour')
  final String? hour;
  @JsonKey(name: 'minutes')
  final String? minutes;
  @JsonKey(name: 'second')
  final String? second;

  TimerDto({this.day, this.hour, this.minutes, this.second,})  : super();

  factory TimerDto.fromJson(Map<String, dynamic> json) =>
      _$TimerDtoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$TimerDtoToJson(this);
}