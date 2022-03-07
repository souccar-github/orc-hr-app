import 'dart:core' as prefix1;
import 'dart:core';
import 'dart:io';

import 'package:http/http.dart' as http;

class Statics {
  static http.Client httpClient = http.Client();
  // static const BaseUrl = "http://app.souccar.com/orc";
  // static const BaseUrl = "http://91.144.21.62/ORC-HR";
  static const BaseUrl = "https://5225-91-144-21-82.ngrok.io";
}
