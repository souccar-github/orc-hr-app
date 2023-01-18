import 'package:json_annotation/json_annotation.dart';

part 'MissionRequest.g.dart';

@JsonSerializable()
class MissionRequest {
  final int employeeId;
  final int positionId;
  final String? fullName;
  final String ?positionName;
  final int missionId;
  final DateTime startDate;
  DateTime endDate;
  final bool isHourlyMission;
  final DateTime? fromTime;
  final DateTime? toTime;
  final DateTime requestDate;
  final String ?description;
  final String ?note;
  final String? typeString;
  final int workflowItemId;
  final int type;
  final int pendingType;

  MissionRequest(
      this.description,
      this.employeeId,
      this.endDate,
      this.fromTime,
      this.fullName,
      this.isHourlyMission,
      this.missionId,
      this.pendingType,
      this.positionId,
      this.positionName,
      this.requestDate,
      this.startDate,
      this.toTime,
      this.workflowItemId,
      this.type,
      this.typeString,
      this.note);

  factory MissionRequest.fromJson(Map<String, dynamic> json) =>
      _$MissionRequestFromJson(json);
  Map<String, dynamic> toJson() => _$MissionRequestToJson(this);
}
