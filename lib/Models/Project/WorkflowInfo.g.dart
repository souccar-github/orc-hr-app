// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'WorkflowInfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkflowInfo _$WorkflowInfosFromJson(Map<String, dynamic> json) {
  return WorkflowInfo(
    json['LeaveSetting'] as String?,
    json['Type'] as String?,
    json['PendingStep'] as String?,
    json['WaitingApprove'] as bool,
    json['Date'] =json['Date'] == null?null: DateTime.parse(json['Date'] as String),
    json['FromTime'] =json['FromTime'] == null?null: DateTime.parse(json['FromTime'] as String),
    json['ToTime'] =json['ToTime'] == null?null: DateTime.parse(json['ToTime'] as String),
    json['LogType'] as int?,
    json['IsHourly'] as bool
  );
}

Map<String, dynamic> _$WorkflowInfosToJson(WorkflowInfo instance) =>
    <String, dynamic>{
      'leaveSetting':instance.leaveSetting,
      'pendingStep': instance.pendingStep,
      'type': instance.type,
      'waitingApprove': instance.waitingApprove,
      'date': instance.date?.toIso8601String(),
      'fromTime': instance.fromTime?.toIso8601String(),
      'toTime': instance.toTime?.toIso8601String(),
      'logType': instance.logType,
      'isHourly': instance.isHourly
    };
