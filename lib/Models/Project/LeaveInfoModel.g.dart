// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'LeaveInfoModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeaveInfoModel _$LeaveInfoModelFromJson(Map<String, dynamic> json) {
  return LeaveInfoModel(
    json['Id'] as int,
    json['Title'] as String,
    (json['Balance'] as num)?.toDouble(),
    (json['Granted'] as num)?.toDouble(),
    json['HasMaximumNumber'] as bool,
    json['HasMonthlyBalance'] as bool,
    json['IsDivisibleToHours'] as bool,
    json['IsIndivisible'] as bool,
    json['MaximumNumber'] as int,
    (json['MonthlyBalance'] as num)?.toDouble(),
    (json['MonthlyGranted'] as num)?.toDouble(),
    (json['MonthlyRemain'] as num)?.toDouble(),
    (json['Remain'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$LeaveInfoModelToJson(LeaveInfoModel instance) =>
    <String, dynamic>{
      'id' : instance.id,
      'title': instance.title,
      'balance': instance.balance,
      'granted': instance.granted,
      'remain': instance.remain,
      'monthlyBalance': instance.monthlyBalance,
      'monthlyGranted': instance.monthlyGranted,
      'monthlyRemain': instance.monthlyRemain,
      'maximumNumber': instance.maximumNumber,
      'hasMonthlyBalance': instance.hasMonthlyBalance,
      'isDivisibleToHours': instance.isDivisibleToHours,
      'isIndivisible': instance.isIndivisible,
      'hasMaximumNumber': instance.hasMaximumNumber,
    };
