import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth-code-request-dto.g.dart';

@JsonSerializable()
class AuthCodeRequestDto extends Equatable {
  const AuthCodeRequestDto({required this.code, required this.codeVerifier})
      : super();

  @JsonKey(required: true)
  final String code;

  @JsonKey(required: true, name: 'code_verifier')
  final String codeVerifier;

  @override
  List<Object?> get props => [code, codeVerifier];

  factory AuthCodeRequestDto.fromJson(Map<String, dynamic> json) =>
      _$AuthCodeRequestDtoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AuthCodeRequestDtoToJson(this);
}
