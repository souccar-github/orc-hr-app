part of 'notification_bloc.dart';

abstract class NotificationState {
}

class NotificationLoading extends NotificationState {}
class NotificationInitial extends NotificationState{}
class NotificationError extends NotificationState {
  final String error;

  NotificationError(this.error);
}
class GetNotificationsSuccessfully extends NotificationState{
  final List<Notify> items;

  GetNotificationsSuccessfully(this.items);
}

class GetLeaveByWorkflowIdSuccessfully extends NotificationState{
  final LeaveRequest item;

  GetLeaveByWorkflowIdSuccessfully(this.item);
}