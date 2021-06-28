// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'WorkflowInfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkflowInfo _$WorkflowInfosFromJson(Map<String, dynamic> json) {
  return WorkflowInfo(
    json['Type'] as String,
    json['PendingStep'] as String,
    json['WaitingApprove'] as bool,
    json['Date'] == null ? null : DateTime.parse(json['Date'] as String),

  );
}

Map<String, dynamic> _$WorkflowInfosToJson(WorkflowInfo instance) =>
    <String, dynamic>{
      'pendingStep': instance.pendingStep,
      'type': instance.type,
      'waitingApprove': instance.waitingApprove,
      'date': instance.date?.toIso8601String(),
    };
