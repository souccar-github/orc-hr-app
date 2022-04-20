import 'package:json_annotation/json_annotation.dart';

part 'EntranceExitRequest.g.dart';

@JsonSerializable()
class EntranceExitRequest {
  final String? fullName;
  final int recordId;
  final DateTime recordDate;
  
  final int logType;
  final String? note;
  final String? logTypeString;
  final int workflowItemId;
  final String? desc;

  EntranceExitRequest(this.fullName,this.recordId,this.recordDate,this.logType,this.note,this.logTypeString ,this.workflowItemId,this.desc);

  factory EntranceExitRequest.fromJson(Map<String, dynamic> json) =>
      _$EntranceExitRequestFromJson(json);
  Map<String, dynamic> toJson() => _$EntranceExitRequestToJson(this);
}
