import 'dart:async';
import 'package:flutter/material.dart';
import 'package:orc_hr/Screens/General/Login.dart';
import 'package:orc_hr/Screens/Project/MainPage.dart';
import 'package:orc_hr/SharedPref/SharedPref.dart';

class SplashScreen extends StatefulWidget {

  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkUser(context);
  }

  @override
  Widget build(BuildContext context) {
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
              height: MediaQuery.of(context).size.height/4,
              width: MediaQuery.of(context).size.width/2,
            ),
            SizedBox(height: 40,),
            Center(
              child: CircularProgressIndicator(),
            ),
          ],
        ),
      ),
    );
  }

  checkUser(BuildContext context) async {
    final String user = await SharedPref.pref.getUserName();
    if (user != null) {
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
