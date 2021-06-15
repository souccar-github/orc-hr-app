part of 'leave_bloc.dart';

abstract class LeaveEvent {
}

class InitMainLeavesBalancePage extends LeaveEvent{
}

class GetLeaveSettingInfo extends LeaveEvent{
  final int id ;
  final DateTime startDate;
  GetLeaveSettingInfo(this.id,this.startDate);
}

class GetLeaveSettings extends LeaveEvent{
}

class GetLeaveReasons extends LeaveEvent{
}

class GetSpentDays extends LeaveEvent{
  final LeaveRequest leave ;
  GetSpentDays(this.leave);
}

class PostLeaveRequest extends LeaveEvent{
  final LeaveRequest leave;
  final LeaveInfoModel info;
  final double duration;
  PostLeaveRequest(this.leave,this.info,this.duration);
}

class GetPendingLeaveRequests extends LeaveEvent{
}

class AcceptLeaveRequest extends LeaveEvent{
  final int workflowId;
  final int leaveId;
  final String note;

  AcceptLeaveRequest(this.workflowId, this.leaveId, this.note);
}

class RejectLeaveRequest extends LeaveEvent{
  final int workflowId;
  final int leaveId;
  final String note;

  RejectLeaveRequest(this.workflowId, this.leaveId, this.note);
}

class PendingLeaveRequest extends LeaveEvent{
  final int workflowId;
  final int leaveId;
  final String note;

  PendingLeaveRequest(this.workflowId, this.leaveId, this.note);
}