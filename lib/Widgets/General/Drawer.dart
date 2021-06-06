import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:orc_hr/Models/Project/LeaveRequest.dart';
import 'package:orc_hr/SharedPref/SharedPref.dart';
import 'package:orc_hr/Screens/Project/Services/LeavesBalance.dart';
import 'package:orc_hr/Screens/Project/Services/LeaveRequest.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _createHeader(),
          Divider(
            color: Color.fromRGBO(243, 119, 55, 1),
            thickness: 5,
          ),
          _createDrawerItem(
            icon: FontAwesomeIcons.chartPie,
            text: 'Leave Balances',
            onTap: () async {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => LeavesBalance()));
            },
          ),
          _createDrawerItem(
              icon: Icons.update,
              text: "Leave Request",
              onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => LeaveRequestPage(0)),
                  )),
          _createDrawerItem(
            icon: FontAwesomeIcons.signOutAlt,
            text: 'Sign out',
            onTap: () async {
              await SharedPref.pref.setUserName(null);
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/', ModalRoute.withName('/'));
            },
          ),
        ],
      ),
    );
  }

  Widget _createHeader() {
    return DrawerHeader(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage('lib/assets/identety.png'),
        ),
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            bottom: 12.0,
            left: 16.0,
            child: Text(
              "Welcome",
              style: TextStyle(
                  color: Color.fromRGBO(243, 119, 55, 1),
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  Widget _createDrawerItem(
      {IconData icon, String text, GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(
            icon,
            color: Color.fromRGBO(243, 119, 55, 1),
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(text),
          )
        ],
      ),
      onTap: onTap,
    );
  }
}
