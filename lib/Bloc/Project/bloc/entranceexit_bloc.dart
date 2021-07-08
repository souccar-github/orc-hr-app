import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:orc_hr/API/Project/Project.dart';
import 'package:orc_hr/Models/Project/EntranceExitRequest.dart';
import 'package:orc_hr/Models/Project/WorkflowInfo.dart';

part 'entranceexit_event.dart';
part 'entranceexit_state.dart';

class EntranceexitBloc extends Bloc<EntranceexitEvent, EntranceexitState> {
  EntranceexitBloc() : super(EntranceexitInitial());

  @override
  Stream<EntranceexitState> mapEventToState(
    EntranceexitEvent event,
  ) async* {
    if (event is PostEntranceExitRequest) {
      yield EntranceExitLoading();
      String error = null;
      var info;
      if (event.model.logType == null) {
        error = "Required Message";
        yield EntranceExitError(error);
      } else {
        await Project.apiClient.addEntranceExitRequest(event.model).then((onValue) {
          info = onValue;
        }).catchError((onError) {
          error = onError;
        });
      }
      if (error == null) {
        yield PostEntranceExitRequestSuccessfully();
      } else {
        yield EntranceExitError(error);
      }
    }
    if (event is AcceptEntranceexitRequest) {
      yield EntranceExitLoading();
      String error = null;
      var info;
      await Project.apiClient
          .acceptEntranceExitRequest(event.workflowId, event.recordId, event.note)
          .then((onValue) {
        info = onValue;
      }).catchError((onError) {
        error = onError;
      });
      if (error == null) {
        yield AcceptEntranceexitRequestSuccessfully();
      } else {
        yield EntranceExitError(error);
      }
    }

    if (event is RejectEntranceexitRequest) {
      yield EntranceExitLoading();
      String error = null;
      var info;
      await Project.apiClient
          .rejectEntranceExitRequest(event.workflowId, event.recordId, event.note)
          .then((onValue) {
        info = onValue;
      }).catchError((onError) {
        error = onError;
      });
      if (error == null) {
        yield RejectEntranceexitRequestSuccessfully();
      } else {
        yield EntranceExitError(error);
      }
    }

    if (event is PendingEntranceexitRequest) {
      yield EntranceExitLoading();
      String error = null;
      var info;
      await Project.apiClient
          .pendingEntranceExitRequest(event.workflowId, event.recordId, event.note)
          .then((onValue) {
        info = onValue;
      }).catchError((onError) {
        error = onError;
      });
      if (error == null) {
        yield PendingEntranceexitRequestSuccessfully();
      } else {
        yield EntranceExitError(error);
      }
    }

    if (event is GetPendingEntranceexitRequests) {
      yield EntranceExitLoading();
      String error = null;
      var _list = new List<EntranceExitRequest>();
      await Project.apiClient.getPendingEntranceExitRequests().then((onValue) {
        _list = onValue;
      }).catchError((onError) {
        error = onError;
      });
      if (error == null) {
        yield GetPendingEntranceexitRequestsSuccessfully(_list);
      } else {
        yield EntranceExitError(error);
      }
    }

    if (event is GetMyPendingRequests) {
      yield EntranceExitLoading();
      String error = null;
      var _list = new List<WorkflowInfo>();
      await Project.apiClient.getMyPendingEntranceExitRequests().then((onValue) {
        _list = onValue;
      }).catchError((onError) {
        error = onError;
      });
      if (error == null) {
        yield GetMyPendingRequestsSuccessfully(_list);
      } else {
        yield EntranceExitError(error);
      }
    }
  }
}
