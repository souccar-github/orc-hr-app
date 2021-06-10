import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orc_hr/Screens/Project/Services/ApprovePage.dart';
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
          'Notifications',
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
              return Padding(
                padding: EdgeInsets.all(7),
                child: ListView.builder(
                  itemCount: state.items.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 5,
                      child: InkWell(
                        onTap: () {
                          bloc.add(GetLeaveByWorkflowId(
                              state.items[index].workflowItemId));
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
