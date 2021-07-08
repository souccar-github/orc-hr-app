import 'package:flutter/cupertino.dart';
import 'package:orc_hr/Localization/Localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orc_hr/Bloc/General/bloc/auth_bloc.dart';

import 'Animation/delayed_animation.dart';

Widget loginUI(AuthBloc authBloc, BuildContext context) {
  final Size sizeAware = MediaQuery.of(context).size;
  String name, password;
  final int delayedAmount = 500;
  return Container(
    child: Container(
      height: sizeAware.height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("lib/assets/identety.png"),
          fit: BoxFit.fill,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              DelayedAnimation(
                  delay: delayedAmount + 200,
                  child: Image.asset(
                    'lib/assets/logo.png',
                    height: 400,
                    width: 200,
                  )),
              DelayedAnimation(
                child: TextFormField(
                  onChanged: (text) {
                    name = text;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: new InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: Localization.of(context).getTranslatedValue("Username"),
                    labelStyle:
                        TextStyle(color: Color.fromRGBO(243, 119, 55, 1)),
                    enabledBorder: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(20.0),
                      borderSide: new BorderSide(
                          style: BorderStyle.solid,
                          color: Color.fromRGBO(243, 119, 55, 0.5)),
                    ),
                    focusedBorder: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(20.0),
                      borderSide: new BorderSide(
                          style: BorderStyle.solid,
                          color: Color.fromRGBO(243, 119, 55, 0.5)),
                    ),
                    focusedErrorBorder: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(20.0),
                      borderSide: new BorderSide(
                          style: BorderStyle.solid, color: Colors.red[200]),
                    ),
                    errorBorder: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(20.0),
                      borderSide: new BorderSide(
                          style: BorderStyle.solid, color: Colors.red[200]),
                    ),
                    errorStyle: TextStyle(
                      color: Colors.red[200],
                    ),
                  ),
                ),
                delay: delayedAmount + 400,
              ),
              SizedBox(
                height: 50.0,
              ),
              DelayedAnimation(
                child: TextFormField(
                  onChanged: (text) {
                    password = text;
                  },
                  keyboardType: TextInputType.emailAddress,
                  obscureText: true,
                  decoration: new InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: Localization.of(context).getTranslatedValue("Password"),
                    labelStyle:
                        TextStyle(color: Color.fromRGBO(243, 119, 55, 1)),
                    enabledBorder: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(20.0),
                      borderSide: new BorderSide(
                          style: BorderStyle.solid,
                          color: Color.fromRGBO(243, 119, 55, 0.5)),
                    ),
                    focusedBorder: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(20.0),
                      borderSide: new BorderSide(
                          style: BorderStyle.solid,
                          color: Color.fromRGBO(243, 119, 55, 0.5)),
                    ),
                    focusedErrorBorder: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(20.0),
                      borderSide: new BorderSide(
                          style: BorderStyle.solid, color: Colors.red[200]),
                    ),
                    errorBorder: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(20.0),
                      borderSide: new BorderSide(
                          style: BorderStyle.solid, color: Colors.red[200]),
                    ),
                    errorStyle: TextStyle(
                      color: Colors.red[200],
                    ),
                  ),
                ),
                delay: delayedAmount + 600,
              ),
              SizedBox(
                height: 50.0,
              ),
              BlocBuilder<AuthBloc, AuthState>(
                  cubit: authBloc,
                  buildWhen: (prev, cur) => cur is Loading || cur is LoginError,
                  builder: (context, state) {
                    if (state is Loading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return DelayedAnimation(
                        child: ButtonTheme(
                            minWidth: 175.0,
                            height: 50.0,
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(15.0),
                                  side: BorderSide(color: Colors.white)),
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              color: Color.fromRGBO(243, 119, 55, 1),
                              child: Text(
                                Localization.of(context).getTranslatedValue("Login"),
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                              onPressed: () {
                                authBloc.add(Login(name, password));
                              },
                            )),
                        delay: delayedAmount + 800,
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
    ),
  );
}
