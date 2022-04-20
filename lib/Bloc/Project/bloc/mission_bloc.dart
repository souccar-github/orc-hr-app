import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:orc_hr/API/Project/Project.dart';
import 'package:orc_hr/Models/Project/MissionRequest.dart';
import 'package:orc_hr/Models/Project/WorkflowInfo.dart';
part 'mission_event.dart';
part 'mission_state.dart';

class MissionBloc extends Bloc<MissionEvent, MissionState> {
  MissionBloc() : super(MissionInitial()) {
    on<PostMissionRequest>((event, emit) async {
      emit(MissionLoading());
      String? error;
      String success;
      await Project.apiClient.addMissionRequest(event.mission).then((onValue) {
        success = onValue;
      }).catchError((onError) {
        error = onError;
      });

      if (error == null) {
        emit(PostMissionRequestSuccessfully());
      } else {
        emit(MissionError(error??""));
      }
    });

    on<AcceptMissionRequest>((event, emit) async {
      emit(MissionLoading());
      String? error;
      var info;
      await Project.apiClient
          .acceptMissionRequest(event.workflowId, event.missionId, event.note,event.hourly)
          .then((onValue) {
        info = onValue;
      }).catchError((onError) {
        error = onError;
      });
      if (error == null) {
        emit(AcceptMissionRequestSuccessfully());
      } else {
        emit(MissionError(error??""));
      }
    });

    on<RejectMissionRequest>((event, emit) async {
      emit(MissionLoading());
      String? error;
      var info;
      await Project.apiClient
          .rejectMissionRequest(event.workflowId, event.missionId, event.note,event.hourly)
          .then((onValue) {
        info = onValue;
      }).catchError((onError) {
        error = onError;
      });
      if (error == null) {
        emit(RejectMissionRequestSuccessfully());
      } else {
        emit(MissionError(error??""));
      }
    }
    );
    on<PendingMissionRequest>((event, emit) async {
      emit(MissionLoading());
      String? error;
      var info;
      await Project.apiClient
          .pendingMissionRequest(event.workflowId, event.missionId, event.note,event.hourly)
          .then((onValue) {
        info = onValue;
      }).catchError((onError) {
        error = onError;
      });
      if (error == null) {
        emit(PendingMissionRequestSuccessfully());
      } else {
        emit(MissionError(error??""));
      }
    });

    on<GetPendingMissionRequests>((event, emit) async {
      emit(MissionLoading());
      String? error;
      List<MissionRequest> _list = [];
      await Project.apiClient.getPendingMissionRequests().then((onValue) {
        _list = onValue;
      }).catchError((onError) {
        error = onError;
      });
      if (error == null) {
        emit(GetPendingMissionRequestsSuccessfully(_list));
      } else {
        emit(MissionError(error??""));
      }
    });

    on<GetMyPendingRequests>((event, emit) async {
      emit(MissionLoading());
      String? error;
      List<WorkflowInfo> _list = [];
      await Project.apiClient.getMyPendingMissionRequests().then((onValue) {
        _list = onValue;
      }).catchError((onError) {
        error = onError;
      });
      if (error == null) {
        emit(GetMyPendingRequestsSuccessfully(_list));
      } else {
        emit(MissionError(error??""));
      }
    });
  }
}
