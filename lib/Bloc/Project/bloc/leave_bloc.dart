import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:orc_hr/API/Project/Project.dart';
import 'package:orc_hr/Models/Project/LeaveInfoModel.dart';
import 'package:orc_hr/Models/Project/LeaveRequest.dart';
import 'package:orc_hr/Models/Project/LeaveSetting.dart';
import 'package:orc_hr/Models/Project/LeaveReason.dart';
import 'package:orc_hr/Models/Project/WorkflowInfo.dart';
part 'leave_event.dart';
part 'leave_state.dart';

class LeaveBloc extends Bloc<LeaveEvent, LeaveState> {
  LeaveBloc() : super(LeaveInitial()) {
    on<InitMainLeavesBalancePage>((event, emit) async {
      emit(LeaveLoading());
      String? error;
      List<LeaveInfoModel> _list = [];
      await Project.apiClient.initLeaveBalance().then((onValue) {
        _list = onValue;
      }).catchError((onError) {
        error = onError;
      });
      if (error == null) {
        emit(MainLeavesBalanceInitSuccessfully(_list));
      } else {
        emit(LeaveError(error ?? ""));
      }
    });
    on<GetLeaveSettings>((event, emit) async {
      emit(LeaveLoading());
      String? error;
      List<LeaveSetting> _list = [];
      await Project.apiClient.getLeaveSettings().then((onValue) {
        _list = onValue;
      }).catchError((onError) {
        error = onError;
      });
      if (error == null) {
        emit(GetLeaveSettingsSuccessfully(_list));
      } else {
        emit(LeaveError(error ?? ""));
      }
    });

    on<GetLeaveSettingInfo>((event, emit) async {
      emit(LeaveLoading());
      String? error;
      var info;
      await Project.apiClient
          .getLeaveSettingInfo(event.id, event.startDate)
          .then((onValue) {
        info = onValue;
      }).catchError((onError) {
        error = onError;
      });
      if (error == null) {
        emit(GetLeaveSettingInfoSuccessfully(info));
      } else {
        emit(LeaveError(error ?? ""));
      }
    });

    on<GetSpentDays>((event, emit) async {
      emit(DaysLoading());
      String? error;
      var info;
      await Project.apiClient.getSpentDays(event.leave).then((onValue) {
        info = onValue;
      }).catchError((onError) {
        error = onError;
      });
      if (error == null) {
        emit(GetSpentDaysSuccessfully(info));
      } else {
        emit(LeaveError(error ?? ""));
      }
    });
    on<GetLeaveReasons>((event, emit) async {
      emit(LeaveLoading());
      String? error;
      List<LeaveReason> _list = [];
      await Project.apiClient.getLeaveReasons().then((onValue) {
        _list = onValue;
      }).catchError((onError) {
        error = onError;
      });
      if (error == null) {
        emit(GetLeaveReasonsSuccessfully(_list));
      } else {
        emit(LeaveError(error ?? ""));
      }
    });

    on<PostLeaveRequest>((event, emit) async {
      emit(LeaveLoading());
      String? error;
      var info;
      if (event.leave.leaveSettingId == 0 || event.leave.leaveReasonId == 0) {
        error = "Required Message";
        emit(LeaveError(error));
      } else {
        if (event.info.isIndivisible) {
          var end = new DateTime(event.leave.startDate.year);
          end =
              event.leave.startDate.add(Duration(days: event.duration.round()));
          event.leave.endDate = end;
          event.leave.toDateTime = end;
        }
        await Project.apiClient.addLeaveRequest(event.leave,event.files).then((onValue) {
          info = onValue;
        }).catchError((onError) {
          error = onError;
        });
      }
      if (error == null) {
        emit(PostLeaveRequestSuccessfully());
      } else {
        emit(LeaveError(error ?? ""));
      }
    });

    on<AcceptLeaveRequest>((event, emit) async {
      emit(LeaveLoading());
      String? error;
      var info;
      await Project.apiClient
          .acceptLeaveRequest(event.workflowId, event.leaveId, event.note)
          .then((onValue) {
        info = onValue;
      }).catchError((onError) {
        error = onError;
      });
      if (error == null) {
        emit(AcceptLeaveRequestSuccessfully());
      } else {
        emit(LeaveError(error ?? ""));
      }
    });

    on<RejectLeaveRequest>((event, emit) async {
      emit(LeaveLoading());
      String? error;
      var info;
      await Project.apiClient
          .rejectLeaveRequest(event.workflowId, event.leaveId, event.note)
          .then((onValue) {
        info = onValue;
      }).catchError((onError) {
        error = onError;
      });
      if (error == null) {
        emit(RejectLeaveRequestSuccessfully());
      } else {
        emit(LeaveError(error ?? ""));
      }
    });
    on<PendingLeaveRequest>((event, emit) async {
      emit(LeaveLoading());
      String? error;
      var info;
      await Project.apiClient
          .pendingLeaveRequest(event.workflowId, event.leaveId, event.note)
          .then((onValue) {
        info = onValue;
      }).catchError((onError) {
        error = onError;
      });
      if (error == null) {
        emit(PendingLeaveRequestSuccessfully());
      } else {
        emit(LeaveError(error ?? ""));
      }
    });

    on<GetPendingLeaveRequests>((event, emit) async {
      emit(LeaveLoading());
      String? error;
      List<LeaveRequest> _list = [];
      await Project.apiClient.getPendingLeaveRequests().then((onValue) {
        _list = onValue;
      }).catchError((onError) {
        error = onError;
      });
      if (error == null) {
        emit(GetPendingLeaveRequestsSuccessfully(_list));
      } else {
        emit(LeaveError(error ?? ""));
      }
    });

    on<GetMyPendingRequests>((event, emit) async {
      emit(LeaveLoading());
      String? error;
      List<WorkflowInfo> _list = [];
      await Project.apiClient.getMyPendingLeaveRequests().then((onValue) {
        _list = onValue;
      }).catchError((onError) {
        error = onError;
      });
      if (error == null) {
        emit(GetMyPendingRequestsSuccessfully(_list));
      } else {
        emit(LeaveError(error ?? ""));
      }
    });
  }
}
