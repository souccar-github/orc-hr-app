import 'dart:core' as prefix1;
import 'dart:core';
import 'dart:io';

import 'package:http/http.dart' as http;

class Statics {
  static http.Client httpClient = http.Client();
  // static const BaseUrl = "http://app.souccar.com/orc";
  static const Host = "app.souccar.com:80";
  static const BaseUrl = "http://f95f3b8d484d.ngrok.io";
}
