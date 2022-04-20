import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:orc_hr/API/Project/Project.dart';
import 'package:orc_hr/Models/Project/EntranceExitRequest.dart';
import 'package:orc_hr/Models/Project/WorkflowInfo.dart';

part 'entranceexit_event.dart';
part 'entranceexit_state.dart';

class EntranceexitBloc extends Bloc<EntranceexitEvent, EntranceexitState> {
  EntranceexitBloc() : super(EntranceexitInitial())
  {
    on<PostEntranceExitRequest>((event, emit) async {
      emit(EntranceExitLoading());
      String? error;
      var info;
      if (event.model.logType == null) {
        error = "Required Message";
        emit(EntranceExitError(error));
      } else {
        await Project.apiClient.addEntranceExitRequest(event.model).then((onValue) {
          info = onValue;
        }).catchError((onError) {
          error = onError;
        });
      }
      if (error == null) {
        emit(PostEntranceExitRequestSuccessfully());
      } else {
        emit(EntranceExitError(error??""));
      }
    });
    on<AcceptEntranceexitRequest>((event, emit) async {
      emit(EntranceExitLoading());
      String? error;
      var info;
      await Project.apiClient
          .acceptEntranceExitRequest(event.workflowId, event.recordId, event.note)
          .then((onValue) {
        info = onValue;
      }).catchError((onError) {
        error = onError;
      });
      if (error == null) {
        emit(AcceptEntranceexitRequestSuccessfully());
      } else {
        emit(EntranceExitError(error??""));
      }
    });

    on<RejectEntranceexitRequest>((event, emit) async {
      emit(EntranceExitLoading());
      String? error;
      var info;
      await Project.apiClient
          .rejectEntranceExitRequest(event.workflowId, event.recordId, event.note)
          .then((onValue) {
        info = onValue;
      }).catchError((onError) {
        error = onError;
      });
      if (error == null) {
        emit(RejectEntranceexitRequestSuccessfully());
      } else {
        emit(EntranceExitError(error??""));
      }
    });

    on<PendingEntranceexitRequest>((event, emit) async {
      emit(EntranceExitLoading());
      String? error;
      var info;
      await Project.apiClient
          .pendingEntranceExitRequest(event.workflowId, event.recordId, event.note)
          .then((onValue) {
        info = onValue;
      }).catchError((onError) {
        error = onError;
      });
      if (error == null) {
        emit(PendingEntranceexitRequestSuccessfully());
      } else {
        emit(EntranceExitError(error??""));
      }
    });

    on<GetPendingEntranceexitRequests>((event, emit) async {
      emit(EntranceExitLoading());
      String? error;
      List<EntranceExitRequest> _list = [];
      await Project.apiClient.getPendingEntranceExitRequests().then((onValue) {
        _list = onValue;
      }).catchError((onError) {
        error = onError;
      });
      if (error == null) {
        emit(GetPendingEntranceexitRequestsSuccessfully(_list));
      } else {
        emit(EntranceExitError(error??""));
      }
    }
    );
    on<GetEntranceExitReport>((event, emit) async {
      emit(EntranceExitLoading());
      String? error;
      List<EntranceExitRequest> _list = [];
      await Project.apiClient.getEntranceExitReport(event.fromDate,event.toDate).then((onValue) {
        _list = onValue;
      }).catchError((onError) {
        error = onError;
      });
      if (error == null) {
        emit(GetEntranceExitReportSuccessfully(_list));
      } else {
        emit(EntranceExitError(error??""));
      }
    });

    on<GetMyPendingRequests>((event, emit) async {
      emit(EntranceExitLoading());
      String? error;
      List<WorkflowInfo> _list = [];
      await Project.apiClient.getMyPendingEntranceExitRequests().then((onValue) {
        _list = onValue;
      }).catchError((onError) {
        error = onError;
      });
      if (error == null) {
        emit(GetMyPendingRequestsSuccessfully(_list));
      } else {
        emit(EntranceExitError(error??""));
      }
    });
  }
}
