import 'dart:ffi';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  SharedPref._();
  SharedPreferences _preferences;
  static final SharedPref pref = SharedPref._();

  Future<SharedPreferences> get _getSharedPref async {
    if (_preferences != null)
      return _preferences;
    else {
      _preferences = await SharedPreferences.getInstance();
      return _preferences;
    }
  }

  Future<Void> setUserName(String userName) async {
    final SharedPreferences p = await _getSharedPref;
    p.setString("username", userName);
  }

  Future<Void> setEmployeeName(String empName) async {
    final SharedPreferences p = await _getSharedPref;
    p.setString("empName", empName.substring(1,empName.length-1));
  }


  Future<String> getUserName() async {
    final SharedPreferences p = await _getSharedPref;
    String username = p.getString("username");
    return username;
  }

  Future<String> getEmployeeName() async {
    final SharedPreferences p = await _getSharedPref;
    String empName = p.getString("empName");
    return empName;
  }

  Future<Void> setPassword(String password) async {
    final SharedPreferences p = await _getSharedPref;
    p.setString("password", password);
  }

  Future<String> getPassword() async {
    final SharedPreferences p = await _getSharedPref;
    String password = p.getString("password");
    return password;
  }
}
