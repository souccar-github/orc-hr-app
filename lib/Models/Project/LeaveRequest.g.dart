// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'LeaveRequest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeaveRequest _$LeaveRequestFromJson(Map<String, dynamic> json) {
  return LeaveRequest(
    json['Description'] as String?,
    json['EmployeeId'] as int,
    json['EndDate'] = DateTime.parse(json['EndDate'] as String),
    json['FromDateTime'] = json['FromDateTime'] == null ? null :DateTime.parse(json['FromDateTime'] as String),
    json['FromTime'] =json['FromTime'] == null ? null : DateTime.parse(json['FromTime'] as String),
    json['FullName'] as String?,
    json['IsHourlyLeave'] as bool,
    json['IsSummerDate'] as bool,
    json['LeaveId'] as int,
    json['LeaveReason'] as String?,
    json['LeaveReasonId'] as int,
    json['LeaveSettingId'] as int,
    json['LeaveSettingName'] as String?,
    json['PendingType'] as int,
    json['PositionId'] as int,
    json['PositionName'] as String?,
    json['RequestDate'] =  DateTime.parse(json['RequestDate'] as String),
    (json['SpentDays'] as num).toDouble(),
    json['StartDate'] = DateTime.parse(json['StartDate'] as String),
    json['ToDateTime'] = json['ToDateTime'] == null ? null :DateTime.parse(json['ToDateTime'] as String),
    json['ToTime'] = json['ToTime'] == null ? null :DateTime.parse(json['ToTime'] as String),
    json['WorkflowItemId'] as int,
    json['Note'] as String?,
    json['AttachmentsPaths'] as List<dynamic>?,
  );
}

Map<String, dynamic> _$LeaveRequestToJson(LeaveRequest instance) =>
    <String, dynamic>{
      'employeeId': instance.employeeId.toString(),
      'positionId': instance.positionId.toString(),
      'fullName': instance.fullName?.toString()??"",
      'positionName': instance.positionName?.toString()??"",
      'leaveId': instance.leaveId.toString(),
      'leaveSettingId': instance.leaveSettingId.toString(),
      'leaveSettingName': instance.leaveSettingName?.toString()??"",
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'isHourlyLeave': instance.isHourlyLeave.toString(),
      'isSummerDate': instance.isSummerDate.toString(),
      'fromTime': instance.fromTime?.toIso8601String()??"",
      'toTime': instance.toTime?.toIso8601String()??'',
      'fromDateTime': instance.fromDateTime?.toIso8601String()??"",
      'toDateTime': instance.toDateTime?.toIso8601String()??"",
      'spentDays': instance.spentDays.toString(),
      'leaveReason': instance.leaveReason?.toString()??"",
      'leaveReasonId': instance.leaveReasonId.toString(),
      'requestDate': instance.requestDate.toIso8601String(),
      'description': instance.description?.toString()??"",
      'workflowItemId': instance.workflowItemId.toString(),
      'pendingType': instance.pendingType.toString(),
      'note': instance.note??"",
      'attachmentsPaths': instance.attachmentsPaths,
    };
