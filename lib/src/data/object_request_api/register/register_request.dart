import 'package:json_annotation/json_annotation.dart';
part 'register_request.g.dart';

@JsonSerializable()
class RegisterRequest {
  @JsonKey(name: 'short_name', defaultValue: 'password')
  final String? shortName;
  @JsonKey(name: 'phone')
  final String? phone;
  @JsonKey(name: 'email')
  final String? email;
  @JsonKey(
      name: 'password', defaultValue: '')
  final String? password;
  @JsonKey(name: 'confirmPassword', defaultValue: '')
  final String? confirmPassword;
  @JsonKey(name: 'captcha', defaultValue: '')
  final String? captcha;
  @JsonKey(name: 'type_mode', defaultValue: '')
  final String? typeMode;


  RegisterRequest( {
    this.shortName, this.phone, this.email, this.password, this.confirmPassword, this.captcha, this.typeMode,
  });
  Map<String, dynamic> toJson() => _$RegisterRequestToJson(this);
}
