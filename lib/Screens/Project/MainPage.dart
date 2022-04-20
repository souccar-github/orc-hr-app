import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orc_hr/PushNotification.dart';
import 'package:orc_hr/Widgets/General/Drawer.dart';
import 'package:orc_hr/Localization/Localization.dart';
import 'package:orc_hr/Screens/Project/Notifications.dart';
import 'package:orc_hr/firebase_options.dart';
import 'package:orc_hr/locator.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () async {
      
      PushNotification not = locator<PushNotification>();
      await not.init();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.notifications,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => NotificationPage()),
                );
              },
            )
          ],
          title: Text(
            Localization.of(context).getTranslatedValue("ORC-HR"),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        backgroundColor: Colors.white,
        drawer: AppDrawer(),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("lib/assets/identety.png"),
              fit: BoxFit.fill,
            ),
          ),
        ));
  }
}
