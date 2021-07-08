import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orc_hr/Widgets/General/Drawer.dart';
import 'package:orc_hr/Localization/Localization.dart';
import 'package:orc_hr/Screens/Project/Notifications.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
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
