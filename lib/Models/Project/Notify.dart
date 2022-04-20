import 'package:json_annotation/json_annotation.dart';

part 'Notify.g.dart';

@JsonSerializable()
class Notify {
  final int? workflowItemId;
  final String? body;
  final String? type;

  Notify(
      this.workflowItemId,
      this.body,
      this.type);

  factory Notify.fromJson(Map<String, dynamic> json) =>
      _$NotifysFromJson(json);
  Map<String, dynamic> toJson() => _$NotifysToJson(this);
}
