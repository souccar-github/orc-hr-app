import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:orc_hr/Bloc/Project/bloc/entranceexit_bloc.dart';
import 'package:orc_hr/Localization/Localization.dart';
import 'package:orc_hr/Models/Project/LeaveRequest.dart';
import 'package:orc_hr/Screens/Project/Services/Advance/AdvanceRequest.dart';
import 'package:orc_hr/Screens/Project/Services/Advance/PendingAdvanceRequests.dart';
import 'package:orc_hr/Screens/Project/Services/EntranceExit/MyPendingRequests.dart';
import 'package:orc_hr/Screens/Project/Services/Leave/MyPendingRequests.dart'
    as leave;
import 'package:orc_hr/Screens/Project/Services/Mission/MyPendingRequests.dart'
    as mission;
import 'package:orc_hr/Screens/Project/Services/Advance/MyPendingRequests.dart'
    as advance;
import 'package:orc_hr/SharedPref/SharedPref.dart';
import 'package:orc_hr/Screens/Project/Services/Leave/LeavesBalance.dart';
import 'package:orc_hr/main.dart';
import 'package:orc_hr/Widgets/General/multiLevelDrawer.dart';
import 'package:orc_hr/Screens/Project/Services/Leave/PendingLeaveRequests.dart';
import 'package:orc_hr/Screens/Project/Services/Mission/PendingMissionRequests.dart';
import 'package:orc_hr/Screens/Project/Services/EntranceExit/PendingEntranceExitRequests.dart';
import 'package:orc_hr/Screens/Project/Services/Leave/LeaveRequest.dart';
import 'package:orc_hr/Screens/Project/Services/Mission/MissionRequest.dart';
import 'package:orc_hr/Screens/Project/Services/EntranceExit/EntranceExitRequest.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  var locale = null;
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
    setState(() {
      locale = Localizations.localeOf(context).languageCode;
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
              Localization.of(context).getTranslatedValue("LeaveServices"),
            ),
            subMenuItems: [
              MLSubmenu(
                  onClick: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LeavesBalance()));
                  },
                  submenuContent: Text(Localization.of(context)
                      .getTranslatedValue("LeaveBalances"))),
              MLSubmenu(
                  onClick: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => LeaveRequestPage(0, null)),
                    );
                  },
                  submenuContent: Text(Localization.of(context)
                      .getTranslatedValue("LeaveRequest"))),
              MLSubmenu(
                  onClick: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => PendingLeaves()),
                    );
                  },
                  submenuContent: Text(Localization.of(context)
                      .getTranslatedValue("PendingLeaveRequests"))),
              MLSubmenu(
                  onClick: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => leave.MyPendingRequests()),
                    );
                  },
                  submenuContent: Text(Localization.of(context)
                      .getTranslatedValue("MyPendingRequests"))),
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
              Localization.of(context)
                  .getTranslatedValue("EnteranceExitServices"),
            ),
            subMenuItems: [
              MLSubmenu(
                  onClick: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => EntranceExitRequestPage()),
                    );
                  },
                  submenuContent: Text(Localization.of(context)
                      .getTranslatedValue("EntranceExitRequest"))),
              MLSubmenu(
                  onClick: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => PendingEntranceExitRequests()),
                    );
                  },
                  submenuContent: Text(Localization.of(context)
                      .getTranslatedValue("PendingEntranceExitRequests"))),
              MLSubmenu(
                  onClick: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => MyPendingRequests()),
                    );
                  },
                  submenuContent: Text(Localization.of(context)
                      .getTranslatedValue("MyPendingRequests"))),
            ],
            onClick: () {}),
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
              Localization.of(context).getTranslatedValue("MissionServices"),
            ),
            subMenuItems: [
              MLSubmenu(
                  onClick: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => MissionRequestPage()),
                    );
                  },
                  submenuContent: Text(Localization.of(context)
                      .getTranslatedValue("MissionRequest"))),
              MLSubmenu(
                  onClick: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => PendingMissions()),
                    );
                  },
                  submenuContent: Text(Localization.of(context)
                      .getTranslatedValue("PendingMissionRequests"))),
              MLSubmenu(
                  onClick: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => mission.MyPendingRequests()),
                    );
                  },
                  submenuContent: Text(Localization.of(context)
                      .getTranslatedValue("MyPendingRequests"))),
            ],
            onClick: () {}),
        // MLMenuItem(
        //     leading: Icon(
        //       Icons.time_to_leave,
        //       color: Color.fromRGBO(243, 119, 55, 1),
        //     ),
        //     trailing: Icon(
        //       Icons.arrow_right,
        //       color: Color.fromRGBO(243, 119, 55, 1),
        //     ),
        //     content: Text(
        //       Localization.of(context).getTranslatedValue("AdvanceServices"),
        //     ),
        //     subMenuItems: [
        //       MLSubmenu(
        //           onClick: () {
        //             Navigator.of(context).push(
        //               MaterialPageRoute(
        //                   builder: (context) => AdvanceRequestPage()),
        //             );
        //           },
        //           submenuContent: Text(Localization.of(context)
        //               .getTranslatedValue("AdvanceRequest"))),
        //       MLSubmenu(
        //           onClick: () {
        //             Navigator.of(context).push(
        //               MaterialPageRoute(
        //                   builder: (context) => PendingAdvances()),
        //             );
        //           },
        //           submenuContent: Text(Localization.of(context)
        //               .getTranslatedValue("PendingAdvanceRequests"))),
        //       MLSubmenu(
        //           onClick: () {
        //             Navigator.of(context).push(
        //               MaterialPageRoute(
        //                   builder: (context) => advance.MyPendingRequests()),
        //             );
        //           },
        //           submenuContent: Text(Localization.of(context)
        //               .getTranslatedValue("MyPendingRequests"))),
        //     ],
        //     onClick: () {}),
        MLMenuItem(
          leading: Icon(
            Icons.settings,
            color: Color.fromRGBO(243, 119, 55, 1),
          ),
          trailing: Icon(
            Icons.arrow_right,
            color: Color.fromRGBO(243, 119, 55, 1),
          ),
          content: Text(Localization.of(context).getTranslatedValue("Setting")),
          subMenuItems: [
            MLSubmenu(
                onClick: () {
                  if (locale == 'en') {
                    MyApp.setLocale(
                        context, Locale.fromSubtags(languageCode: 'ar'));
                    SharedPref.pref.setLocale('ar');
                    Navigator.of(context).pop();
                  } else {
                    MyApp.setLocale(
                        context, Locale.fromSubtags(languageCode: 'en'));
                    SharedPref.pref.setLocale('en');
                    Navigator.of(context).pop();
                  }
                },
                submenuContent: Text(locale == 'en'
                    ? Localization.of(context)
                        .getTranslatedValue("ArabicLanguage")
                    : Localization.of(context)
                        .getTranslatedValue("EnglishLanguage"))),
          ],
          onClick: () async {
            await SharedPref.pref.setUserName(null);
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/', ModalRoute.withName('/'));
          },
        ),
        MLMenuItem(
          leading: Icon(
            FontAwesomeIcons.signOutAlt,
            color: Color.fromRGBO(243, 119, 55, 1),
          ),
          content: Text(Localization.of(context).getTranslatedValue("SignOut")),
          onClick: () async {
            await SharedPref.pref.setUserName(null);
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/', ModalRoute.withName('/'));
          },
        ),
      ],
    );
  }
}
