// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AdvanceRequest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdvanceRequest _$AdvanceRequestFromJson(Map<String, dynamic> json) {
  return AdvanceRequest(
    json['EmployeeId'] as int,
    json['FullName'] as String,
    json['AdvanceId'] as int,
    (json['AdvanceAmount'] as num).toDouble(),
    (json['DeservableAdvanceAmount'] as num).toDouble(),
    json['PendingType'] as int,
    json['PositionId'] as int,
    json['PositionName'] as String,
    json['OperationDate'] = DateTime.parse(json['OperationDate'] as String),
    json['WorkflowItemId'] as int,
    json['OtherAdvance'] as int,
    json['Note'] as String,
    json['Description'] as String,
  );
}

Map<String, dynamic> _$AdvanceRequestToJson(AdvanceRequest instance) =>
    <String, dynamic>{
      'employeeId': instance.employeeId,
      'positionId': instance.positionId,
      'fullName': instance.fullName,
      'positionName': instance.positionName,
      'advanceId': instance.advanceId,
      'advanceAmount': instance.advanceAmount,
      'deservableAdvanceAmount': instance.deservableAdvanceAmount,
      'operationDate': instance.operationDate.toIso8601String(),
      'note': instance.note,
      'description': instance.description,
      'otherAdvance': instance.otherAdvance,
      'workflowItemId': instance.workflowItemId,
      'pendingType': instance.pendingType,
    };
