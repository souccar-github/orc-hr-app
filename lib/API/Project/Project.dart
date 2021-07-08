import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:orc_hr/API/Statics.dart';
import 'package:orc_hr/Models/Project/LeaveSetting.dart';
import 'package:orc_hr/Models/Project/LeaveReason.dart';
import 'package:orc_hr/Models/Project/MissionRequest.dart';
import 'package:orc_hr/Models/Project/WorkflowInfo.dart';
import 'package:orc_hr/SharedPref/SharedPref.dart';
import 'package:orc_hr/Models/Project/LeaveInfoModel.dart';
import 'package:orc_hr/Models/Project/Notify.dart';
import 'package:orc_hr/Models/Project/LeaveRequest.dart';
import 'package:orc_hr/Models/Project/EntranceExitRequest.dart';

class Project {
  Project._();
  static final Project apiClient = Project._();

  Future<List<LeaveInfoModel>> initLeaveBalance() async {
    String error;
    try {
      var username = await SharedPref.pref.getUserName();
      var password = await SharedPref.pref.getPassword();
      final response = await Statics.httpClient
          .get(Statics.BaseUrl + "/api/leave/getInit", headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        'Authorization': '$username:$password',
        'locale': await SharedPref.pref.getLocale() == "en" ? "49" : "14"
      });
      if (response.statusCode == 200) {
        List<LeaveInfoModel> items = new List<LeaveInfoModel>();
        List itemListModel = json.decode(response.body);
        for (var i = 0; i < itemListModel.length; i++) {
          LeaveInfoModel h = LeaveInfoModel.fromJson(itemListModel[i]);
          items.add(h);
        }
        if (items != null) {
          return items;
        }
      } else if (response.statusCode == 401) {
        return Future.error("You are unauthorized !");
      } else {
        error = (jsonDecode(response.body))["Message"] as String;
        return Future.error(error ?? "Unknown Error");
      }
    } on SocketException {
      return Future.error("check your internet connection");
    } on ClientException {
      return Future.error("check your internet connection");
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<List<LeaveSetting>> getLeaveSettings() async {
    String error;
    try {
      var username = await SharedPref.pref.getUserName();
      var password = await SharedPref.pref.getPassword();
      final response = await Statics.httpClient
          .get(Statics.BaseUrl + "/api/leave/getLeaveSettings", headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        'Authorization': '$username:$password',
        'locale': await SharedPref.pref.getLocale() == "en" ? "49" : "14"
      });
      if (response.statusCode == 200) {
        List<LeaveSetting> items = new List<LeaveSetting>();
        List itemListModel = json.decode(response.body);
        for (var i = 0; i < itemListModel.length; i++) {
          LeaveSetting h = LeaveSetting.fromJson(itemListModel[i]);
          items.add(h);
        }
        if (items != null) {
          return items;
        }
      } else if (response.statusCode == 401) {
        return Future.error("You are unauthorized !");
      } else {
        error = (jsonDecode(response.body))["Message"] as String;
        return Future.error(error ?? "Unknown Error");
      }
    } on SocketException {
      return Future.error("check your internet connection");
    } on ClientException {
      return Future.error("check your internet connection");
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<List<LeaveRequest>> getPendingLeaveRequests() async {
    String error;
    try {
      var username = await SharedPref.pref.getUserName();
      var password = await SharedPref.pref.getPassword();
      final response = await Statics.httpClient.get(
          Statics.BaseUrl + "/api/leave/getPendingLeaveRequests",
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            'Authorization': '$username:$password',
            'locale': await SharedPref.pref.getLocale() == "en" ? "49" : "14"
          });
      if (response.statusCode == 200) {
        List<LeaveRequest> items = new List<LeaveRequest>();
        List itemListModel = json.decode(response.body);
        for (var i = 0; i < itemListModel.length; i++) {
          LeaveRequest h = LeaveRequest.fromJson(itemListModel[i]);
          items.add(h);
        }
        if (items != null) {
          return items;
        }
      } else if (response.statusCode == 401) {
        return Future.error("You are unauthorized !");
      } else {
        error = (jsonDecode(response.body))["Message"] as String;
        return Future.error(error ?? "Unknown Error");
      }
    } on SocketException {
      return Future.error("check your internet connection");
    } on ClientException {
      return Future.error("check your internet connection");
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<List<MissionRequest>> getPendingMissionRequests() async {
    String error;
    try {
      var username = await SharedPref.pref.getUserName();
      var password = await SharedPref.pref.getPassword();
      final response = await Statics.httpClient.get(
          Statics.BaseUrl + "/api/mission/getPendingMissionRequests",
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            'Authorization': '$username:$password',
            'locale': await SharedPref.pref.getLocale() == "en" ? "49" : "14"
          });
      if (response.statusCode == 200) {
        List<MissionRequest> items = new List<MissionRequest>();
        List itemListModel = json.decode(response.body);
        for (var i = 0; i < itemListModel.length; i++) {
          MissionRequest h = MissionRequest.fromJson(itemListModel[i]);
          items.add(h);
        }
        if (items != null) {
          return items;
        }
      } else if (response.statusCode == 401) {
        return Future.error("You are unauthorized !");
      } else {
        error = (jsonDecode(response.body))["Message"] as String;
        return Future.error(error ?? "Unknown Error");
      }
    } on SocketException {
      return Future.error("check your internet connection");
    } on ClientException {
      return Future.error("check your internet connection");
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<List<EntranceExitRequest>> getPendingEntranceExitRequests() async {
    String error;
    try {
      var username = await SharedPref.pref.getUserName();
      var password = await SharedPref.pref.getPassword();
      final response = await Statics.httpClient.get(
          Statics.BaseUrl + "/api/entranceExit/getPendingEntranceExitRequests",
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            'Authorization': '$username:$password',
            'locale': await SharedPref.pref.getLocale() == "en" ? "49" : "14"
          });
      if (response.statusCode == 200) {
        List<EntranceExitRequest> items = new List<EntranceExitRequest>();
        List itemListModel = json.decode(response.body);
        for (var i = 0; i < itemListModel.length; i++) {
          EntranceExitRequest h =
              EntranceExitRequest.fromJson(itemListModel[i]);
          items.add(h);
        }
        if (items != null) {
          return items;
        }
      } else if (response.statusCode == 401) {
        return Future.error("You are unauthorized !");
      } else {
        error = (jsonDecode(response.body))["Message"] as String;
        return Future.error(error ?? "Unknown Error");
      }
    } on SocketException {
      return Future.error("check your internet connection");
    } on ClientException {
      return Future.error("check your internet connection");
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<LeaveRequest> getLeaveByWorkflow(int id) async {
    String error;
    try {
      var username = await SharedPref.pref.getUserName();
      var password = await SharedPref.pref.getPassword();
      final response = await Statics.httpClient
          .get(Statics.BaseUrl + "/api/leave/getLeaveByWorkflow/$id", headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        'Authorization': '$username:$password',
        'locale': await SharedPref.pref.getLocale() == "en" ? "49" : "14"
      });
      if (response.statusCode == 200) {
        LeaveRequest item = LeaveRequest.fromJson(json.decode(response.body));
        if (item != null) {
          return item;
        }
      } else if (response.statusCode == 401) {
        return Future.error("You are unauthorized !");
      } else {
        error = (jsonDecode(response.body))["Message"] as String;
        return Future.error(error ?? "Unknown Error");
      }
    } on SocketException {
      return Future.error("check your internet connection");
    } on ClientException {
      return Future.error("check your internet connection");
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<EntranceExitRequest> getEntranceExitRecordByWorkflow(int id) async {
    String error;
    try {
      var username = await SharedPref.pref.getUserName();
      var password = await SharedPref.pref.getPassword();
      final response = await Statics.httpClient.get(
          Statics.BaseUrl +
              "/api/entranceExit/getEntranceExitRecordByWorkflow/$id",
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            'Authorization': '$username:$password',
            'locale': await SharedPref.pref.getLocale() == "en" ? "49" : "14"
          });
      if (response.statusCode == 200) {
        EntranceExitRequest item =
            EntranceExitRequest.fromJson(json.decode(response.body));
        if (item != null) {
          return item;
        }
      } else if (response.statusCode == 401) {
        return Future.error("You are unauthorized !");
      } else {
        error = (jsonDecode(response.body))["Message"] as String;
        return Future.error(error ?? "Unknown Error");
      }
    } on SocketException {
      return Future.error("check your internet connection");
    } on ClientException {
      return Future.error("check your internet connection");
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<List<Notify>> getUnreadNotification() async {
    String error;
    try {
      var username = await SharedPref.pref.getUserName();
      var password = await SharedPref.pref.getPassword();
      final response = await Statics.httpClient
          .get(Statics.BaseUrl + "/api/notify/checkUnRead", headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        'Authorization': '$username:$password',
        'locale': await SharedPref.pref.getLocale() == "en" ? "49" : "14"
      });
      if (response.statusCode == 200) {
        List<Notify> items = new List<Notify>();
        List itemListModel = json.decode(response.body);
        for (var i = 0; i < itemListModel.length; i++) {
          Notify h = Notify.fromJson(itemListModel[i]);
          items.add(h);
        }
        if (items != null) {
          return items;
        }
      } else if (response.statusCode == 401) {
        return Future.error("You are unauthorized !");
      } else {
        error = (jsonDecode(response.body))["Message"] as String;
        return Future.error(error ?? "Unknown Error");
      }
    } on SocketException {
      return Future.error("check your internet connection");
    } on ClientException {
      return Future.error("check your internet connection");
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<List<LeaveReason>> getLeaveReasons() async {
    String error;
    try {
      var username = await SharedPref.pref.getUserName();
      var password = await SharedPref.pref.getPassword();
      final response = await Statics.httpClient
          .get(Statics.BaseUrl + "/api/leave/getLeaveReasons", headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        'Authorization': '$username:$password',
        'locale': await SharedPref.pref.getLocale() == "en" ? "49" : "14"
      });
      if (response.statusCode == 200) {
        List<LeaveReason> items = new List<LeaveReason>();
        List itemListModel = json.decode(response.body);
        for (var i = 0; i < itemListModel.length; i++) {
          LeaveReason h = LeaveReason.fromJson(itemListModel[i]);
          items.add(h);
        }
        if (items != null) {
          return items;
        }
      } else if (response.statusCode == 401) {
        return Future.error("You are unauthorized !");
      } else {
        error = (jsonDecode(response.body))["Message"] as String;
        return Future.error(error ?? "Unknown Error");
      }
    } on SocketException {
      return Future.error("check your internet connection");
    } on ClientException {
      return Future.error("check your internet connection");
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<List<WorkflowInfo>> getMyPendingLeaveRequests() async {
    String error;
    try {
      var username = await SharedPref.pref.getUserName();
      var password = await SharedPref.pref.getPassword();
      final response = await Statics.httpClient
          .get(Statics.BaseUrl + "/api/leave/getMyPending", headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        'Authorization': '$username:$password',
        'locale': await SharedPref.pref.getLocale() == "en" ? "49" : "14"
      });
      if (response.statusCode == 200) {
        List<WorkflowInfo> items = new List<WorkflowInfo>();
        List itemListModel = json.decode(response.body);
        for (var i = 0; i < itemListModel.length; i++) {
          WorkflowInfo h = WorkflowInfo.fromJson(itemListModel[i]);
          items.add(h);
        }
        if (items != null) {
          return items;
        }
      } else if (response.statusCode == 401) {
        return Future.error("You are unauthorized !");
      } else {
        error = (jsonDecode(response.body))["Message"] as String;
        return Future.error(error ?? "Unknown Error");
      }
    } on SocketException {
      return Future.error("check your internet connection");
    } on ClientException {
      return Future.error("check your internet connection");
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<List<WorkflowInfo>> getMyPendingMissionRequests() async {
    String error;
    try {
      var username = await SharedPref.pref.getUserName();
      var password = await SharedPref.pref.getPassword();
      final response = await Statics.httpClient
          .get(Statics.BaseUrl + "/api/mission/getMyPending", headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        'Authorization': '$username:$password',
        'locale': await SharedPref.pref.getLocale() == "en" ? "49" : "14"
      });
      if (response.statusCode == 200) {
        List<WorkflowInfo> items = new List<WorkflowInfo>();
        List itemListModel = json.decode(response.body);
        for (var i = 0; i < itemListModel.length; i++) {
          WorkflowInfo h = WorkflowInfo.fromJson(itemListModel[i]);
          items.add(h);
        }
        if (items != null) {
          return items;
        }
      } else if (response.statusCode == 401) {
        return Future.error("You are unauthorized !");
      } else {
        error = (jsonDecode(response.body))["Message"] as String;
        return Future.error(error ?? "Unknown Error");
      }
    } on SocketException {
      return Future.error("check your internet connection");
    } on ClientException {
      return Future.error("check your internet connection");
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<List<WorkflowInfo>> getMyPendingEntranceExitRequests() async {
    String error;
    try {
      var username = await SharedPref.pref.getUserName();
      var password = await SharedPref.pref.getPassword();
      final response = await Statics.httpClient
          .get(Statics.BaseUrl + "/api/entranceExit/getMyPending", headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        'Authorization': '$username:$password',
        'locale': await SharedPref.pref.getLocale() == "en" ? "49" : "14"
      });
      if (response.statusCode == 200) {
        List<WorkflowInfo> items = new List<WorkflowInfo>();
        List itemListModel = json.decode(response.body);
        for (var i = 0; i < itemListModel.length; i++) {
          WorkflowInfo h = WorkflowInfo.fromJson(itemListModel[i]);
          items.add(h);
        }
        if (items != null) {
          return items;
        }
      } else if (response.statusCode == 401) {
        return Future.error("You are unauthorized !");
      } else {
        error = (jsonDecode(response.body))["Message"] as String;
        return Future.error(error ?? "Unknown Error");
      }
    } on SocketException {
      return Future.error("check your internet connection");
    } on ClientException {
      return Future.error("check your internet connection");
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<LeaveInfoModel> getLeaveSettingInfo(int id, DateTime startDate) async {
    String error;
    try {
      var username = await SharedPref.pref.getUserName();
      var password = await SharedPref.pref.getPassword();
      final response = await Statics.httpClient.get(
          Statics.BaseUrl +
              "/api/leave/getLeaveSettingInfo/${id.toString()}/${startDate.day.toString()}/${startDate.month.toString()}/${startDate.year.toString()}",
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            'Authorization': '$username:$password',
            'locale': await SharedPref.pref.getLocale() == "en" ? "49" : "14"
          });
      if (response.statusCode == 200) {
        LeaveInfoModel item =
            LeaveInfoModel.fromJson(json.decode(response.body));
        return item;
      } else if (response.statusCode == 401) {
        return Future.error("You are unauthorized !");
      } else {
        error = (jsonDecode(response.body))["Message"] as String;
        return Future.error(error ?? "Unknown Error");
      }
    } on SocketException {
      return Future.error("check your internet connection");
    } on ClientException {
      return Future.error("check your internet connection");
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<String> acceptLeaveRequest(int wfId, int leaveId, String note) async {
    String error;
    try {
      var username = await SharedPref.pref.getUserName();
      var password = await SharedPref.pref.getPassword();
      final response = await Statics.httpClient.post(
          Statics.BaseUrl +
              "/api/leave/accept/${wfId.toString()}/${leaveId.toString()}/${note.toString()}",
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            'Authorization': '$username:$password',
            'locale': await SharedPref.pref.getLocale() == "en" ? "49" : "14"
          });
      if (response.statusCode == 200) {
        return "successfully";
      } else if (response.statusCode == 401) {
        return Future.error("You are unauthorized !");
      } else {
        error = (jsonDecode(response.body))["Message"] as String;
        return Future.error(error ?? "Unknown Error");
      }
    } on SocketException {
      return Future.error("check your internet connection");
    } on ClientException {
      return Future.error("check your internet connection");
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<String> rejectLeaveRequest(int wfId, int leaveId, String note) async {
    String error;
    try {
      var username = await SharedPref.pref.getUserName();
      var password = await SharedPref.pref.getPassword();
      final response = await Statics.httpClient.post(
          Statics.BaseUrl +
              "/api/leave/reject/${wfId.toString()}/${leaveId.toString()}/${note.toString()}",
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            'Authorization': '$username:$password',
            'locale': await SharedPref.pref.getLocale() == "en" ? "49" : "14"
          });
      if (response.statusCode == 200) {
        return "successfully";
      } else if (response.statusCode == 401) {
        return Future.error("You are unauthorized !");
      } else {
        error = (jsonDecode(response.body))["Message"] as String;
        return Future.error(error ?? "Unknown Error");
      }
    } on SocketException {
      return Future.error("check your internet connection");
    } on ClientException {
      return Future.error("check your internet connection");
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<String> pendingLeaveRequest(int wfId, int leaveId, String note) async {
    String error;
    try {
      var username = await SharedPref.pref.getUserName();
      var password = await SharedPref.pref.getPassword();
      final response = await Statics.httpClient.post(
          Statics.BaseUrl +
              "/api/leave/pending/${wfId.toString()}/${leaveId.toString()}/${note.toString()}",
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            'Authorization': '$username:$password',
            'locale': await SharedPref.pref.getLocale() == "en" ? "49" : "14"
          });
      if (response.statusCode == 200) {
        return "successfully";
      } else if (response.statusCode == 401) {
        return Future.error("You are unauthorized !");
      } else {
        error = (jsonDecode(response.body))["Message"] as String;
        return Future.error(error ?? "Unknown Error");
      }
    } on SocketException {
      return Future.error("check your internet connection");
    } on ClientException {
      return Future.error("check your internet connection");
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<String> acceptMissionRequest(
      int wfId, int missionId, String note,bool hourly) async {
    String error;
    try {
      var username = await SharedPref.pref.getUserName();
      var password = await SharedPref.pref.getPassword();
      final response = await Statics.httpClient.post(
          Statics.BaseUrl +
              "/api/mission/accept/${wfId.toString()}/${missionId.toString()}/${note??"null"}/${hourly.toString()}",
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            'Authorization': '$username:$password',
            'locale': await SharedPref.pref.getLocale() == "en" ? "49" : "14"
          });
      if (response.statusCode == 200) {
        return "successfully";
      } else if (response.statusCode == 401) {
        return Future.error("You are unauthorized !");
      } else {
        error = (jsonDecode(response.body))["Message"] as String;
        return Future.error(error ?? "Unknown Error");
      }
    } on SocketException {
      return Future.error("check your internet connection");
    } on ClientException {
      return Future.error("check your internet connection");
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<String> rejectMissionRequest(
      int wfId, int missionId, String note,bool hourly) async {
    String error;
    try {
      var username = await SharedPref.pref.getUserName();
      var password = await SharedPref.pref.getPassword();
      final response = await Statics.httpClient.post(
          Statics.BaseUrl +
              "/api/mission/reject/${wfId.toString()}/${missionId.toString()}/${note??"null"}/${hourly.toString()}",
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            'Authorization': '$username:$password',
            'locale': await SharedPref.pref.getLocale() == "en" ? "49" : "14"
          });
      if (response.statusCode == 200) {
        return "successfully";
      } else if (response.statusCode == 401) {
        return Future.error("You are unauthorized !");
      } else {
        error = (jsonDecode(response.body))["Message"] as String;
        return Future.error(error ?? "Unknown Error");
      }
    } on SocketException {
      return Future.error("check your internet connection");
    } on ClientException {
      return Future.error("check your internet connection");
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<String> pendingMissionRequest(
      int wfId, int missionId, String note,bool hourly) async {
    String error;
    try {
      var username = await SharedPref.pref.getUserName();
      var password = await SharedPref.pref.getPassword();
      final response = await Statics.httpClient.post(
          Statics.BaseUrl +
              "/api/mission/pending/${wfId.toString()}/${missionId.toString()}/${note??"null"}/${hourly.toString()}",
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            'Authorization': '$username:$password',
            'locale': await SharedPref.pref.getLocale() == "en" ? "49" : "14"
          });
      if (response.statusCode == 200) {
        return "successfully";
      } else if (response.statusCode == 401) {
        return Future.error("You are unauthorized !");
      } else {
        error = (jsonDecode(response.body))["Message"] as String;
        return Future.error(error ?? "Unknown Error");
      }
    } on SocketException {
      return Future.error("check your internet connection");
    } on ClientException {
      return Future.error("check your internet connection");
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<String> acceptEntranceExitRequest(
      int wfId, int recordId, String note) async {
    String error;
    try {
      var username = await SharedPref.pref.getUserName();
      var password = await SharedPref.pref.getPassword();
      final response = await Statics.httpClient.post(
          Statics.BaseUrl +
              "/api/entranceExit/accept/${wfId.toString()}/${recordId.toString()}/${note.toString()}",
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            'Authorization': '$username:$password',
            'locale': await SharedPref.pref.getLocale() == "en" ? "49" : "14"
          });
      if (response.statusCode == 200) {
        return "successfully";
      } else if (response.statusCode == 401) {
        return Future.error("You are unauthorized !");
      } else {
        error = (jsonDecode(response.body))["Message"] as String;
        return Future.error(error ?? "Unknown Error");
      }
    } on SocketException {
      return Future.error("check your internet connection");
    } on ClientException {
      return Future.error("check your internet connection");
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<String> rejectEntranceExitRequest(
      int wfId, int recordId, String note) async {
    String error;
    try {
      var username = await SharedPref.pref.getUserName();
      var password = await SharedPref.pref.getPassword();
      final response = await Statics.httpClient.post(
          Statics.BaseUrl +
              "/api/entranceExit/reject/${wfId.toString()}/${recordId.toString()}/${note.toString()}",
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            'Authorization': '$username:$password',
            'locale': await SharedPref.pref.getLocale() == "en" ? "49" : "14"
          });
      if (response.statusCode == 200) {
        return "successfully";
      } else if (response.statusCode == 401) {
        return Future.error("You are unauthorized !");
      } else {
        error = (jsonDecode(response.body))["Message"] as String;
        return Future.error(error ?? "Unknown Error");
      }
    } on SocketException {
      return Future.error("check your internet connection");
    } on ClientException {
      return Future.error("check your internet connection");
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<String> pendingEntranceExitRequest(
      int wfId, int recordId, String note) async {
    String error;
    try {
      var username = await SharedPref.pref.getUserName();
      var password = await SharedPref.pref.getPassword();
      final response = await Statics.httpClient.post(
          Statics.BaseUrl +
              "/api/entranceExit/pending/${wfId.toString()}/${recordId.toString()}/${note.toString()}",
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            'Authorization': '$username:$password',
            'locale': await SharedPref.pref.getLocale() == "en" ? "49" : "14"
          });
      if (response.statusCode == 200) {
        return "successfully";
      } else if (response.statusCode == 401) {
        return Future.error("You are unauthorized !");
      } else {
        error = (jsonDecode(response.body))["Message"] as String;
        return Future.error(error ?? "Unknown Error");
      }
    } on SocketException {
      return Future.error("check your internet connection");
    } on ClientException {
      return Future.error("check your internet connection");
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<String> getSpentDays(LeaveRequest leave) async {
    String error;
    try {
      var username = await SharedPref.pref.getUserName();
      var password = await SharedPref.pref.getPassword();
      final response = await Statics.httpClient.post(
          Statics.BaseUrl + "/api/leave/getSpentDays",
          body: jsonEncode(leave.toJson()),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            'Authorization': '$username:$password',
            'locale': await SharedPref.pref.getLocale() == "en" ? "49" : "14"
          });
      if (response.statusCode == 200) {
        double item = (jsonDecode(response.body))["SpentDays"];
        return item.toString();
      } else if (response.statusCode == 401) {
        return Future.error("You are unauthorized !");
      } else {
        error = (jsonDecode(response.body))["Message"] as String;
        return Future.error(error ?? "Unknown Error");
      }
    } on SocketException {
      return Future.error("check your internet connection");
    } on ClientException {
      return Future.error("check your internet connection");
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future addLeaveRequest(LeaveRequest item) async {
    String error;
    try {
      var username = await SharedPref.pref.getUserName();
      var password = await SharedPref.pref.getPassword();
      final response = await Statics.httpClient.post(
          Statics.BaseUrl + "/api/leave/postRequest",
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            'Authorization': '$username:$password',
            'locale': await SharedPref.pref.getLocale() == "en" ? "49" : "14"
          },
          body: jsonEncode(item.toJson()));
      if (response.statusCode == 200) {
        return "success";
      } else if (response.statusCode == 401) {
        return Future.error("You are unauthorized !");
      } else {
        error = (jsonDecode(response.body))["Message"] as String;
        return Future.error(error ?? "Unknown Error");
      }
    } on SocketException {
      return Future.error("check your internet connection");
    } on ClientException {
      return Future.error("check your internet connection");
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future addMissionRequest(MissionRequest item) async {
    String error;
    try {
      var username = await SharedPref.pref.getUserName();
      var password = await SharedPref.pref.getPassword();
      final response = await Statics.httpClient.post(
          Statics.BaseUrl + "/api/mission/postRequest",
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            'Authorization': '$username:$password',
            'locale': await SharedPref.pref.getLocale() == "en" ? "49" : "14"
          },
          body: jsonEncode(item.toJson()));
      if (response.statusCode == 200) {
        return "success";
      } else if (response.statusCode == 401) {
        return Future.error("You are unauthorized !");
      } else {
        error = (jsonDecode(response.body))["Message"] as String;
        return Future.error(error ?? "Unknown Error");
      }
    } on SocketException {
      return Future.error("check your internet connection");
    } on ClientException {
      return Future.error("check your internet connection");
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future addEntranceExitRequest(EntranceExitRequest item) async {
    String error;
    try {
      var username = await SharedPref.pref.getUserName();
      var password = await SharedPref.pref.getPassword();
      final response = await Statics.httpClient.post(
          Statics.BaseUrl + "/api/entranceExit/postRequest",
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            'Authorization': '$username:$password',
            'locale': await SharedPref.pref.getLocale() == "en" ? "49" : "14"
          },
          body: jsonEncode(item.toJson()));
      if (response.statusCode == 200) {
        return "success";
      } else if (response.statusCode == 401) {
        return Future.error("You are unauthorized !");
      } else {
        error = (jsonDecode(response.body))["Message"] as String;
        return Future.error(error ?? "Unknown Error");
      }
    } on SocketException {
      return Future.error("check your internet connection");
    } on ClientException {
      return Future.error("check your internet connection");
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
