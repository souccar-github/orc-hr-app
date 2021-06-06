// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AuthModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthModel _$AuthModelFromJson(Map<String, dynamic> json) {
  return AuthModel(
    json['username'] as String,
    json['password'] as String,
  );
}

Map<String, dynamic> _$AuthModelToJson(AuthModel instance) => <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
    };
