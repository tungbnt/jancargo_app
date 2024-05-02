import 'package:json_annotation/json_annotation.dart';

part 'tran_dto.g.dart';

@JsonSerializable()
class TranDto {
  const TranDto({this.balance, this.freeze, this.account, this.primary, this.paid, this.total, this.transations,}) : super();

  @JsonKey(name: 'balance')
  final int? balance;
  @JsonKey(name: 'freeze')
  final int? freeze;
  @JsonKey(name: 'account')
  final int? account;
  @JsonKey(name: 'primary')
  final int? primary;
  @JsonKey(name: 'paid')
  final int? paid;
  @JsonKey(name: 'total')
  final int? total;
  @JsonKey(name: 'transations')
  final List<dynamic>? transations;

  factory TranDto.fromJson(Map<String, dynamic> json) =>
      _$TranDtoFromJson(json);

  Map<String, dynamic> toJson() => _$TranDtoToJson(this);
}