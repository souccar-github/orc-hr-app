
import 'package:json_annotation/json_annotation.dart';

part 'AuthModel.g.dart';

@JsonSerializable()
class AuthModel {
  final String username;
  final String password;

  AuthModel(this.username, this.password);

  factory AuthModel.fromJson(Map<String, dynamic> json) => _$AuthModelFromJson(json);
  Map<String, dynamic> toJson() => _$AuthModelToJson(this);
}


