import 'dart:async';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:orc_hr/Localization/Localization.dart';
import 'package:orc_hr/PushNotification.dart';
import 'package:orc_hr/Screens/General/Login.dart';
import 'package:orc_hr/Screens/Project/MainPage.dart';
import 'package:orc_hr/SharedPref/SharedPref.dart';
import 'package:orc_hr/firebase_options.dart';
import 'package:orc_hr/locator.dart';
import 'package:orc_hr/main.dart';

class SplashScreen extends StatefulWidget {
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    

    if (DateTime.now().isBefore(DateTime(2022, 12, 31))) {
      checkUser(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (DateTime.now().isAfter(DateTime(2022,12, 31))) {
      Future.delayed(Duration.zero, () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                Localization.of(context).getTranslatedValue('YourTrialExpired'),
                style: TextStyle(color: Colors.black),
              ),
              actions: <Widget>[
                ButtonTheme(
                  minWidth: 100.0,
                  height: 50.0,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(15.0),
                        side: BorderSide(color: Colors.white)),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    color: Color.fromRGBO(243, 119, 55, 1),
                    child: Text(
                      Localization.of(context).getTranslatedValue("Ok"),
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    onPressed: () {
                      exit(0);
                    },
                  ),
                ),
              ],
            );
          },
        );
      });
      // exit(0);
    } else {
      return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("lib/assets/identety.png"),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'lib/assets/logo.png',
                height: MediaQuery.of(context).size.height / 4,
                width: MediaQuery.of(context).size.width / 2,
              ),
              SizedBox(
                height: 40,
              ),
              Center(
                child: CircularProgressIndicator(),
              ),
            ],
          ),
        ),
      );
    }
    return Container();
  }

  checkUser(BuildContext context) async {
    final String user = await SharedPref.pref.getUserName();
    var locale = await SharedPref.pref.getLocale();
    if (locale == 'en') {
      MyApp.setLocale(context, Locale.fromSubtags(languageCode: 'en'));
    }
    if (locale == 'ar') {
      MyApp.setLocale(context, Locale.fromSubtags(languageCode: 'ar'));
    }
    if (user != "") {
      Timer(Duration(seconds: 1), () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MainPage()));
      });
    } else {
      Timer(Duration(seconds: 1), () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Login()));
      });
    }
  }
}
