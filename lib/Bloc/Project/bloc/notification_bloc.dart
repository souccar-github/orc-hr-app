import 'dart:async';

import 'package:orc_hr/API/Project/Project.dart';
import 'package:orc_hr/Models/Project/LeaveRequest.dart';
import 'package:orc_hr/Models/Project/EntranceExitRequest.dart';
import 'package:orc_hr/Models/Project/MissionRequest.dart';
import 'package:orc_hr/Models/Project/Notify.dart';
import 'package:bloc/bloc.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(NotificationInitial()) {
    on<GetUnreadNotifications>((event, emit) async {
      emit(NotificationLoading());
      String? error;
      List<Notify> _list = [];
      await Project.apiClient.getUnreadNotification().then((onValue) {
        _list = onValue;
      }).catchError((onError) {
        error = onError;
      });
      if (error == null) {
        emit(GetNotificationsSuccessfully(_list));
      } else {
        emit(NotificationError(error ?? ""));
      }
    });
    on<GetLeaveByWorkflowId>((event, emit) async {
      emit(NotificationLoading());
      String? error;
      LeaveRequest? leave;
      await Project.apiClient.getLeaveByWorkflow(event.id).then((onValue) {
        leave = onValue;
      }).catchError((onError) {
        error = onError;
      });
      if (error == null) {
        emit(GetLeaveByWorkflowIdSuccessfully(leave));
      } else {
        emit(NotificationError(error ?? ""));
      }
    });

    on<GetEntranceExitRecordByWorkflowId>((event, emit) async {
      emit(NotificationLoading());
      String? error;
      EntranceExitRequest? leave;
      await Project.apiClient
          .getEntranceExitRecordByWorkflow(event.id)
          .then((onValue) {
        leave = onValue;
      }).catchError((onError) {
        error = onError;
      });
      if (error == null) {
        emit(GetEntranceExitRecordByWorkflowIdSuccessfully(leave));
      } else {
        emit(NotificationError(error ?? ""));
      }
    });

    on<GetTravelMissionByWorkflowId>((event, emit) async {
      emit(NotificationLoading());
      String? error;
      MissionRequest? mission;
      await Project.apiClient
          .getTravelMissionByWorkflow(event.id)
          .then((onValue) {
        mission = onValue;
      }).catchError((onError) {
        error = onError;
      });
      if (error == null) {
        emit(GetTravelMissionByWorkflowIdSuccessfully(mission));
      } else {
        emit(NotificationError(error ?? ""));
      }
    });

    on<GetHourlyMissionByWorkflowId>((event, emit) async {
      emit(NotificationLoading());
      String? error;
      MissionRequest? mission;
      await Project.apiClient
          .getHourlyMissionByWorkflow(event.id)
          .then((onValue) {
        mission = onValue;
      }).catchError((onError) {
        error = onError;
      });
      if (error == null) {
        emit(GetHourlyMissionByWorkflowIdSuccessfully(mission));
      } else {
        emit(NotificationError(error ?? ""));
      }
    });
  }
}
