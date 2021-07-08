part of 'mission_bloc.dart';

abstract class MissionEvent {}

class InitMainMissionsBalancePage extends MissionEvent {}

class PostMissionRequest extends MissionEvent {
  final MissionRequest mission;
  PostMissionRequest(this.mission);
}

class GetPendingMissionRequests extends MissionEvent {}

class AcceptMissionRequest extends MissionEvent {
  final int workflowId;
  final int missionId;
  final String note;
  final bool hourly;

  AcceptMissionRequest(this.workflowId, this.missionId, this.note,this.hourly);
}

class GetMyPendingRequests extends MissionEvent {}

class RejectMissionRequest extends MissionEvent {
  final int workflowId;
  final int missionId;
  final String note;
  final bool hourly;

  RejectMissionRequest(this.workflowId, this.missionId, this.note,this.hourly);
}

class PendingMissionRequest extends MissionEvent {
  final int workflowId;
  final int missionId;
  final String note;
  final bool hourly;

  PendingMissionRequest(this.workflowId, this.missionId, this.note,this.hourly);
}
