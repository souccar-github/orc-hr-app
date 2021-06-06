import 'package:json_annotation/json_annotation.dart';

part 'LeaveRequest.g.dart';

@JsonSerializable()
class LeaveRequest {
  final int employeeId;
  final int positionId;
  final String fullName;
  final String positionName;
  final int leaveId;
  final int leaveSettingId;
  final String leaveSettingName;
  final DateTime startDate;
  final DateTime endDate;
  final bool isHourlyLeave;
  final bool isSummerDate;

  final DateTime fromTime;
  final DateTime toTime;
  final DateTime fromDateTime;
  final DateTime toDateTime;

  final double spentDays;
  final String leaveReason;
  final int leaveReasonId;
  final DateTime requestDate;
  final String description;
  final int workflowItemId;
  final int pendingType;

  LeaveRequest(
      this.description,
      this.employeeId,
      this.endDate,
      this.fromDateTime,
      this.fromTime,
      this.fullName,
      this.isHourlyLeave,
      this.isSummerDate,
      this.leaveId,
      this.leaveReason,
      this.leaveReasonId,
      this.leaveSettingId,
      this.leaveSettingName,
      this.pendingType,
      this.positionId,
      this.positionName,
      this.requestDate,
      this.spentDays,
      this.startDate,
      this.toDateTime,
      this.toTime,
      this.workflowItemId);

  factory LeaveRequest.fromJson(Map<String, dynamic> json) =>
      _$LeaveRequestFromJson(json);
  Map<String, dynamic> toJson() => _$LeaveRequestToJson(this);
}
