import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orc_hr/Bloc/Project/bloc/leave_bloc.dart';
import 'package:orc_hr/Screens/Project/Services/ApprovePage.dart';
import 'package:orc_hr/Widgets/General/Animation/delayed_animation.dart';

class PendingLeaves extends StatefulWidget {
  @override
  _PendingLeavesState createState() => _PendingLeavesState();
}

class _PendingLeavesState extends State<PendingLeaves> {
  LeaveBloc bloc;
  @override
  void initState() {
    super.initState();
    bloc = new LeaveBloc();
    bloc.add(GetPendingLeaveRequests());
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
          'Pending Leave Requests',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      backgroundColor: Colors.white,
      body: BlocListener<LeaveBloc, LeaveState>(
        cubit: bloc,
        listener: (context, state) {
          if (state is LeaveError) {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(
                state.error,
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.red,
            ));
          }
        },
        child: BlocBuilder<LeaveBloc, LeaveState>(
          cubit: bloc,
          builder: (context, state) {
            if (state is LeaveLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is GetPendingLeaveRequestsSuccessfully) {
              return Padding(
                padding: EdgeInsets.all(7),
                child: ListView.builder(
                  itemCount: state.items.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 5,
                      child: Padding(
                        padding: EdgeInsets.all(7),
                        child: Stack(children: <Widget>[
                          Align(
                            alignment: Alignment.topLeft,
                            child: Stack(
                              children: <Widget>[
                                Positioned(
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.only(left: 10, top: 5),
                                    child: Column(
                                      children: <Widget>[
                                        Text(state.items[index].fullName ?? "",style: TextStyle(fontWeight: FontWeight.bold),),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(state.items[index]
                                                .leaveSettingName ??
                                            "",style: TextStyle(fontSize: 14,color: Colors.black54)),
                                      ],
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
                                        child: ButtonTheme(
                                            minWidth: 100.0,
                                            height: 30.0,
                                            child: RaisedButton(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      new BorderRadius.circular(
                                                          15.0),
                                                  side: BorderSide(
                                                      color: Colors.white)),
                                              materialTapTargetSize:
                                                  MaterialTapTargetSize
                                                      .shrinkWrap,
                                              color: Color.fromRGBO(
                                                  243, 119, 55, 0.7),
                                              child: Text(
                                                "Approve",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.white),
                                              ),
                                              onPressed: () {
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ApprovePage(
                                                            bloc:bloc,
                                                              leave:
                                                                  state.items[
                                                                      index])),
                                                );
                                              },
                                            )),
                                        delay: 200,
                                      )),
                                ),
                              ],
                            ),
                          )
                        ]),
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
