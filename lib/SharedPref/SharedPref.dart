import 'dart:ffi';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  SharedPref._();
  SharedPreferences? _preferences;
  static final SharedPref pref = SharedPref._();

  Future<SharedPreferences> get _getSharedPref async {
    if (_preferences != null)
      return _preferences!;
    else {
      _preferences = await SharedPreferences.getInstance();
      return _preferences!;
    }
  }

  Future<void> setUserName(String ?userName) async {
    final SharedPreferences p = await _getSharedPref;
    p.setString("username", userName??"");
  }

  Future<void> setEmployeeName(String empName) async {
    final SharedPreferences p = await _getSharedPref;
    p.setString("empName", empName.substring(1,empName.length-1));
  }

  Future<void> setFCMToken(String token) async {
    final SharedPreferences p = await _getSharedPref;
    p.setString("token", token);
  }


  Future<String> getUserName() async {
    final SharedPreferences p = await _getSharedPref;
    String? username = p.getString("username");
    return username??"";
  }

  Future<String> getFCMToken() async {
    final SharedPreferences p = await _getSharedPref;
    String ?token = p.getString("token");
    return token??"";
  }

  Future<String> getEmployeeName() async {
    final SharedPreferences p = await _getSharedPref;
    String? empName = p.getString("empName");
    return empName??"";
  }

  Future<String> getLocale() async {
    final SharedPreferences p = await _getSharedPref;
    String? locale = p.getString("locale");
    return locale??"";
  }

  Future<void> setPassword(String password) async {
    final SharedPreferences p = await _getSharedPref;
    p.setString("password", password);
  }

  Future<void> setLocale(String locale) async {
    final SharedPreferences p = await _getSharedPref;
    p.setString("locale", locale);
  }

  Future<String> getPassword() async {
    final SharedPreferences p = await _getSharedPref;
    String ?password = p.getString("password");
    return password??"";
  }
}
