// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'EntranceExitRequest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EntranceExitRequest _$EntranceExitRequestFromJson(Map<String, dynamic> json) {
  return EntranceExitRequest(
    json['FullName'] as String?,
    json['RecordId'] as int,
    json['RecordDate'] = DateTime.parse(json['RecordDate'] as String),
    json['LogType'] as int,
    json['Note'] as String?,
    json['LogTypeString'] as String?,
    json['WorkflowItemId'] as int,
    json['Desc'] as String?,
  );
}

Map<String, dynamic> _$EntranceExitRequestToJson(EntranceExitRequest instance) =>
    <String, dynamic>{
      'fullName': instance.fullName,
      'recordId': instance.recordId,
      'recordDate': instance.recordDate.toIso8601String(),
      'logType': instance.logType,
      'note': instance.note,
      'logTypeString': instance.logTypeString,
      'workflowItemId': instance.workflowItemId,
      'desc': instance.desc,
    };
