import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:orc_hr/API/Statics.dart';
import 'package:orc_hr/Bloc/Project/bloc/advance_bloc.dart';
import 'package:orc_hr/Models/Project/AdvanceRequest.dart';
import 'package:orc_hr/Models/Project/LeaveSetting.dart';
import 'package:orc_hr/Models/Project/LeaveReason.dart';
import 'package:orc_hr/Models/Project/ListItem.dart';
import 'package:orc_hr/Models/Project/LoanRequest.dart';
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
          .get(Uri.parse(Statics.BaseUrl + "/api/leave/getInit?loc=${await SharedPref.pref.getLocale() == "en" ? "49" : "14"}"),headers: {
        HttpHeaders.authorizationHeader: '$username:$password',
      });
      if (response.statusCode == 200) {
        List<LeaveInfoModel> items = [];
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
        return Future.error(error );
      }
    } on SocketException {
      return Future.error("check your internet connection");
    } on ClientException {
      return Future.error("check your internet connection");
    } catch (e) {
      return Future.error(e.toString());
    }
return [];
    return [];
  }

  Future<List<LeaveSetting>> getLeaveSettings() async {
    String error;
    try {
      var username = await SharedPref.pref.getUserName();
      var password = await SharedPref.pref.getPassword();
      final response = await Statics.httpClient
          .get(Uri.parse(Statics.BaseUrl + "/api/leave/getLeaveSettings?loc=${await SharedPref.pref.getLocale() == "en" ? "49" : "14"}"), headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: '$username:$password',
        
      });
      if (response.statusCode == 200) {
        List<LeaveSetting> items = [];
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
        return Future.error(error );
      }
    } on SocketException {
      return Future.error("check your internet connection");
    } on ClientException {
      return Future.error("check your internet connection");
    } catch (e) {
      return Future.error(e.toString());
    }
return [];
  }

  Future<List<LeaveRequest>> getPendingLeaveRequests() async {
    String error;
    try {
      var username = await SharedPref.pref.getUserName();
      var password = await SharedPref.pref.getPassword();
      final response = await Statics.httpClient.get(
          Uri.parse(Statics.BaseUrl + "/api/leave/getPendingLeaveRequests?loc=${await SharedPref.pref.getLocale() == "en" ? "49" : "14"}"),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader: '$username:$password',
            
          });
      if (response.statusCode == 200) {
        List<LeaveRequest> items = [];
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
        return Future.error(error );
      }
    } on SocketException {
      return Future.error("check your internet connection");
    } on ClientException {
      return Future.error("check your internet connection");
    } catch (e) {
      return Future.error(e.toString());
    }
return [];
  }

  Future<List<MissionRequest>> getPendingMissionRequests() async {
    String error;
    try {
      var username = await SharedPref.pref.getUserName();
      var password = await SharedPref.pref.getPassword();
      final response = await Statics.httpClient.get(
          Uri.parse(Statics.BaseUrl + "/api/mission/getPendingMissionRequests?loc=${await SharedPref.pref.getLocale() == "en" ? "49" : "14"}"),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader: '$username:$password',
            
          });
      if (response.statusCode == 200) {
        List<MissionRequest> items = [];
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
        return Future.error(error );
      }
    } on SocketException {
      return Future.error("check your internet connection");
    } on ClientException {
      return Future.error("check your internet connection");
    } catch (e) {
      return Future.error(e.toString());
    }
return [];
  }

  Future<List<AdvanceRequest>> getPendingAdvanceRequests() async {
    String error;
    try {
      var username = await SharedPref.pref.getUserName();
      var password = await SharedPref.pref.getPassword();
      final response = await Statics.httpClient.get(
          Uri.parse(Statics.BaseUrl + "/api/advance/getPendingAdvanceRequests?loc=${await SharedPref.pref.getLocale() == "en" ? "49" : "14"}"),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader: '$username:$password',
            
          });
      if (response.statusCode == 200) {
        List<AdvanceRequest> items = [];
        List itemListModel = json.decode(response.body);
        for (var i = 0; i < itemListModel.length; i++) {
          AdvanceRequest h = AdvanceRequest.fromJson(itemListModel[i]);
          items.add(h);
        }
        if (items != null) {
          return items;
        }
      } else if (response.statusCode == 401) {
        return Future.error("You are unauthorized !");
      } else {
        error = (jsonDecode(response.body))["Message"] as String;
        return Future.error(error );
      }
    } on SocketException {
      return Future.error("check your internet connection");
    } on ClientException {
      return Future.error("check your internet connection");
    } catch (e) {
      return Future.error(e.toString());
    }
return [];
  }

  Future<List<LoanRequest>> getPendingLoanRequests() async {
    String error;
    try {
      var username = await SharedPref.pref.getUserName();
      var password = await SharedPref.pref.getPassword();
      final response = await Statics.httpClient.get(
          Uri.parse(Statics.BaseUrl + "/api/loan/getPendingLoanRequests?loc=${await SharedPref.pref.getLocale() == "en" ? "49" : "14"}"),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader: '$username:$password',
            
          });
      if (response.statusCode == 200) {
        List<LoanRequest> items = [];
        List itemListModel = json.decode(response.body);
        for (var i = 0; i < itemListModel.length; i++) {
          LoanRequest h = LoanRequest.fromJson(itemListModel[i]);
          items.add(h);
        }
        if (items != null) {
          return items;
        }
      } else if (response.statusCode == 401) {
        return Future.error("You are unauthorized !");
      } else {
        error = (jsonDecode(response.body))["Message"] as String;
        return Future.error(error );
      }
    } on SocketException {
      return Future.error("check your internet connection");
    } on ClientException {
      return Future.error("check your internet connection");
    } catch (e) {
      return Future.error(e.toString());
    }
return [];
  }

  Future<List<EntranceExitRequest>> getPendingEntranceExitRequests() async {
    String error;
    try {
      var username = await SharedPref.pref.getUserName();
      var password = await SharedPref.pref.getPassword();
      final response = await Statics.httpClient.get(
          Uri.parse(Statics.BaseUrl + "/api/entranceExit/getPendingEntranceExitRequests?loc=${await SharedPref.pref.getLocale() == "en" ? "49" : "14"}"),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader: '$username:$password',
            
          });
      if (response.statusCode == 200) {
        List<EntranceExitRequest> items = [];
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
        return Future.error(error );
      }
    } on SocketException {
      return Future.error("check your internet connection");
    } on ClientException {
      return Future.error("check your internet connection");
    } catch (e) {
      return Future.error(e.toString());
    }
return [];
  }

  Future<List<EntranceExitRequest>> getEntranceExitReport(DateTime from, DateTime to) async {
    String error;
    try {
      var username = await SharedPref.pref.getUserName();
      var password = await SharedPref.pref.getPassword();
      final response = await Statics.httpClient.get(
          Uri.parse(Statics.BaseUrl + "/api/entranceExit/getEntranceExitReport?fromDate=${from.toIso8601String()}&toDate=${to.toIso8601String()}&loc=${await SharedPref.pref.getLocale() == "en" ? "49" : "14"}"),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader: '$username:$password',
            
          });
      if (response.statusCode == 200) {
        List<EntranceExitRequest> items = [];
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
        return Future.error(error );
      }
    } on SocketException {
      return Future.error("check your internet connection");
    } on ClientException {
      return Future.error("check your internet connection");
    } catch (e) {
      return Future.error(e.toString());
    }
return [];
  }

  Future<LeaveRequest?> getLeaveByWorkflow(int id) async {
    String error;
    try {
      var username = await SharedPref.pref.getUserName();
      var password = await SharedPref.pref.getPassword();
      final response = await Statics.httpClient
          .get(Uri.parse(Statics.BaseUrl + "/api/leave/getLeaveByWorkflow/$id?loc=${await SharedPref.pref.getLocale() == "en" ? "49" : "14"}"), headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: '$username:$password',
        
      });
      if (response.statusCode == 200) {
        LeaveRequest item = LeaveRequest.fromJson(json.decode(response.body));
        if (item != null) {
          return item;
        }
      } else if (response.statusCode == 400) {
        return Future.error("400");
      } else if (response.statusCode == 401) {
        return Future.error("You are unauthorized !");
      } else {
        error = (jsonDecode(response.body))["Message"] as String;
        return Future.error(error );
      }
    } on SocketException {
      return Future.error("check your internet connection");
    } on ClientException {
      return Future.error("check your internet connection");
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<MissionRequest?> getTravelMissionByWorkflow(int id) async {
    String error;
    try {
      var username = await SharedPref.pref.getUserName();
      var password = await SharedPref.pref.getPassword();
      final response = await Statics.httpClient
          .get(Uri.parse(Statics.BaseUrl + "/api/mission/getTravelMissionByWorkflow/$id?loc=${await SharedPref.pref.getLocale() == "en" ? "49" : "14"}"), headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: '$username:$password',
        
      });
      if (response.statusCode == 200) {
        MissionRequest item = MissionRequest.fromJson(json.decode(response.body));
        if (item != null) {
          return item;
        }
      } else if (response.statusCode == 400) {
        return Future.error("400");
      } else if (response.statusCode == 401) {
        return Future.error("You are unauthorized !");
      } else {
        error = (jsonDecode(response.body))["Message"] as String;
        return Future.error(error );
      }
    } on SocketException {
      return Future.error("check your internet connection");
    } on ClientException {
      return Future.error("check your internet connection");
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<MissionRequest?> getHourlyMissionByWorkflow(int id) async {
    String error;
    try {
      var username = await SharedPref.pref.getUserName();
      var password = await SharedPref.pref.getPassword();
      final response = await Statics.httpClient
          .get(Uri.parse(Statics.BaseUrl + "/api/mission/getHourlyMissionByWorkflow/$id?loc=${await SharedPref.pref.getLocale() == "en" ? "49" : "14"}"), headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: '$username:$password',
        
      });
      if (response.statusCode == 200) {
        MissionRequest item = MissionRequest.fromJson(json.decode(response.body));
        if (item != null) {
          return item;
        }
      } else if (response.statusCode == 400) {
        return Future.error("400");
      } else if (response.statusCode == 401) {
        return Future.error("You are unauthorized !");
      } else {
        error = (jsonDecode(response.body))["Message"] as String;
        return Future.error(error );
      }
    } on SocketException {
      return Future.error("check your internet connection");
    } on ClientException {
      return Future.error("check your internet connection");
    } catch (e) {
      return Future.error(e.toString());
    }
  }

    Future<EntranceExitRequest?> getEntranceExitRecordByWorkflow(int id) async {
    String error;
    try {
      var username = await SharedPref.pref.getUserName();
      var password = await SharedPref.pref.getPassword();
      final response = await Statics.httpClient.get(
          Uri.parse(Statics.BaseUrl +
              "/api/entranceExit/getEntranceExitRecordByWorkflow/$id?loc=${await SharedPref.pref.getLocale() == "en" ? "49" : "14"}"),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader: '$username:$password',
            
          });
      if (response.statusCode == 200) {
        EntranceExitRequest item =
            EntranceExitRequest.fromJson(json.decode(response.body));
        if (item != null) {
          return item;
        }
      } else if (response.statusCode == 400) {
        return Future.error("400");
      } else if (response.statusCode == 401) {
        return Future.error("You are unauthorized !");
      } else {
        error = (jsonDecode(response.body))["Message"] as String;
        return Future.error(error );
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
          .get(Uri.parse(Statics.BaseUrl + "/api/notify/checkUnRead?loc=${await SharedPref.pref.getLocale() == "en" ? "49" : "14"}"), headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: '$username:$password',
        
      });
      if (response.statusCode == 200) {
        List<Notify> items = [];
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
        return Future.error(error );
      }
    } on SocketException {
      return Future.error("check your internet connection");
    } on ClientException {
      return Future.error("check your internet connection");
    } catch (e) {
      return Future.error(e.toString());
    }
return [];
  }

  Future<List<LeaveReason>> getLeaveReasons() async {
    String error;
    try {
      var username = await SharedPref.pref.getUserName();
      var password = await SharedPref.pref.getPassword();
      final response = await Statics.httpClient
          .get(Uri.parse(Statics.BaseUrl + "/api/leave/getLeaveReasons?loc=${await SharedPref.pref.getLocale() == "en" ? "49" : "14"}"), headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: '$username:$password',
        
      });
      if (response.statusCode == 200) {
        List<LeaveReason> items = [];
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
        return Future.error(error );
      }
    } on SocketException {
      return Future.error("check your internet connection");
    } on ClientException {
      return Future.error("check your internet connection");
    } catch (e) {
      return Future.error(e.toString());
    }
return [];
  }

  Future<List<ListItem>> getLoanEmps() async {
    String error;
    try {
      var username = await SharedPref.pref.getUserName();
      var password = await SharedPref.pref.getPassword();
      final response = await Statics.httpClient
          .get(Uri.parse(Statics.BaseUrl + "/api/loan/getLoanEmps?loc=${await SharedPref.pref.getLocale() == "en" ? "49" : "14"}"), headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: '$username:$password',
        
      });
      if (response.statusCode == 200) {
        List<ListItem> items = [];
        List itemListModel = json.decode(response.body);
        for (var i = 0; i < itemListModel.length; i++) {
          ListItem h = ListItem.fromJson(itemListModel[i]);
          items.add(h);
        }
        if (items != null) {
          return items;
        }
      } else if (response.statusCode == 401) {
        return Future.error("You are unauthorized !");
      } else {
        error = (jsonDecode(response.body))["Message"] as String;
        return Future.error(error );
      }
    } on SocketException {
      return Future.error("check your internet connection");
    } on ClientException {
      return Future.error("check your internet connection");
    } catch (e) {
      return Future.error(e.toString());
    }
return [];
  }

  Future<List<WorkflowInfo>> getMyPendingLeaveRequests() async {
    String error;
    try {
      var username = await SharedPref.pref.getUserName();
      var password = await SharedPref.pref.getPassword();
      final response = await Statics.httpClient
          .get(Uri.parse(Statics.BaseUrl + "/api/leave/getMyPending/${await SharedPref.pref.getLocale() == "en" ? "49" : "14"}"), headers: {
        HttpHeaders.authorizationHeader: '$username:$password',
        
      });
      if (response.statusCode == 200) {
        List<WorkflowInfo> items = [];
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
        return Future.error(error );
      }
    } on SocketException {
      return Future.error("check your internet connection");
    } on ClientException {
      return Future.error("check your internet connection");
    } catch (e) {
      return Future.error(e.toString());
    }
return [];
    return [];
  }

  Future<List<WorkflowInfo>> getMyPendingMissionRequests() async {
    String error;
    try {
      var username = await SharedPref.pref.getUserName();
      var password = await SharedPref.pref.getPassword();
      final response = await Statics.httpClient
          .get(Uri.parse(Statics.BaseUrl + "/api/mission/getMyPending?loc=${await SharedPref.pref.getLocale() == "en" ? "49" : "14"}"), headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: '$username:$password',
        
      });
      if (response.statusCode == 200) {
        List<WorkflowInfo> items = [];
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
        return Future.error(error );
      }
    } on SocketException {
      return Future.error("check your internet connection");
    } on ClientException {
      return Future.error("check your internet connection");
    } catch (e) {
      return Future.error(e.toString());
    }
return [];
  }

  Future<List<WorkflowInfo>> getMyPendingAdvanceRequests() async {
    String error;
    try {
      var username = await SharedPref.pref.getUserName();
      var password = await SharedPref.pref.getPassword();
      final response = await Statics.httpClient
          .get(Uri.parse(Statics.BaseUrl + "/api/advance/getMyPending?loc=${await SharedPref.pref.getLocale() == "en" ? "49" : "14"}"), headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: '$username:$password',
        
      });
      if (response.statusCode == 200) {
        List<WorkflowInfo> items = [];
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
        return Future.error(error );
      }
    } on SocketException {
      return Future.error("check your internet connection");
    } on ClientException {
      return Future.error("check your internet connection");
    } catch (e) {
      return Future.error(e.toString());
    }
return [];
    return [];
  }

  Future<List<WorkflowInfo>> getMyPendingLoanRequests() async {
    String error;
    try {
      var username = await SharedPref.pref.getUserName();
      var password = await SharedPref.pref.getPassword();
      final response = await Statics.httpClient
          .get(Uri.parse(Statics.BaseUrl + "/api/loan/getMyPending?loc=${await SharedPref.pref.getLocale() == "en" ? "49" : "14"}"), headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: '$username:$password',
        
      });
      if (response.statusCode == 200) {
        List<WorkflowInfo> items = [];
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
        return Future.error(error );
      }
    } on SocketException {
      return Future.error("check your internet connection");
    } on ClientException {
      return Future.error("check your internet connection");
    } catch (e) {
      return Future.error(e.toString());
    }
return [];
  }

  Future<List<WorkflowInfo>> getMyPendingEntranceExitRequests() async {
    String error;
    try {
      var username = await SharedPref.pref.getUserName();
      var password = await SharedPref.pref.getPassword();
      final response = await Statics.httpClient
          .get(Uri.parse(Statics.BaseUrl + "/api/entranceExit/getMyPending?loc=${await SharedPref.pref.getLocale() == "en" ? "49" : "14"}"), headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: '$username:$password',
        
      });
      if (response.statusCode == 200) {
        List<WorkflowInfo> items = [];
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
        return Future.error(error );
      }
    } on SocketException {
      return Future.error("check your internet connection");
    } on ClientException {
      return Future.error("check your internet connection");
    } catch (e) {
      return Future.error(e.toString());
    }
return [];
  }

  Future<LeaveInfoModel> getLeaveSettingInfo(int id, DateTime startDate) async {
    String error;
    try {
      var username = await SharedPref.pref.getUserName();
      var password = await SharedPref.pref.getPassword();
      final response = await Statics.httpClient.get(
          Uri.parse(Statics.BaseUrl +
              "/api/leave/getLeaveSettingInfo/${id.toString()}/${startDate.day.toString()}/${startDate.month.toString()}/${startDate.year.toString()}?loc=${await SharedPref.pref.getLocale() == "en" ? "49" : "14"}"),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader: '$username:$password',
            
          });
      if (response.statusCode == 200) {
        LeaveInfoModel item =
            LeaveInfoModel.fromJson(json.decode(response.body));
        return item;
      } else if (response.statusCode == 401) {
        return Future.error("You are unauthorized !");
      } else {
        error = (jsonDecode(response.body))["Message"] as String;
        return Future.error(error );
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
          Uri.parse(Statics.BaseUrl +
              "/api/leave/accept/${wfId.toString()}/${leaveId.toString()}/${note == "" ? "null" :note.toString()}?loc=${await SharedPref.pref.getLocale() == "en" ? "49" : "14"}"),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader: '$username:$password',
            
          });
      if (response.statusCode == 200) {
        return "successfully";
      } else if (response.statusCode == 401) {
        return Future.error("You are unauthorized !");
      } else {
        error = (jsonDecode(response.body))["Message"] as String;
        return Future.error(error );
      }
    } on SocketException {
      return Future.error("check your internet connection");
    } on ClientException {
      return Future.error("check your internet connection");
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  

  Future<double> getDesAmount() async {
    String error;
    try {
      var username = await SharedPref.pref.getUserName();
      var password = await SharedPref.pref.getPassword();
      final response = await Statics.httpClient.get(
          Uri.parse(Statics.BaseUrl +
              "/api/advance/getDesAmount?loc=${await SharedPref.pref.getLocale() == "en" ? "49" : "14"}"),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader: '$username:$password',
            
          });
      if (response.statusCode == 200) {
        return double.parse(response.body);
      } else if (response.statusCode == 401) {
        return Future.error("You are unauthorized !");
      } else {
        error = (jsonDecode(response.body))["Message"] as String;
        return Future.error(error );
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
          Uri.parse(Statics.BaseUrl +
              "/api/leave/reject/${wfId.toString()}/${leaveId.toString()}/${note == "" ? "null" :note.toString()}?loc=${await SharedPref.pref.getLocale() == "en" ? "49" : "14"}"),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader: '$username:$password',
            
          });
      if (response.statusCode == 200) {
        return "successfully";
      } else if (response.statusCode == 401) {
        return Future.error("You are unauthorized !");
      } else {
        error = (jsonDecode(response.body))["Message"] as String;
        return Future.error(error );
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
          Uri.parse(Statics.BaseUrl +
              "/api/leave/pending/${wfId.toString()}/${leaveId.toString()}/${note == "" ? "null" :note.toString()}?loc=${await SharedPref.pref.getLocale() == "en" ? "49" : "14"}"),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader: '$username:$password',
            
          });
      if (response.statusCode == 200) {
        return "successfully";
      } else if (response.statusCode == 401) {
        return Future.error("You are unauthorized !");
      } else {
        error = (jsonDecode(response.body))["Message"] as String;
        return Future.error(error );
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
          Uri.parse(Statics.BaseUrl +
              "/api/mission/accept/${wfId.toString()}/${missionId.toString()}/${note == "" ? "null" :note}/${hourly.toString()}?loc=${await SharedPref.pref.getLocale() == "en" ? "49" : "14"}"),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader: '$username:$password',
            
          });
      if (response.statusCode == 200) {
        return "successfully";
      } else if (response.statusCode == 401) {
        return Future.error("You are unauthorized !");
      } else {
        error = (jsonDecode(response.body))["Message"] as String;
        return Future.error(error );
      }
    } on SocketException {
      return Future.error("check your internet connection");
    } on ClientException {
      return Future.error("check your internet connection");
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<String> acceptAdvanceRequest(
      int wfId, int advanceId, String note) async {
    String error;
    try {
      var username = await SharedPref.pref.getUserName();
      var password = await SharedPref.pref.getPassword();
      final response = await Statics.httpClient.post(
          Uri.parse(Statics.BaseUrl +
              "/api/advance/accept/${wfId.toString()}/${advanceId.toString()}/${note == "" ? "null" :note}?loc=${await SharedPref.pref.getLocale() == "en" ? "49" : "14"}"),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader: '$username:$password',
            
          });
      if (response.statusCode == 200) {
        return "successfully";
      } else if (response.statusCode == 401) {
        return Future.error("You are unauthorized !");
      } else {
        error = (jsonDecode(response.body))["Message"] as String;
        return Future.error(error );
      }
    } on SocketException {
      return Future.error("check your internet connection");
    } on ClientException {
      return Future.error("check your internet connection");
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<String> rejectAdvanceRequest(
      int wfId, int advanceId, String note) async {
    String error;
    try {
      var username = await SharedPref.pref.getUserName();
      var password = await SharedPref.pref.getPassword();
      final response = await Statics.httpClient.post(
          Uri.parse(Statics.BaseUrl +
              "/api/advance/reject/${wfId.toString()}/${advanceId.toString()}/${note == "" ? "null" :note}?loc=${await SharedPref.pref.getLocale() == "en" ? "49" : "14"}"),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader: '$username:$password',
            
          });
      if (response.statusCode == 200) {
        return "successfully";
      } else if (response.statusCode == 401) {
        return Future.error("You are unauthorized !");
      } else {
        error = (jsonDecode(response.body))["Message"] as String;
        return Future.error(error );
      }
    } on SocketException {
      return Future.error("check your internet connection");
    } on ClientException {
      return Future.error("check your internet connection");
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<String> pendingAdvanceRequest(
      int wfId, int advanceId, String note) async {
    String error;
    try {
      var username = await SharedPref.pref.getUserName();
      var password = await SharedPref.pref.getPassword();
      final response = await Statics.httpClient.post(
          Uri.parse(Statics.BaseUrl +
              "/api/advance/pending/${wfId.toString()}/${advanceId.toString()}/${note == "" ? "null" :note}?loc=${await SharedPref.pref.getLocale() == "en" ? "49" : "14"}"),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader: '$username:$password',
            
          });
      if (response.statusCode == 200) {
        return "successfully";
      } else if (response.statusCode == 401) {
        return Future.error("You are unauthorized !");
      } else {
        error = (jsonDecode(response.body))["Message"] as String;
        return Future.error(error );
      }
    } on SocketException {
      return Future.error("check your internet connection");
    } on ClientException {
      return Future.error("check your internet connection");
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<String> acceptLoanRequest(
      int wfId, int loanId, String note) async {
    String error;
    try {
      var username = await SharedPref.pref.getUserName();
      var password = await SharedPref.pref.getPassword();
      final response = await Statics.httpClient.post(
          Uri.parse(Statics.BaseUrl +
              "/api/loan/accept/${wfId.toString()}/${loanId.toString()}/${note == "" ? "null" :note}?loc=${await SharedPref.pref.getLocale() == "en" ? "49" : "14"}"),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader: '$username:$password',
            
          });
      if (response.statusCode == 200) {
        return "successfully";
      } else if (response.statusCode == 401) {
        return Future.error("You are unauthorized !");
      } else {
        error = (jsonDecode(response.body))["Message"] as String;
        return Future.error(error );
      }
    } on SocketException {
      return Future.error("check your internet connection");
    } on ClientException {
      return Future.error("check your internet connection");
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<String> rejectLoanRequest(
      int wfId, int loanId, String note) async {
    String error;
    try {
      var username = await SharedPref.pref.getUserName();
      var password = await SharedPref.pref.getPassword();
      final response = await Statics.httpClient.post(
          Uri.parse(Statics.BaseUrl +
              "/api/loan/reject/${wfId.toString()}/${loanId.toString()}/${note == "" ? "null" :note}?loc=${await SharedPref.pref.getLocale() == "en" ? "49" : "14"}"),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader: '$username:$password',
            
          });
      if (response.statusCode == 200) {
        return "successfully";
      } else if (response.statusCode == 401) {
        return Future.error("You are unauthorized !");
      } else {
        error = (jsonDecode(response.body))["Message"] as String;
        return Future.error(error );
      }
    } on SocketException {
      return Future.error("check your internet connection");
    } on ClientException {
      return Future.error("check your internet connection");
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<String> pendingLoanRequest(
      int wfId, int loanId, String note) async {
    String error;
    try {
      var username = await SharedPref.pref.getUserName();
      var password = await SharedPref.pref.getPassword();
      final response = await Statics.httpClient.post(
          Uri.parse(Statics.BaseUrl +
              "/api/loan/pending/${wfId.toString()}/${loanId.toString()}/${note == "" ? "null" :note}?loc=${await SharedPref.pref.getLocale() == "en" ? "49" : "14"}"),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader: '$username:$password',
            
          });
      if (response.statusCode == 200) {
        return "successfully";
      } else if (response.statusCode == 401) {
        return Future.error("You are unauthorized !");
      } else {
        error = (jsonDecode(response.body))["Message"] as String;
        return Future.error(error );
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
          Uri.parse(Statics.BaseUrl +
              "/api/mission/reject/${wfId.toString()}/${missionId.toString()}/${note == "" ? "null" :note}/${hourly.toString()}?loc=${await SharedPref.pref.getLocale() == "en" ? "49" : "14"}"),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader: '$username:$password',
            
          });
      if (response.statusCode == 200) {
        return "successfully";
      } else if (response.statusCode == 401) {
        return Future.error("You are unauthorized !");
      } else {
        error = (jsonDecode(response.body))["Message"] as String;
        return Future.error(error );
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
          Uri.parse(Statics.BaseUrl +
              "/api/mission/pending/${wfId.toString()}/${missionId.toString()}/${note == "" ? "null" :note}/${hourly.toString()}?loc=${await SharedPref.pref.getLocale() == "en" ? "49" : "14"}"),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader: '$username:$password',
            
          });
      if (response.statusCode == 200) {
        return "successfully";
      } else if (response.statusCode == 401) {
        return Future.error("You are unauthorized !");
      } else {
        error = (jsonDecode(response.body))["Message"] as String;
        return Future.error(error );
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
          Uri.parse(Statics.BaseUrl +
              "/api/entranceExit/accept/${wfId.toString()}/${recordId.toString()}/${note == "" ? "null" :note.toString()}?loc=${await SharedPref.pref.getLocale() == "en" ? "49" : "14"}"),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader: '$username:$password',
            
          });
      if (response.statusCode == 200) {
        return "successfully";
      } else if (response.statusCode == 401) {
        return Future.error("You are unauthorized !");
      } else {
        error = (jsonDecode(response.body))["Message"] as String;
        return Future.error(error );
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
          Uri.parse(Statics.BaseUrl +
              "/api/entranceExit/reject/${wfId.toString()}/${recordId.toString()}/${note == "" ? "null" :note.toString()}?loc=${await SharedPref.pref.getLocale() == "en" ? "49" : "14"}"),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader: '$username:$password',
            
          });
      if (response.statusCode == 200) {
        return "successfully";
      } else if (response.statusCode == 401) {
        return Future.error("You are unauthorized !");
      } else {
        error = (jsonDecode(response.body))["Message"] as String;
        return Future.error(error );
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
          Uri.parse(Statics.BaseUrl +
              "/api/entranceExit/pending/${wfId.toString()}/${recordId.toString()}/${note == "" ? "null" :note.toString()}?loc=${await SharedPref.pref.getLocale() == "en" ? "49" : "14"}"),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader: '$username:$password',
            
          });
      if (response.statusCode == 200) {
        return "successfully";
      } else if (response.statusCode == 401) {
        return Future.error("You are unauthorized !");
      } else {
        error = (jsonDecode(response.body))["Message"] as String;
        return Future.error(error );
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
          Uri.parse(Statics.BaseUrl + "/api/leave/getSpentDays?loc=${await SharedPref.pref.getLocale() == "en" ? "49" : "14"}"),
          body: jsonEncode(leave.toJson()),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader: '$username:$password',
            
          });
      if (response.statusCode == 200) {
        double item = (jsonDecode(response.body))["SpentDays"];
        return item.toString();
      } else if (response.statusCode == 401) {
        return Future.error("You are unauthorized !");
      } else {
        error = (jsonDecode(response.body))["Message"] as String;
        return Future.error(error );
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
         Uri.parse( Statics.BaseUrl + "/api/leave/postRequest?loc=${await SharedPref.pref.getLocale() == "en" ? "49" : "14"}"),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader: '$username:$password',
            
          },
          body: jsonEncode(item.toJson()));
      if (response.statusCode == 200) {
        return "success";
      } else if (response.statusCode == 401) {
        return Future.error("You are unauthorized !");
      } else {
        error = (jsonDecode(response.body))["Message"] as String;
        return Future.error(error );
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
          Uri.parse(Statics.BaseUrl + "/api/mission/postRequest?loc=${await SharedPref.pref.getLocale() == "en" ? "49" : "14"}"),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader: '$username:$password',
            
          },
          body: jsonEncode(item.toJson()));
      if (response.statusCode == 200) {
        return "success";
      } else if (response.statusCode == 401) {
        return Future.error("You are unauthorized !");
      } else {
        error = (jsonDecode(response.body))["Message"] as String;
        return Future.error(error );
      }
    } on SocketException {
      return Future.error("check your internet connection");
    } on ClientException {
      return Future.error("check your internet connection");
    } catch (e) {
      return Future.error(e.toString());
    }
return [];
  }

  Future addAdvanceRequest(AdvanceRequest item) async {
    String error;
    try {
      var username = await SharedPref.pref.getUserName();
      var password = await SharedPref.pref.getPassword();
      final response = await Statics.httpClient.post(
          Uri.parse(Statics.BaseUrl + "/api/advance/postRequest?loc=${await SharedPref.pref.getLocale() == "en" ? "49" : "14"}"),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader: '$username:$password',
            
          },
          body: jsonEncode(item.toJson()));
      if (response.statusCode == 200) {
        return "success";
      } else if (response.statusCode == 401) {
        return Future.error("You are unauthorized !");
      } else {
        error = (jsonDecode(response.body))["Message"] as String;
        return Future.error(error );
      }
    } on SocketException {
      return Future.error("check your internet connection");
    } on ClientException {
      return Future.error("check your internet connection");
    } catch (e) {
      return Future.error(e.toString());
    }
return [];
  }

  Future addLoanRequest(LoanRequest item) async {
    String error;
    try {
      var username = await SharedPref.pref.getUserName();
      var password = await SharedPref.pref.getPassword();
      final response = await Statics.httpClient.post(
          Uri.parse(Statics.BaseUrl + "/api/loan/postRequest?loc=${await SharedPref.pref.getLocale() == "en" ? "49" : "14"}"),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader: '$username:$password',
            
          },
          body: jsonEncode(item.toJson()));
      if (response.statusCode == 200) {
        return "success";
      } else if (response.statusCode == 401) {
        return Future.error("You are unauthorized !");
      } else {
        error = (jsonDecode(response.body))["Message"] as String;
        return Future.error(error );
      }
    } on SocketException {
      return Future.error("check your internet connection");
    } on ClientException {
      return Future.error("check your internet connection");
    } catch (e) {
      return Future.error(e.toString());
    }
return [];
  }

  Future addEntranceExitRequest(EntranceExitRequest item) async {
    String error;
    try {
      var username = await SharedPref.pref.getUserName();
      var password = await SharedPref.pref.getPassword();
      final response = await Statics.httpClient.post(
          Uri.parse(Statics.BaseUrl + "/api/entranceExit/postRequest?loc=${await SharedPref.pref.getLocale() == "en" ? "49" : "14"}"),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader: '$username:$password',
            
          },
          body: jsonEncode(item.toJson()));
      if (response.statusCode == 200) {
        return "success";
      } else if (response.statusCode == 401) {
        return Future.error("You are unauthorized !");
      } else {
        error = (jsonDecode(response.body))["Message"] as String;
        return Future.error(error );
      }
    } on SocketException {
      return Future.error("check your internet connection");
    } on ClientException {
      return Future.error("check your internet connection");
    } catch (e) {
      return Future.error(e.toString());
    }
return [];
  }
}
