import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:orc_hr/API/Statics.dart';
import 'package:orc_hr/API/General/General.dart';
import 'package:orc_hr/Models/General/AuthModel.dart';
import 'package:orc_hr/SharedPref/SharedPref.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is Login) {
      yield Loading();
      String error, success;
      var loginModel = new AuthModel(event.username, event.password);
      await General.apiClient.login(loginModel).then((onValue) {
        success = onValue;
      }).catchError((onError) {
        error = onError;
      });
      await General.apiClient.login(loginModel).then((onValue) {
        success = onValue;
      }).catchError((onError) {
        error = onError;
      });
      if (error == null) {
        await SharedPref.pref.setUserName(event.username);
        await SharedPref.pref.setEmployeeName(success);
        await SharedPref.pref.setPassword(event.password);
        FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();
        if (Platform.isIOS) {
          _firebaseMessaging.requestNotificationPermissions(
              IosNotificationSettings(sound: true, badge: true, alert: true));
          _firebaseMessaging.onIosSettingsRegistered
              .listen((IosNotificationSettings settings) {
            print("Settings registered: $settings");
          });
        }

        _firebaseMessaging.getToken().then((token) {
          General.apiClient.setToken(token).then((onValue) {
            SharedPref.pref.setFCMToken(token);
            success = onValue;
          }).catchError((onError) {
            error = onError;
          });
        });

        _firebaseMessaging.configure(
          onMessage: (Map<String, dynamic> message) async {
            print('on message $message');
          },
          onResume: (Map<String, dynamic> message) async {
            print('on resume $message');
          },
          onLaunch: (Map<String, dynamic> message) async {
            print('on launch $message');
          },
        );
        yield LoginSuccessfully();
      } else {
        yield LoginError(error);
      }
    }
  }
}
