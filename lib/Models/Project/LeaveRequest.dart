import 'package:json_annotation/json_annotation.dart';

part 'LeaveRequest.g.dart';

@JsonSerializable()
class LeaveRequest {
  final int employeeId;
  final int positionId;
  final String? fullName;
  final String? positionName;
  final int leaveId;
  final int leaveSettingId;
  final String? leaveSettingName;
  final DateTime startDate;
  DateTime endDate;
  final bool isHourlyLeave;
  final bool isSummerDate;

  final DateTime? fromTime;
  final DateTime? toTime;
  final DateTime? fromDateTime;
  DateTime? toDateTime;

  final double spentDays;
  final String? leaveReason;
  final String? note;
  final int leaveReasonId;
  final DateTime requestDate;
  final String? description;
  final List<dynamic>? attachmentsPaths;
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
      this.workflowItemId,
      this.note,
      this.attachmentsPaths);

  factory LeaveRequest.fromJson(Map<String, dynamic> json) =>
      _$LeaveRequestFromJson(json);
  Map<String, dynamic> toJson() => _$LeaveRequestToJson(this);
}
