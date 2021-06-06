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
  PostLeaveRequest(this.leave);
}