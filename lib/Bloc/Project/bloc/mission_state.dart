part of 'mission_bloc.dart';

abstract class MissionState {}

class MissionInitial extends MissionState {}

class MissionError extends MissionState {
  final String error;
  MissionError(this.error);
}

class MissionLoading extends MissionState {}

class GetSpentDaysSuccessfully extends MissionState {
  final String days;
  GetSpentDaysSuccessfully(this.days);
}

class GetMyPendingRequestsSuccessfully extends MissionState {
  final List<WorkflowInfo> list;

  GetMyPendingRequestsSuccessfully(this.list);
}

class DaysLoading extends MissionState {}

class PostMissionRequestSuccessfully extends MissionState {}

class AcceptMissionRequestSuccessfully extends MissionState {}

class PendingMissionRequestSuccessfully extends MissionState {}

class RejectMissionRequestSuccessfully extends MissionState {}

class GetPendingMissionRequestsSuccessfully extends MissionState {
  final List<MissionRequest> items;

  GetPendingMissionRequestsSuccessfully(this.items);
}
