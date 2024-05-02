import 'package:json_annotation/json_annotation.dart';

part 'deleted_account_dto.g.dart';

@JsonSerializable()
class DeletedAccountDto {
  const DeletedAccountDto({this.success,this.message}) : super();

  @JsonKey(name: 'success')
  final bool? success;
  @JsonKey(name: 'message')
  final String? message;

  factory DeletedAccountDto.fromJson(Map<String, dynamic> json) =>
      _$DeletedAccountDtoFromJson(json);

  Map<String, dynamic> toJson() => _$DeletedAccountDtoToJson(this);
}