import 'dart:async';

import 'package:orc_hr/API/Project/Project.dart';
import 'package:orc_hr/Models/Project/LeaveRequest.dart';
import 'package:orc_hr/Models/Project/EntranceExitRequest.dart';
import 'package:orc_hr/Models/Project/Notify.dart';
import 'package:bloc/bloc.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(NotificationInitial());

  @override
  Stream<NotificationState> mapEventToState(
    NotificationEvent event,
  ) async* {
    if (event is GetUnreadNotifications){
      yield NotificationLoading();
      String error = null;
      var _list = new List<Notify>();
      await Project.apiClient.getUnreadNotification().then((onValue) {
        _list = onValue;
      }).catchError((onError) {
        error = onError;
      });
      if (error == null) {
        yield GetNotificationsSuccessfully(_list);
      } else {
        yield NotificationError(error);
      }
    }
    if (event is GetLeaveByWorkflowId){
      yield NotificationLoading();
      String error = null;
      LeaveRequest leave;
      await Project.apiClient.getLeaveByWorkflow(event.id).then((onValue) {
        leave = onValue;
      }).catchError((onError) {
        error = onError;
      });
      if (error == null) {
        yield GetLeaveByWorkflowIdSuccessfully(leave);
      } else {
        yield NotificationError(error);
      }
    }

    if (event is GetEntranceExitRecordByWorkflowId){
      yield NotificationLoading();
      String error = null;
      EntranceExitRequest leave;
      await Project.apiClient.getEntranceExitRecordByWorkflow(event.id).then((onValue) {
        leave = onValue;
      }).catchError((onError) {
        error = onError;
      });
      if (error == null) {
        yield GetEntranceExitRecordByWorkflowIdSuccessfully(leave);
      } else {
        yield NotificationError(error);
      }
    }
  }
}
