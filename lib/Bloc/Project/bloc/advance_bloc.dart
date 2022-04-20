import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:orc_hr/API/Project/Project.dart';
import 'package:orc_hr/Models/Project/AdvanceRequest.dart';
import 'package:orc_hr/Models/Project/WorkflowInfo.dart';
part 'advance_event.dart';
part 'advance_state.dart';

class AdvanceBloc extends Bloc<AdvanceEvent, AdvanceState> {
  AdvanceBloc() : super(AdvanceInitial())
  
  {
    on<PostAdvanceRequest>((event, emit) async {
      emit( AdvanceLoading());
      String? error;
      String success;
      await Project.apiClient.addAdvanceRequest(event.advance).then((onValue) {
        success = onValue;
      }).catchError((onError) {
        error = onError;
      });

      if (error == null) {
        emit(PostAdvanceRequestSuccessfully());
      } else {
        emit(AdvanceError(error??""));
      }
    });

    on<AcceptAdvanceRequest>((event, emit) async {
      emit(AdvanceLoading());
      String? error;
      var info;
      await Project.apiClient
          .acceptAdvanceRequest(event.workflowId, event.advanceId, event.note)
          .then((onValue) {
        info = onValue;
      }).catchError((onError) {
        error = onError;
      });
      if (error == null) {
        emit(AcceptAdvanceRequestSuccessfully());
      } else {
        emit(AdvanceError(error??""));
      }
    });

    on<RejectAdvanceRequest>((event, emit) async {
      emit(AdvanceLoading());
      String? error;
      var info;
      await Project.apiClient
          .rejectAdvanceRequest(event.workflowId, event.advanceId, event.note)
          .then((onValue) {
        info = onValue;
      }).catchError((onError) {
        error = onError;
      });
      if (error == null) {
        emit(RejectAdvanceRequestSuccessfully());
      } else {
        emit(AdvanceError(error??""));
      }
    });

    on<PendingAdvanceRequest>((event, emit) async {
      emit(AdvanceLoading());
      String? error;
      var info;
      await Project.apiClient
          .pendingAdvanceRequest(event.workflowId, event.advanceId, event.note)
          .then((onValue) {
        info = onValue;
      }).catchError((onError) {
        error = onError;
      });
      if (error == null) {
        emit(PendingAdvanceRequestSuccessfully());
      } else {
        emit(AdvanceError(error??""));
      }
    });

    on<GetPendingAdvanceRequests>((event, emit) async {
      emit(AdvanceLoading());
      String? error = null;
      List<AdvanceRequest> _list = [];
      await Project.apiClient.getPendingAdvanceRequests().then((onValue) {
        _list = onValue;
      }).catchError((onError) {
        error = onError;
      });
      if (error == null) {
        emit(GetPendingAdvanceRequestsSuccessfully(_list));
      } else {
        emit(AdvanceError(error??""));
      }
    });

    on<GetMyPendingRequests>((event, emit) async {
      emit(AdvanceLoading());
      String? error = null;
      List<WorkflowInfo> _list = [];
      await Project.apiClient.getMyPendingAdvanceRequests().then((onValue) {
        _list = onValue;
      }).catchError((onError) {
        error = onError;
      });
      if (error == null) {
        emit(GetMyPendingRequestsSuccessfully(_list));
      } else {
        emit(AdvanceError(error??""));
      }
    });
    on<GetDesAmount>((event, emit) async {
      String? error;
      double? desAmount;
      await Project.apiClient.getDesAmount().then((onValue) {
        desAmount = onValue;
      }).catchError((onError) {
        error = onError;
      });
      if (error == null) {
        emit(GetDesAmountSuccessfully(desAmount??0));
      } else {
        emit(AdvanceError(error??""));
      }
    });
  }
}
