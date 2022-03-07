import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orc_hr/Localization/Localization.dart';
import 'package:orc_hr/Screens/Project/Services/Leave/ApprovePage.dart';
import 'package:orc_hr/Screens/Project/Services/entranceExit/ApprovePage.dart'
    as record;
import 'package:orc_hr/Screens/Project/Services/Mission/ApprovePage.dart'
    as mission;
import 'package:orc_hr/Bloc/Project/bloc/notification_bloc.dart';
import 'package:orc_hr/Widgets/General/Animation/delayed_animation.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  NotificationBloc bloc;
  @override
  void initState() {
    super.initState();
    bloc = new NotificationBloc();
    bloc.add(GetUnreadNotifications());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          Localization.of(context).getTranslatedValue("Notifications"),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      backgroundColor: Colors.white,
      body: BlocListener<NotificationBloc, NotificationState>(
        cubit: bloc,
        listener: (context, state) {
          if (state is NotificationError) {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(
                state.error,
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.red,
            ));
          }
          if (state is GetLeaveByWorkflowIdSuccessfully) {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => ApprovePage(
                      bloc: null,
                      leave: state.item,
                    )));
          }
          if (state is GetEntranceExitRecordByWorkflowIdSuccessfully) {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => record.ApprovePage(
                      bloc: null,
                      record: state.item,
                    )));
          }

          if (state is GetHourlyMissionByWorkflowIdSuccessfully) {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => mission.ApprovePage(
                      bloc: null,
                      mission: state.item,
                    )));
          }

          if (state is GetTravelMissionByWorkflowIdSuccessfully) {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => mission.ApprovePage(
                      bloc: null,
                      mission: state.item,
                    )));
          }
        },
        child: BlocBuilder<NotificationBloc, NotificationState>(
          cubit: bloc,
          builder: (context, state) {
            if (state is NotificationLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is GetNotificationsSuccessfully) {
              if (state.items.length == 0){
                return Container(
                  child: Center(
                    child: Text(
                        Localization.of(context).getTranslatedValue("ThereAreNoNotificationsToShow")),
                  ),
                );
              }
              return Padding(
                padding: EdgeInsets.all(7),
                child: ListView.builder(
                  itemCount: state.items.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 5,
                      child: InkWell(
                        onTap: () {
                          switch (state.items[index].type) {
                            case "EntranceExitRecordRequest":
                              bloc.add(GetEntranceExitRecordByWorkflowId(
                                  state.items[index].workflowItemId));
                              break;
                            case "EmployeeLeaveRequest":
                              bloc.add(GetLeaveByWorkflowId(
                                  state.items[index].workflowItemId));
                              break;
                            case "TravelMission":
                              bloc.add(GetTravelMissionByWorkflowId(
                                  state.items[index].workflowItemId));
                              break;
                            case "HourlyMission":
                              bloc.add(GetHourlyMissionByWorkflowId(
                                  state.items[index].workflowItemId));
                              break;
                          }
                         
                        },
                        child: Padding(
                          padding: EdgeInsets.all(7),
                          child: Stack(children: <Widget>[
                            Align(
                              alignment: Alignment.topLeft,
                              child: Stack(
                                children: <Widget>[
                                  Positioned(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, top: 5),
                                      child: Text(
                                        state.items[index].body ?? "",
                                        style: TextStyle(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Stack(
                                children: <Widget>[
                                  Positioned(
                                    child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, top: 5),
                                        child: DelayedAnimation(
                                          child: Icon(
                                            Icons.notifications_active,
                                            color:
                                                Color.fromRGBO(243, 119, 55, 1),
                                          ),
                                          delay: 200,
                                        )),
                                  ),
                                ],
                              ),
                            )
                          ]),
                        ),
                      ),
                    );
                  },
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
