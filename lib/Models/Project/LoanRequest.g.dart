// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'LoanRequest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoanRequest _$LoanRequestFromJson(Map<String, dynamic> json) {
  return LoanRequest(
    json['EmployeeId'] as int,
    json['FullName'] as String,
    json['RequestId'] as int,
    (json['TotalAmount'] as num).toDouble(),
    (json['MonthlyInstallment'] as num).toDouble(),
    json['PendingType'] as int,
    json['PositionId'] as int,
    json['PositionName'] as String,
    json['RequestDate'] = DateTime.parse(json['RequestDate'] as String),
    json['WorkflowItemId'] as int,
    json['FirstRepresentative'] as int,
    json['SecondRepresentative'] as int,
    json['Note'] as String,
    json['Description'] as String,
    json['FirstRepresentativeName'] as String,
    json['SecondRepresentativeName'] as String,
    json['PaymentsCount'] as int
  );
}

Map<String, dynamic> _$LoanRequestToJson(LoanRequest instance) =>
    <String, dynamic>{
      'employeeId': instance.employeeId,
      'positionId': instance.positionId,
      'fullName': instance.fullName,
      'positionName': instance.positionName,
      'requestId': instance.requestId,
      'totalAmount': instance.totalAmount,
      'monthlyInstallment': instance.monthlyInstallment,
      'requestDate': instance.requestDate.toIso8601String(),
      'note': instance.note,
      'description': instance.description,
      'firstRepresentative': instance.firstRepresentative,
      'secondRepresentative': instance.secondRepresentative,
      'workflowItemId': instance.workflowItemId,
      'pendingType': instance.pendingType,
      'firstRepresentativeName': instance.firstRepresentativeName,
      'secondRepresentativeName': instance.secondRepresentativeName,
      'paymentsCount': instance.paymentsCount,
    };
