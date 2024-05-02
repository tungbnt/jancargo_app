import 'package:json_annotation/json_annotation.dart';
part 'request_change_pass.g.dart';

@JsonSerializable()
class RequestForgetPass {
  @JsonKey(name: 'phoneOrEmail')
  final String? phoneOrEmail;
  @JsonKey(name: 'step')
  final String? step;
  @JsonKey(name: 'otp')
  final String? otp;


  RequestForgetPass({
    this.phoneOrEmail,
    this.step,
    this.otp,

  });
  Map<String, dynamic> toJson() => _$RequestForgetPassToJson(this);
}

@JsonSerializable()
class ChangePassRequest {
  @JsonKey(name: 'ConfirmNewPassword')
  final String? confirmNewPassword;
  @JsonKey(name: 'NewPassword')
  final String? newPassword;
  @JsonKey(name: 'OldPassword')
  final String? oldPassword;
  @JsonKey(name: 'id')
  final String? id;


  ChangePassRequest({
    this.confirmNewPassword,
    this.newPassword,
    this.oldPassword,
    this.id,
  });
  Map<String, dynamic> toJson() => _$ChangePassRequestToJson(this);
}
