import 'package:json_annotation/json_annotation.dart';

part 'LeaveSetting.g.dart';

@JsonSerializable()
class LeaveSetting {
  final int id;
  final String title;

  LeaveSetting(
      this.id,
      this.title);

  factory LeaveSetting.fromJson(Map<String, dynamic> json) =>
      _$LeaveSettingsFromJson(json);
  Map<String, dynamic> toJson() => _$LeaveSettingsToJson(this);
}
