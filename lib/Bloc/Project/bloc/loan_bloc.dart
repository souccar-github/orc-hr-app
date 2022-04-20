import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:orc_hr/API/Project/Project.dart';
import 'package:orc_hr/Models/Project/ListItem.dart';
import 'package:orc_hr/Models/Project/LoanRequest.dart';
import 'package:orc_hr/Models/Project/WorkflowInfo.dart';
part 'loan_event.dart';
part 'loan_state.dart';

class LoanBloc extends Bloc<LoanEvent, LoanState> {
  LoanBloc() : super(LoanInitial()) {
    on<PostLoanRequest>((event, emit) async {
      emit(LoanLoading());
      String? error;
      String success;
      await Project.apiClient.addLoanRequest(event.loan).then((onValue) {
        success = onValue;
      }).catchError((onError) {
        error = onError;
      });

      if (error == null) {
        emit(PostLoanRequestSuccessfully());
      } else {
        emit(LoanError(error??""));
      }
    });

    on<AcceptLoanRequest>((event, emit) async {
      emit(LoanLoading());
      String? error;
      var info;
      await Project.apiClient
          .acceptLoanRequest(event.workflowId, event.loanId, event.note)
          .then((onValue) {
        info = onValue;
      }).catchError((onError) {
        error = onError;
      });
      if (error == null) {
        emit(AcceptLoanRequestSuccessfully());
      } else {
        emit(LoanError(error??""));
      }
    });

    on<RejectLoanRequest>((event, emit) async {
      emit(LoanLoading());
      String? error;
      var info;
      await Project.apiClient
          .rejectLoanRequest(event.workflowId, event.loanId, event.note)
          .then((onValue) {
        info = onValue;
      }).catchError((onError) {
        error = onError;
      });
      if (error == null) {
        emit(RejectLoanRequestSuccessfully());
      } else {
        emit(LoanError(error??""));
      }
    });

    on<PendingLoanRequest>((event, emit) async {
      emit(LoanLoading());
      String? error;
      var info;
      await Project.apiClient
          .pendingLoanRequest(event.workflowId, event.loanId, event.note)
          .then((onValue) {
        info = onValue;
      }).catchError((onError) {
        error = onError;
      });
      if (error == null) {
        emit(PendingLoanRequestSuccessfully());
      } else {
        emit(LoanError(error??""));
      }
    });

    on<GetPendingLoanRequests>((event, emit) async {
      emit(LoanLoading());
      String? error;
      List<LoanRequest> _list = [];
      await Project.apiClient.getPendingLoanRequests().then((onValue) {
        _list = onValue;
      }).catchError((onError) {
        error = onError;
      });
      if (error == null) {
        emit(GetPendingLoanRequestsSuccessfully(_list));
      } else {
        emit(LoanError(error??""));
      }
    }
    );
    on<GetMyPendingRequests>((event, emit) async {
      emit(LoanLoading());
      String? error;
      List<WorkflowInfo> _list = [];
      await Project.apiClient.getMyPendingLoanRequests().then((onValue) {
        _list = onValue;
      }).catchError((onError) {
        error = onError;
      });
      if (error == null) {
        emit(GetMyPendingRequestsSuccessfully(_list));
      } else {
        emit(LoanError(error??""));
      }
    });

    on<GetLoanEmps>((event, emit) async {
      String? error;
      List<ListItem> items = [];
      await Project.apiClient.getLoanEmps().then((onValue) {
        items = onValue;
      }).catchError((onError) {
        error = onError;
      });
      if (error == null) {
        emit(GetLoanEmpsSuccessfully(items));
      } else {
        emit(LoanError(error??""));
      }
    });
  }
}
