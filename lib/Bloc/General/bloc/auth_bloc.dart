import 'dart:async';

import 'package:bloc/bloc.dart';
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
      String error,success;
      var loginModel = new AuthModel(event.username, event.password);
      await General.apiClient.login(loginModel).then((onValue) {
        success = onValue;
      }).catchError((onError) {
        error = onError;
      });
      if (success == 'success') {
        await SharedPref.pref.setUserName(event.username);
        await SharedPref.pref.setPassword(event.password);
        yield LoginSuccessfully();
      } else {
        yield LoginError(error);
      }
    }
  }
}
