import 'package:json_annotation/json_annotation.dart';

part 'verify_otp_dto.g.dart';

@JsonSerializable()
class VerifyOtpDto {
  const VerifyOtpDto({required this.success, required this.token})
      : super();

  @JsonKey(name: "success")
  final bool success;

  @JsonKey(required: true, name: 'token')
  final String token;


  factory VerifyOtpDto.fromJson(Map<String, dynamic> json) =>
      _$VerifyOtpDtoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$VerifyOtpDtoToJson(this);
}