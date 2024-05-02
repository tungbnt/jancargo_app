import 'package:json_annotation/json_annotation.dart';
part 'base_user_dto.g.dart';

@JsonSerializable()
class BaseUserDto {

  @JsonKey(name: 'access_token')
  final String? accessToken;
  @JsonKey(name: 'expires_in')
  final int? expiresIn;
  @JsonKey(name: 'refresh_token')
  final String? refreshToken;
  late final Map<String, dynamic>? _user;

  bool get isHasUser => _user != null && _user!.isNotEmpty;

  BaseUserDto({this.accessToken, this.expiresIn, this.refreshToken,});
  factory BaseUserDto.fromJson(Map<String, dynamic> json) =>
      _$BaseUserDtoFromJson(json);

  Map<String, dynamic> toJson() => _$BaseUserDtoToJson(this);
}