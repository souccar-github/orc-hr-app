import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:orc_hr/API/Project/Project.dart';
import 'package:orc_hr/Models/Project/LeaveInfoModel.dart';
import 'package:orc_hr/Models/Project/LeaveRequest.dart';
import 'package:orc_hr/Models/Project/LeaveSetting.dart';
import 'package:orc_hr/Models/Project/LeaveReason.dart';
part 'leave_event.dart';
part 'leave_state.dart';

class LeaveBloc extends Bloc<LeaveEvent, LeaveState> {
  LeaveBloc() : super(LeaveInitial());

  @override
  Stream<LeaveState> mapEventToState(
    LeaveEvent event,
  ) async* {
    if (event is InitMainLeavesBalancePage){
      yield LeaveLoading();
      String error = null;
      var _list = new List<LeaveInfoModel>();
      await Project.apiClient.initLeaveBalance().then((onValue) {
        _list = onValue;
      }).catchError((onError) {
        error = onError;
      });
      if (error == null) {
        yield MainLeavesBalanceInitSuccessfully(_list);
      } else {
        yield LeaveError(error);
      }
    
    }
    if (event is GetLeaveSettings){
      yield LeaveLoading();
      String error = null;
      var _list = new List<LeaveSetting>();
      await Project.apiClient.getLeaveSettings().then((onValue) {
        _list = onValue;
      }).catchError((onError) {
        error = onError;
      });
      if (error == null) {
        yield GetLeaveSettingsSuccessfully(_list);
      } else {
        yield LeaveError(error);
      }
    }

    if (event is GetLeaveSettingInfo){
      yield LeaveLoading();
      String error = null;
      var info;
      await Project.apiClient.getLeaveSettingInfo(event.id,event.startDate).then((onValue) {
        info = onValue;
      }).catchError((onError) {
        error = onError;
      });
      if (error == null) {
        yield GetLeaveSettingInfoSuccessfully(info);
      } else {
        yield LeaveError(error);
      }
    }

    if (event is GetSpentDays){
      yield DaysLoading();
      String error = null;
      var info;
      await Project.apiClient.getSpentDays(event.leave).then((onValue) {
        info = onValue;
      }).catchError((onError) {
        error = onError;
      });
      if (error == null) {
        yield GetSpentDaysSuccessfully(info);
      } else {
        yield LeaveError(error);
      }
    }

    if (event is GetLeaveReasons){
      yield LeaveLoading();
      String error = null;
      var _list = new List<LeaveReason>();
      await Project.apiClient.getLeaveReasons().then((onValue) {
        _list = onValue;
      }).catchError((onError) {
        error = onError;
      });
      if (error == null) {
        yield GetLeaveReasonsSuccessfully(_list);
      } else {
        yield LeaveError(error);
      }
    }

    if (event is PostLeaveRequest){
      yield LeaveLoading();
      String error = null;
      var info;
      await Project.apiClient.addLeaveRequest(event.leave).then((onValue) {
        info = onValue;
      }).catchError((onError) {
        error = onError;
      });
      if (error == null) {
        yield PostLeaveRequestSuccessfully();
      } else {
        yield LeaveError(error);
      }
    }
  }
}
