// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Notify.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Notify _$NotifysFromJson(Map<String, dynamic> json) {
  return Notify(
    json['WorkflowItemId'] as int,
    json['Body'] as String,
  );
}

Map<String, dynamic> _$NotifysToJson(Notify instance) =>
    <String, dynamic>{
      'workflowItemId': instance.workflowItemId,
      'body': instance.body,
    };
