import 'package:json_annotation/json_annotation.dart';

part 'AdvanceRequest.g.dart';

@JsonSerializable()
class AdvanceRequest {
  final int employeeId;
  final int positionId;
  final String fullName;
  final String positionName;
  final int advanceId;
  final double advanceAmount;
  final double deservableAdvanceAmount;
  final DateTime operationDate;
  final String note;
  final String description;
  final int otherAdvance;
  final int workflowItemId;
  final int pendingType;

  AdvanceRequest(
      this.employeeId,
      this.fullName,
      this.advanceId,
      this.advanceAmount,
      this.deservableAdvanceAmount,
      this.pendingType,
      this.positionId,
      this.positionName,
      this.operationDate,
      this.workflowItemId,
      this.otherAdvance,
      this.note,
      this.description);

  factory AdvanceRequest.fromJson(Map<String, dynamic> json) =>
      _$AdvanceRequestFromJson(json);
  Map<String, dynamic> toJson() => _$AdvanceRequestToJson(this);
}
