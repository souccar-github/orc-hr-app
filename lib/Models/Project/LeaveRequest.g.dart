// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'LeaveRequest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeaveRequest _$LeaveRequestFromJson(Map<String, dynamic> json) {
  return LeaveRequest(
    json['description'] as String,
    json['employeeId'] as int,
    json['endDate'] == null ? null : DateTime.parse(json['endDate'] as String),
    json['fromDateTime'] == null
        ? null
        : DateTime.parse(json['fromDateTime'] as String),
    json['fromTime'] == null
        ? null
        : DateTime.parse(json['fromTime'] as String),
    json['fullName'] as String,
    json['isHourlyLeave'] as bool,
    json['isSummerDate'] as bool,
    json['leaveId'] as int,
    json['leaveReason'] as String,
    json['leaveReasonId'] as int,
    json['leaveSettingId'] as int,
    json['leaveSettingName'] as String,
    json['pendingType'] as int,
    json['positionId'] as int,
    json['positionName'] as String,
    json['requestDate'] == null
        ? null
        : DateTime.parse(json['requestDate'] as String),
    (json['spentDays'] as num)?.toDouble(),
    json['startDate'] == null
        ? null
        : DateTime.parse(json['startDate'] as String),
    json['toDateTime'] == null
        ? null
        : DateTime.parse(json['toDateTime'] as String),
    json['toTime'] == null ? null : DateTime.parse(json['toTime'] as String),
    json['workflowItemId'] as int,
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
