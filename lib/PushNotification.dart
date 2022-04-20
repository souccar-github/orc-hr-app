import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:orc_hr/NavigationService.dart';
import 'package:orc_hr/Screens/Project/Notifications.dart';
import 'package:orc_hr/locator.dart';

class PushNotification {
  final _navigation = locator<NavigationService>();
  Future init() async {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {});
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
        _navigate(message);
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _navigate(message);
    });
  }

  void _navigate(RemoteMessage msg) {
    print(msg);
    _navigation.navigateTo("Notifications");
  }

 
}
 Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
  }