// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'LeaveSetting.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeaveSetting _$LeaveSettingsFromJson(Map<String, dynamic> json) {
  return LeaveSetting(
    json['Id'] as int,
    json['Title'] as String,
  );
}

Map<String, dynamic> _$LeaveSettingsToJson(LeaveSetting instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
    };
