import 'package:json_annotation/json_annotation.dart';

part 'LeaveReason.g.dart';

@JsonSerializable()
class LeaveReason {
  final int id;
  final String title;

  LeaveReason(
      this.id,
      this.title);

  factory LeaveReason.fromJson(Map<String, dynamic> json) =>
      _$LeaveReasonsFromJson(json);
  Map<String, dynamic> toJson() => _$LeaveReasonsToJson(this);
}
