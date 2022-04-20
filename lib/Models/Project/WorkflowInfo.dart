import 'package:json_annotation/json_annotation.dart';

part 'WorkflowInfo.g.dart';

@JsonSerializable()
class WorkflowInfo {
  final String? pendingStep;
  final String? type;
  final String? leaveSetting;
  final bool waitingApprove;
  final DateTime? date;
  final DateTime? fromTime;
  final DateTime? toTime;
  final int? logType;
  final bool isHourly;

  WorkflowInfo(
      this.leaveSetting,
      this.type,
      this.pendingStep,
      this.waitingApprove,
      this.date,
      this.fromTime,
      this.toTime,
      this.logType,
      this.isHourly
      );

  factory WorkflowInfo.fromJson(Map<String, dynamic> json) =>
      _$WorkflowInfosFromJson(json);
  Map<String, dynamic> toJson() => _$WorkflowInfosToJson(this);
}
