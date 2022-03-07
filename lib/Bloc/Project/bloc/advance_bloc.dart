import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:orc_hr/API/Project/Project.dart';
import 'package:orc_hr/Models/Project/AdvanceRequest.dart';
import 'package:orc_hr/Models/Project/WorkflowInfo.dart';
part 'advance_event.dart';
part 'advance_state.dart';

class AdvanceBloc extends Bloc<AdvanceEvent, AdvanceState> {
  AdvanceBloc() : super(AdvanceInitial());

  @override
  Stream<AdvanceState> mapEventToState(
    AdvanceEvent event,
  ) async* {
    if (event is PostAdvanceRequest) {
      yield AdvanceLoading();
      String error = null;
      String success;
      await Project.apiClient.addAdvanceRequest(event.advance).then((onValue) {
        success = onValue;
      }).catchError((onError) {
        error = onError;
      });

      if (error == null) {
        yield PostAdvanceRequestSuccessfully();
      } else {
        yield AdvanceError(error);
      }
    }

    if (event is AcceptAdvanceRequest) {
      yield AdvanceLoading();
      String error = null;
      var info;
      await Project.apiClient
          .acceptAdvanceRequest(event.workflowId, event.advanceId, event.note)
          .then((onValue) {
        info = onValue;
      }).catchError((onError) {
        error = onError;
      });
      if (error == null) {
        yield AcceptAdvanceRequestSuccessfully();
      } else {
        yield AdvanceError(error);
      }
    }

    if (event is RejectAdvanceRequest) {
      yield AdvanceLoading();
      String error = null;
      var info;
      await Project.apiClient
          .rejectAdvanceRequest(event.workflowId, event.advanceId, event.note)
          .then((onValue) {
        info = onValue;
      }).catchError((onError) {
        error = onError;
      });
      if (error == null) {
        yield RejectAdvanceRequestSuccessfully();
      } else {
        yield AdvanceError(error);
      }
    }

    if (event is PendingAdvanceRequest) {
      yield AdvanceLoading();
      String error = null;
      var info;
      await Project.apiClient
          .pendingAdvanceRequest(event.workflowId, event.advanceId, event.note)
          .then((onValue) {
        info = onValue;
      }).catchError((onError) {
        error = onError;
      });
      if (error == null) {
        yield PendingAdvanceRequestSuccessfully();
      } else {
        yield AdvanceError(error);
      }
    }

    if (event is GetPendingAdvanceRequests) {
      yield AdvanceLoading();
      String error = null;
      var _list = new List<AdvanceRequest>();
      await Project.apiClient.getPendingAdvanceRequests().then((onValue) {
        _list = onValue;
      }).catchError((onError) {
        error = onError;
      });
      if (error == null) {
        yield GetPendingAdvanceRequestsSuccessfully(_list);
      } else {
        yield AdvanceError(error);
      }
    }

    if (event is GetMyPendingRequests) {
      yield AdvanceLoading();
      String error = null;
      var _list = new List<WorkflowInfo>();
      await Project.apiClient.getMyPendingAdvanceRequests().then((onValue) {
        _list = onValue;
      }).catchError((onError) {
        error = onError;
      });
      if (error == null) {
        yield GetMyPendingRequestsSuccessfully(_list);
      } else {
        yield AdvanceError(error);
      }
    }
    if (event is GetDesAmount) {
      String error = null;
      double desAmount;
      await Project.apiClient.getDesAmount().then((onValue) {
        desAmount = onValue;
      }).catchError((onError) {
        error = onError;
      });
      if (error == null) {
        yield GetDesAmountSuccessfully(desAmount);
      } else {
        yield AdvanceError(error);
      }
    }
  }
}
