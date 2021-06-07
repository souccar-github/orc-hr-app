// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'LeaveRequest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeaveRequest _$LeaveRequestFromJson(Map<String, dynamic> json) {
  return LeaveRequest(
    json['Description'] as String,
    json['EmployeeId'] as int,
    json['EndDate'] == null ? null : DateTime.parse(json['EndDate'] as String),
    json['FromDateTime'] == null
        ? null
        : DateTime.parse(json['FromDateTime'] as String),
    json['FromTime'] == null
        ? null
        : DateTime.parse(json['FromTime'] as String),
    json['FullName'] as String,
    json['IsHourlyLeave'] as bool,
    json['IsSummerDate'] as bool,
    json['LeaveId'] as int,
    json['LeaveReason'] as String,
    json['LeaveReasonId'] as int,
    json['LeaveSettingId'] as int,
    json['LeaveSettingName'] as String,
    json['PendingType'] as int,
    json['PositionId'] as int,
    json['PositionName'] as String,
    json['RequestDate'] == null
        ? null
        : DateTime.parse(json['RequestDate'] as String),
    (json['SpentDays'] as num)?.toDouble(),
    json['StartDate'] == null
        ? null
        : DateTime.parse(json['StartDate'] as String),
    json['ToDateTime'] == null
        ? null
        : DateTime.parse(json['ToDateTime'] as String),
    json['ToTime'] == null ? null : DateTime.parse(json['ToTime'] as String),
    json['WorkflowItemId'] as int,
  );
}

Map<String, dynamic> _$LeaveRequestToJson(LeaveRequest instance) =>
    <String, dynamic>{
      'employeeId': instance.employeeId,
      'positionId': instance.positionId,
      'fullName': instance.fullName,
      'positionName': instance.positionName,
      'leaveId': instance.leaveId,
      'leaveSettingId': instance.leaveSettingId,
      'leaveSettingName': instance.leaveSettingName,
      'startDate': instance.startDate?.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'isHourlyLeave': instance.isHourlyLeave,
      'isSummerDate': instance.isSummerDate,
      'fromTime': instance.fromTime?.toIso8601String(),
      'toTime': instance.toTime?.toIso8601String(),
      'fromDateTime': instance.fromDateTime?.toIso8601String(),
      'toDateTime': instance.toDateTime?.toIso8601String(),
      'spentDays': instance.spentDays,
      'leaveReason': instance.leaveReason,
      'leaveReasonId': instance.leaveReasonId,
      'requestDate': instance.requestDate?.toIso8601String(),
      'description': instance.description,
      'workflowItemId': instance.workflowItemId,
      'pendingType': instance.pendingType,
    };
