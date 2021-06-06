import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:orc_hr/API/Statics.dart';
import 'package:orc_hr/Models/Project/LeaveSetting.dart';
import 'package:orc_hr/Models/Project/LeaveReason.dart';
import 'package:orc_hr/SharedPref/SharedPref.dart';
import 'package:orc_hr/Models/Project/LeaveInfoModel.dart';
import 'package:orc_hr/Models/Project/LeaveRequest.dart';

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
          });
      if (response.statusCode == 200) {
        LeaveInfoModel item =
            LeaveInfoModel.fromJson(json.decode(response.body));
        return item;
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
          });
      if (response.statusCode == 200) {
        double item =(jsonDecode(response.body))["SpentDays"];
        return item.toString();
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
      final response = await Statics.httpClient
          .post(Statics.BaseUrl + "/api/leave/postRequest",
              headers: {
                HttpHeaders.contentTypeHeader: 'application/json',
                'Authorization': '$username:$password',
              },
              body: jsonEncode(item.toJson()));
      if (response.statusCode == 200) {
        return "success";
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
