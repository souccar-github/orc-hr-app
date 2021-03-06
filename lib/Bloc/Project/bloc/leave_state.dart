part of 'leave_bloc.dart';

abstract class LeaveState {}

class LeaveInitial extends LeaveState {}

class MainLeavesBalanceInitSuccessfully extends LeaveState {
  final List<LeaveInfoModel> infos;
  MainLeavesBalanceInitSuccessfully(this.infos);
}

class LeaveError extends LeaveState {
  final String error;
  LeaveError(this.error);
}

class GetLeaveSettingInfoSuccessfully extends LeaveState {
  final LeaveInfoModel info;

  GetLeaveSettingInfoSuccessfully(this.info);
}

class GetLeaveSettingsSuccessfully extends LeaveState {
  final List<LeaveSetting> settings;

  GetLeaveSettingsSuccessfully(this.settings);
}

class GetLeaveReasonsSuccessfully extends LeaveState {
  final List<LeaveReason> reasons;

  GetLeaveReasonsSuccessfully(this.reasons);
}

class LeaveLoading extends LeaveState {}

class GetSpentDaysSuccessfully extends LeaveState {
  final String days;
  GetSpentDaysSuccessfully(this.days);
}

class GetMyPendingRequestsSuccessfully extends LeaveState{
  final List<WorkflowInfo> list;

  GetMyPendingRequestsSuccessfully(this.list);
}

class DaysLoading extends LeaveState {}

class PostLeaveRequestSuccessfully extends LeaveState {}

class AcceptLeaveRequestSuccessfully extends LeaveState {}

class PendingLeaveRequestSuccessfully extends LeaveState {}

class RejectLeaveRequestSuccessfully extends LeaveState {}

class GetPendingLeaveRequestsSuccessfully extends LeaveState {
  final List<LeaveRequest> items;

  GetPendingLeaveRequestsSuccessfully(this.items);
}
