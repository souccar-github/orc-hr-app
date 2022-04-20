import 'package:json_annotation/json_annotation.dart';

part 'LoanRequest.g.dart';

@JsonSerializable()
class LoanRequest {
  final int employeeId;
  final int positionId;
  final String fullName;
  final String positionName;
  final int requestId;
  final int paymentsCount;
  final double totalAmount;
  final double monthlyInstallment;
  final DateTime requestDate;
  final String note;
  final String secondRepresentativeName;
  final String firstRepresentativeName;
  final String description;
  final int firstRepresentative;
  final int secondRepresentative;
  final int workflowItemId;
  final int pendingType;

  LoanRequest(
      this.employeeId,
      this.fullName,
      this.requestId,
      this.totalAmount,
      this.monthlyInstallment,
      this.pendingType,
      this.positionId,
      this.positionName,
      this.requestDate,
      this.workflowItemId,
      this.firstRepresentative,
      this.secondRepresentative,
      this.note,
      this.description,
      this.firstRepresentativeName,
      this.secondRepresentativeName,
      this.paymentsCount);

  factory LoanRequest.fromJson(Map<String, dynamic> json) =>
      _$LoanRequestFromJson(json);
  Map<String, dynamic> toJson() => _$LoanRequestToJson(this);
}
