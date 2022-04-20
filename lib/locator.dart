
import 'package:flutter/cupertino.dart';
import 'package:orc_hr/PushNotification.dart';
import 'package:get_it/get_it.dart';
import 'NavigationService.dart';

GetIt locator = GetIt.instance;
void setupLocator(){
  locator.registerLazySingleton(()=>PushNotification());
  locator.registerLazySingleton(() => NavigationService());

}