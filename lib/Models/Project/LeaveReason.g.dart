// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'LeaveReason.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeaveReason _$LeaveReasonsFromJson(Map<String, dynamic> json) {
  return LeaveReason(
    json['Id'] as int,
    json['Title'] as String,
  );
}

Map<String, dynamic> _$LeaveReasonsToJson(LeaveReason instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
    };
