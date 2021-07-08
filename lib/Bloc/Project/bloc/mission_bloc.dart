import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:orc_hr/API/Project/Project.dart';
import 'package:orc_hr/Models/Project/MissionRequest.dart';
import 'package:orc_hr/Models/Project/WorkflowInfo.dart';
part 'mission_event.dart';
part 'mission_state.dart';

class MissionBloc extends Bloc<MissionEvent, MissionState> {
  MissionBloc() : super(MissionInitial());

  @override
  Stream<MissionState> mapEventToState(
    MissionEvent event,
  ) async* {
    if (event is PostMissionRequest) {
      yield MissionLoading();
      String error = null;
      String success;
      await Project.apiClient.addMissionRequest(event.mission).then((onValue) {
        success = onValue;
      }).catchError((onError) {
        error = onError;
      });

      if (error == null) {
        yield PostMissionRequestSuccessfully();
      } else {
        yield MissionError(error);
      }
    }

    if (event is AcceptMissionRequest) {
      yield MissionLoading();
      String error = null;
      var info;
      await Project.apiClient
          .acceptMissionRequest(event.workflowId, event.missionId, event.note,event.hourly)
          .then((onValue) {
        info = onValue;
      }).catchError((onError) {
        error = onError;
      });
      if (error == null) {
        yield AcceptMissionRequestSuccessfully();
      } else {
        yield MissionError(error);
      }
    }

    if (event is RejectMissionRequest) {
      yield MissionLoading();
      String error = null;
      var info;
      await Project.apiClient
          .rejectMissionRequest(event.workflowId, event.missionId, event.note,event.hourly)
          .then((onValue) {
        info = onValue;
      }).catchError((onError) {
        error = onError;
      });
      if (error == null) {
        yield RejectMissionRequestSuccessfully();
      } else {
        yield MissionError(error);
      }
    }

    if (event is PendingMissionRequest) {
      yield MissionLoading();
      String error = null;
      var info;
      await Project.apiClient
          .pendingMissionRequest(event.workflowId, event.missionId, event.note,event.hourly)
          .then((onValue) {
        info = onValue;
      }).catchError((onError) {
        error = onError;
      });
      if (error == null) {
        yield PendingMissionRequestSuccessfully();
      } else {
        yield MissionError(error);
      }
    }

    if (event is GetPendingMissionRequests) {
      yield MissionLoading();
      String error = null;
      var _list = new List<MissionRequest>();
      await Project.apiClient.getPendingMissionRequests().then((onValue) {
        _list = onValue;
      }).catchError((onError) {
        error = onError;
      });
      if (error == null) {
        yield GetPendingMissionRequestsSuccessfully(_list);
      } else {
        yield MissionError(error);
      }
    }

    if (event is GetMyPendingRequests) {
      yield MissionLoading();
      String error = null;
      var _list = new List<WorkflowInfo>();
      await Project.apiClient.getMyPendingMissionRequests().then((onValue) {
        _list = onValue;
      }).catchError((onError) {
        error = onError;
      });
      if (error == null) {
        yield GetMyPendingRequestsSuccessfully(_list);
      } else {
        yield MissionError(error);
      }
    }
  }
}
