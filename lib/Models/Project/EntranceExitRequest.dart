import 'package:json_annotation/json_annotation.dart';

part 'EntranceExitRequest.g.dart';

@JsonSerializable()
class EntranceExitRequest {
  @JsonKey(nullable: true)
  final String fullName;
  @JsonKey(nullable: true)
  final int recordId;
  @JsonKey(nullable: true)
  final DateTime recordDate;
  @JsonKey(nullable: true)
  final int logType;
  @JsonKey(nullable: true)
  final String note;
  @JsonKey(nullable: true)
  final String logTypeString;
  @JsonKey(nullable: true)
  final int workflowItemId;

  EntranceExitRequest(this.fullName,this.recordId,this.recordDate,this.logType,this.note,this.logTypeString ,this.workflowItemId);

  factory EntranceExitRequest.fromJson(Map<String, dynamic> json) =>
      _$EntranceExitRequestFromJson(json);
  Map<String, dynamic> toJson() => _$EntranceExitRequestToJson(this);
}
