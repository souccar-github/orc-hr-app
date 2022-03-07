import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:orc_hr/Localization/Localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Screens/General/SplashScreen.dart';
import 'SharedPref/SharedPref.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  static void setLocale(BuildContext context, Locale locale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    Future.delayed(Duration(milliseconds: 0), () async {
      state.setLocale(locale);  
    });
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale;
  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  MaterialColor generateMaterialColor(Color color) {
    return MaterialColor(color.value, {
      50: tintColor(color, 0.9),
      100: tintColor(color, 0.8),
      200: tintColor(color, 0.6),
      300: tintColor(color, 0.4),
      400: tintColor(color, 0.2),
      500: color,
      600: shadeColor(color, 0.1),
      700: shadeColor(color, 0.2),
      800: shadeColor(color, 0.3),
      900: shadeColor(color, 0.4),
    });
  }

  Color tintColor(Color color, double factor) => Color.fromRGBO(
      tintValue(color.red, factor),
      tintValue(color.green, factor),
      tintValue(color.blue, factor),
      1);
  int tintValue(int value, double factor) =>
      max(0, min((value + ((255 - value) * factor)).round(), 255));
  int shadeValue(int value, double factor) =>
      max(0, min(value - (value * factor).round(), 255));

  Color shadeColor(Color color, double factor) => Color.fromRGBO(
      shadeValue(color.red, factor),
      shadeValue(color.green, factor),
      shadeValue(color.blue, factor),
      1);
  String lo;
  @override
  Widget build(BuildContext context) {
      return MaterialApp(
        initialRoute: "/",
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          Localization.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        localeResolutionCallback: (deviceLocale, supportedLoacales) {
          for (var locale in supportedLoacales) {
            if (locale.languageCode == deviceLocale.languageCode)
              return deviceLocale;
          }
          return supportedLoacales.first;
        },
        locale: _locale,
        supportedLocales: [
          const Locale('en'),
          const Locale('ar'),
        ],
        theme: ThemeData(
          iconTheme: IconThemeData(color: Colors.white, size: 25),
          textTheme: TextTheme(headline6: TextStyle(color: Colors.white)),
          primarySwatch: generateMaterialColor(Color.fromRGBO(243, 119, 55, 1)),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: SplashScreen(),
      );
    }
  
}
