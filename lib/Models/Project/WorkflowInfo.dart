import 'package:json_annotation/json_annotation.dart';

part 'WorkflowInfo.g.dart';

@JsonSerializable()
class WorkflowInfo {
  final String pendingStep;
  final String type;
  final bool waitingApprove;
  final DateTime date;

  WorkflowInfo(
      this.type,
      this.pendingStep,
      this.waitingApprove,
      this.date
      );

  factory WorkflowInfo.fromJson(Map<String, dynamic> json) =>
      _$WorkflowInfosFromJson(json);
  Map<String, dynamic> toJson() => _$WorkflowInfosToJson(this);
}
