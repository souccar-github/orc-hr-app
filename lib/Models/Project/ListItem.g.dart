// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ListItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListItem _$ListItemsFromJson(Map<String, dynamic> json) {
  return ListItem(
    json['Id'] as int,
    json['Name'] as String,
  );
}

Map<String, dynamic> _$ListItemsToJson(ListItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
