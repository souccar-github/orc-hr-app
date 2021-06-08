import 'dart:core' as prefix1;
import 'dart:core';

import 'package:http/http.dart' as http;

class Statics {
  static final http.Client httpClient = http.Client();
  static const BaseUrl = "http://app.souccar.com/orc";
}
