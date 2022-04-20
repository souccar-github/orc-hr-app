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
  AuthBloc() : super(AuthInitial()){
    on<Login>((event, emit) async {
      emit(Loading());
      String? error, success;
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
        await SharedPref.pref.setEmployeeName(success??"");
        await SharedPref.pref.setPassword(event.password);
        FirebaseMessaging messaging = FirebaseMessaging.instance;

        NotificationSettings settings = await messaging.requestPermission(
          alert: true,
          badge: true,
          sound: true,
        );
        messaging.getToken().then((token) {
          General.apiClient.setToken(token??"").then((onValue) {
            SharedPref.pref.setFCMToken(token??"");
            success = onValue;
          }).catchError((onError) {
            error = onError;
          });
        });
        
        emit(LoginSuccessfully());
      } else {
        emit(LoginError(error??""));
      }
    });
  }
}
