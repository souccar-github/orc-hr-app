// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MissionRequest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MissionRequest _$MissionRequestFromJson(Map<String, dynamic> json) {
  return MissionRequest(
    json['Description'] as String,
    json['EmployeeId'] as int,
    json['EndDate'] == null ? null : DateTime.parse(json['EndDate'] as String),
    json['FromTime'] == null
        ? null
        : DateTime.parse(json['FromTime'] as String),
    json['FullName'] as String,
    json['IsHourlyMission'] as bool,
    json['MissionId'] as int,
    json['PendingType'] as int,
    json['PositionId'] as int,
    json['PositionName'] as String,
    json['RequestDate'] == null
        ? null
        : DateTime.parse(json['RequestDate'] as String),
    json['StartDate'] == null
        ? null
        : DateTime.parse(json['StartDate'] as String),
    json['ToTime'] == null ? null : DateTime.parse(json['ToTime'] as String),
    json['WorkflowItemId'] as int,
    json['Note'] as String,
  );
}

Map<String, dynamic> _$MissionRequestToJson(MissionRequest instance) =>
    <String, dynamic>{
      'employeeId': instance.employeeId,
      'positionId': instance.positionId,
      'fullName': instance.fullName,
      'positionName': instance.positionName,
      'missionId': instance.missionId,
      'startDate': instance.startDate?.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'isHourlyMission': instance.isHourlyMission,
      'fromTime': instance.fromTime?.toIso8601String(),
      'toTime': instance.toTime?.toIso8601String(),
      'requestDate': instance.requestDate?.toIso8601String(),
      'description': instance.description,
      'workflowItemId': instance.workflowItemId,
      'pendingType': instance.pendingType,
      'note': instance.note,
    };
