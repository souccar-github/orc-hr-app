import 'package:json_annotation/json_annotation.dart';

part 'LeaveInfoModel.g.dart';

@JsonSerializable()
class LeaveInfoModel {
  final int id;
  final String title;
  final double balance;
  final double granted;
  final double remain;
  final double monthlyBalance;
  final double monthlyGranted;
  final double monthlyRemain;
  final int maximumNumber;
  final bool hasMonthlyBalance;
  final bool isDivisibleToHours;
  final bool isIndivisible;
  final bool hasMaximumNumber;

  LeaveInfoModel(
    this.id,
    this.title,
      this.balance,
      this.granted,
      this.hasMaximumNumber,
      this.hasMonthlyBalance,
      this.isDivisibleToHours,
      this.isIndivisible,
      this.maximumNumber,
      this.monthlyBalance,
      this.monthlyGranted,
      this.monthlyRemain,
      this.remain);

  factory LeaveInfoModel.fromJson(Map<String, dynamic> json) =>
      _$LeaveInfoModelFromJson(json);
  Map<String, dynamic> toJson() => _$LeaveInfoModelToJson(this);
}
