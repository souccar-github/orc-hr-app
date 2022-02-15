part of 'notification_bloc.dart';

abstract class NotificationEvent {
  
}

class GetUnreadNotifications extends NotificationEvent{}

class GetLeaveByWorkflowId extends NotificationEvent{
  final int id;

  GetLeaveByWorkflowId(this.id);
}

class GetHourlyMissionByWorkflowId extends NotificationEvent{
  final int id;

  GetHourlyMissionByWorkflowId(this.id);
}

class GetTravelMissionByWorkflowId extends NotificationEvent{
  final int id;

  GetTravelMissionByWorkflowId(this.id);
}

class GetEntranceExitRecordByWorkflowId extends NotificationEvent{
  final int id;

  GetEntranceExitRecordByWorkflowId(this.id);
}

