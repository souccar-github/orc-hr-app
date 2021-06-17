part of 'notification_bloc.dart';

abstract class NotificationEvent {
  
}

class GetUnreadNotifications extends NotificationEvent{}

class GetLeaveByWorkflowId extends NotificationEvent{
  final int id;

  GetLeaveByWorkflowId(this.id);
}

class GetEntranceExitRecordByWorkflowId extends NotificationEvent{
  final int id;

  GetEntranceExitRecordByWorkflowId(this.id);
}

