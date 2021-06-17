import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:orc_hr/Bloc/Project/bloc/entranceexit_bloc.dart';
import 'package:orc_hr/Models/Project/LeaveRequest.dart';
import 'package:orc_hr/SharedPref/SharedPref.dart';
import 'package:orc_hr/Screens/Project/Services/Leave/LeavesBalance.dart';
import 'package:orc_hr/Screens/Project/Services/Leave/PendingLeaveRequests.dart';
import 'package:orc_hr/Screens/Project/Services/EntranceExit/PendingEntranceExitRequests.dart';
import 'package:orc_hr/Screens/Project/Services/Leave/LeaveRequest.dart';
import 'package:orc_hr/Screens/Project/Services/EntranceExit/EntranceExitRequest.dart';
import 'package:multilevel_drawer/multilevel_drawer.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  String username;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(microseconds: 0), () async {
      var _username = await SharedPref.pref.getEmployeeName();

      setState(() {
        username = _username;
      });
    });
    return MultiLevelDrawer(
      backgroundColor: Colors.white,
      rippleColor: Colors.white,
      subMenuBackgroundColor: Colors.grey.shade100,
      divisionColor: Color.fromRGBO(243, 119, 55, 1),
      header: Container(
        padding: EdgeInsets.only(top: 50),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib/assets/identety.png"),
            fit: BoxFit.fill,
          ),
        ),
        height: MediaQuery.of(context).size.height * 0.35,
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "lib/assets/logo.png",
              width: 100,
              height: 100,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "$username",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Divider(
              color: Color.fromRGBO(243, 119, 55, 1),
              thickness: 5,
            )
          ],
        )),
      ),
      children: [
        MLMenuItem(
            leading: Icon(
              Icons.time_to_leave,
              color: Color.fromRGBO(243, 119, 55, 1),
            ),
            trailing: Icon(
              Icons.arrow_right,
              color: Color.fromRGBO(243, 119, 55, 1),
            ),
            content: Text(
              "Leave Services",
            ),
            subMenuItems: [
              MLSubmenu(
                  onClick: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LeavesBalance()));
                  },
                  submenuContent: Text("Leave Balances")),
              MLSubmenu(
                  onClick: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => LeaveRequestPage(0)),
                    );
                  },
                  submenuContent: Text("Leave Request")),
              MLSubmenu(
                  onClick: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => PendingLeaves()),
                    );
                  },
                  submenuContent: Text("Pending Leave Requests")),
            ],
            onClick: () {}),
        MLMenuItem(
            leading: Icon(
              FontAwesomeIcons.exchangeAlt,
              color: Color.fromRGBO(243, 119, 55, 1),
            ),
            trailing: Icon(
              Icons.arrow_right,
              color: Color.fromRGBO(243, 119, 55, 1),
            ),
            content: Text(
              "Enterance Exit Services",
            ),
            subMenuItems: [
              MLSubmenu(
                  onClick: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => EntranceExitRequestPage()),
                    );
                  },
                  submenuContent: Text("Entrance Exit Request")),
                    MLSubmenu(
                  onClick: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => PendingEntranceExitRequests()),
                    );
                  },
                  submenuContent: Text("Pending Entrance Exit Requests")),
            ],
            onClick: () {}),
        MLMenuItem(
          leading: Icon(
            FontAwesomeIcons.signOutAlt,
            color: Color.fromRGBO(243, 119, 55, 1),
          ),
          content: Text("Sign Out"),
          onClick: () async {
            await SharedPref.pref.setUserName(null);
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/', ModalRoute.withName('/'));
          },
        )
      ],
    );
  }
}
