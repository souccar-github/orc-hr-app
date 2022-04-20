import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:orc_hr/API/Statics.dart';
import 'package:orc_hr/Models/General/AuthModel.dart';
import 'package:orc_hr/SharedPref/SharedPref.dart';

class General {
  
  General._();
  static final General apiClient = General._();
  Future<String> login(AuthModel authModel) async {
    String error;

    try {
      final response = await Statics.httpClient.post(Uri.parse(Statics.BaseUrl + "/api/auth/login"),
          body: jsonEncode(authModel.toJson()),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader: '${authModel.username}:${authModel.password}',
          });
      if (response.statusCode == 200) {
        return response.body ;
      }else if (response.statusCode == 401) {
        return Future.error("username or password is not correct");
      }  else {
        error = (jsonDecode(response.body))["Message"] as String;
        return Future.error(error ); 
      }
    } on SocketException  {
      return Future.error("check your internet connection");
    } on http.ClientException {
      return Future.error("check your internet connection");
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<String> logout() async {
    String error;
    try {
      var username = await SharedPref.pref.getUserName();
      var password = await SharedPref.pref.getPassword();
      final response = await Statics.httpClient.post(
          Uri.parse(Statics.BaseUrl +
              "/api/auth/logout"),
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
    } on http.ClientException {
      return Future.error("check your internet connection");
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<String> setToken(String token) async {
    String error;

    try {
      var username = await SharedPref.pref.getUserName();
      var password = await SharedPref.pref.getPassword();
      final response = await Statics.httpClient.post(Uri.parse(Statics.BaseUrl + "/api/auth/setToken?token=$token"),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader: '${username}:${password}',
          });
      if (response.statusCode == 200) {
        return "success" ;
      }else if (response.statusCode == 401) {
        return Future.error("username or password is not correct");
      }  else {
        error = (jsonDecode(response.body))["Message"] as String;
        return Future.error(error ); 
      }
    } on SocketException {
      return Future.error("check your internet connection");
    } on http.ClientException {
      return Future.error("check your internet connection");
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}