import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:orc_hr/Bloc/Project/bloc/leave_bloc.dart';
import 'package:orc_hr/Models/Project/LeaveRequest.dart';
import 'package:orc_hr/Widgets/General/Animation/delayed_animation.dart';
import 'package:orc_hr/Widgets/General/TextFormField.dart';
import 'package:sliding_sheet/sliding_sheet.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ApprovePage extends StatefulWidget {
  final LeaveRequest leave;
  final LeaveBloc bloc;
  const ApprovePage({this.bloc, this.leave});
  @override
  _ApprovePageState createState() => _ApprovePageState(this.leave);
}

class _ApprovePageState extends State<ApprovePage> {
  final LeaveRequest leave;
  String note;
  LeaveBloc bloc;
  DateFormat formatter = DateFormat('dd/MM/yyyy');
  DateFormat timeFormatter = DateFormat('hh:mm');
  _ApprovePageState(this.leave);
  @override
  void initState() {
    super.initState();
    bloc = new LeaveBloc();
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
          'Leave Approve',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      backgroundColor: Colors.white,
      body: BlocListener<LeaveBloc, LeaveState>(
        cubit: bloc,
        listener: (context, state) {
          if (state is AcceptLeaveRequestSuccessfully) {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(
                "Leave Accepted Successfully",
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.green,
            ));
            widget.bloc.add(GetPendingLeaveRequests());
            Future.delayed(Duration(milliseconds: 1500),
                () => Navigator.of(context).pop());
          }
          if (state is PendingLeaveRequestSuccessfully) {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(
                "Leave Pending Successfully",
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.green,
            ));
            widget.bloc.add(GetPendingLeaveRequests());
            Future.delayed(Duration(milliseconds: 1500),
                () => Navigator.of(context).pop());
          }
          if (state is RejectLeaveRequestSuccessfully) {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(
                "Leave Rejected Successfully",
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.green,
            ));
            widget.bloc.add(GetPendingLeaveRequests());
            Future.delayed(Duration(milliseconds: 1500),
                () => Navigator.of(context).pop());
          }
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
              } else {
                return SlidingSheet(
                  elevation: 8,
                  cornerRadius: 16,
                  snapSpec: const SnapSpec(
                    snap: true,
                    snappings: [0.1, 0.1, 1.0],
                    positioning: SnapPositioning.relativeToSheetHeight,
                  ),
                  body: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height - 150,
                    child: SingleChildScrollView(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            children: <Widget>[
                              Row(children: <Widget>[
                                Text("Employee Name"),
                                SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: textFormField(
                                      (_) {},
                                      "",
                                      false,
                                      TextInputType.text,
                                      false,
                                      1,
                                      leave.fullName,
                                      true),
                                ),
                              ]),
                              SizedBox(
                                height: 10,
                              ),
                              Row(children: <Widget>[
                                Text("Leave Setting"),
                                SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: textFormField(
                                      (_) {},
                                      "",
                                      false,
                                      TextInputType.text,
                                      false,
                                      1,
                                      leave.leaveSettingName,
                                      true),
                                ),
                              ]),
                              SizedBox(
                                height: 10,
                              ),
                              Row(children: <Widget>[
                                Text("Request Date"),
                                SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: textFormField(
                                      (_) {},
                                      "",
                                      false,
                                      TextInputType.text,
                                      false,
                                      1,
                                      formatter.format(leave.requestDate),
                                      true),
                                ),
                              ]),
                              SizedBox(
                                height: 10,
                              ),
                              Row(children: <Widget>[
                                Text("Start Date"),
                                SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: textFormField(
                                      (_) {},
                                      "",
                                      false,
                                      TextInputType.text,
                                      false,
                                      1,
                                      formatter.format(leave.startDate),
                                      true),
                                ),
                              ]),
                              SizedBox(
                                height: 10,
                              ),
                              Row(children: <Widget>[
                                Text("End Date"),
                                SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: textFormField(
                                      (_) {},
                                      "",
                                      false,
                                      TextInputType.text,
                                      false,
                                      1,
                                      formatter.format(leave.endDate),
                                      true),
                                ),
                              ]),
                              SizedBox(
                                height: 10,
                              ),
                              Row(children: <Widget>[
                                Text("Hourly Leave"),
                                SizedBox(
                                  width: 20,
                                ),
                                Checkbox(
                                  value: leave.isHourlyLeave,
                                  onChanged: null,
                                ),
                              ]),
                              SizedBox(
                                height: 10,
                              ),
                              leave.isHourlyLeave
                                  ? Row(children: <Widget>[
                                      Text("From Time"),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        child: textFormField(
                                            (_) {},
                                            "",
                                            false,
                                            TextInputType.text,
                                            false,
                                            1,
                                            timeFormatter
                                                .format(leave.fromTime),
                                            true),
                                      ),
                                    ])
                                  : Container(),
                              leave.isHourlyLeave
                                  ? Row(children: <Widget>[
                                      Text("To Time"),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        child: textFormField(
                                            (_) {},
                                            "",
                                            false,
                                            TextInputType.text,
                                            false,
                                            1,
                                            timeFormatter.format(leave.toTime),
                                            true),
                                      ),
                                    ])
                                  : Container(),
                              SizedBox(
                                height: 10,
                              ),
                              Row(children: <Widget>[
                                Text("Duration"),
                                SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: textFormField(
                                      (_) {},
                                      "",
                                      false,
                                      TextInputType.text,
                                      false,
                                      1,
                                      leave.spentDays.toString(),
                                      true),
                                ),
                              ]),
                              SizedBox(
                                height: 10,
                              ),
                              Row(children: <Widget>[
                                Text("Leave Reason"),
                                SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: textFormField(
                                      (_) {},
                                      "",
                                      false,
                                      TextInputType.text,
                                      false,
                                      1,
                                      leave.leaveReason,
                                      true),
                                ),
                              ]),
                              SizedBox(
                                height: 10,
                              ),
                              Row(children: <Widget>[
                                Text("Description"),
                                SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: textFormField(
                                      (_) {},
                                      "",
                                      false,
                                      TextInputType.multiline,
                                      false,
                                      5,
                                      leave.description,
                                      true),
                                ),
                              ]),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  builder: (context, state) {
                    return Center(
                        child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Positioned(
                          child: Icon(
                            Icons.keyboard_arrow_up,
                            color: Colors.black,
                            size: 30,
                          ),
                          top: 5,
                          left: MediaQuery.of(context).size.width / 2 - 17,
                        ),
                        Container(
                            padding: EdgeInsets.all(10),
                            width: MediaQuery.of(context).size.width,
                            color: Color.fromRGBO(243, 119, 55, 0.5),
                            height: 175,
                            child: Padding(
                                padding: EdgeInsets.all(20),
                                child: Row(
                                  children: <Widget>[
                                    Row(children: <Widget>[
                                      Text("Note"),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                    2 -
                                                20,
                                        child: textFormField((value) {
                                          setState(() {
                                            note = value;
                                          });
                                        },
                                            "Type a note ...",
                                            false,
                                            TextInputType.multiline,
                                            false,
                                            5,
                                            "",
                                            false),
                                      ),
                                    ]),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width /
                                          3.8,
                                      child: Column(
                                        children: <Widget>[
                                          DelayedAnimation(
                                            child: ButtonTheme(
                                                minWidth: 100.0,
                                                height: 30.0,
                                                child: RaisedButton(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          new BorderRadius
                                                              .circular(15.0),
                                                      side: BorderSide(
                                                          color: Colors.white)),
                                                  materialTapTargetSize:
                                                      MaterialTapTargetSize
                                                          .shrinkWrap,
                                                  color: Color.fromRGBO(
                                                      243, 119, 55, 0.7),
                                                  child: Text(
                                                    "Accept",
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.white),
                                                  ),
                                                  onPressed: () {
                                                    bloc.add(AcceptLeaveRequest(
                                                        leave.workflowItemId,
                                                        leave.leaveId,
                                                        note));
                                                  },
                                                )),
                                            delay: 200,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          DelayedAnimation(
                                            child: ButtonTheme(
                                                minWidth: 100.0,
                                                height: 30.0,
                                                child: RaisedButton(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          new BorderRadius
                                                              .circular(15.0),
                                                      side: BorderSide(
                                                          color: Colors.white)),
                                                  materialTapTargetSize:
                                                      MaterialTapTargetSize
                                                          .shrinkWrap,
                                                  color: Color.fromRGBO(
                                                      243, 119, 55, 0.7),
                                                  child: Text(
                                                    "Reject",
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.white),
                                                  ),
                                                  onPressed: () {
                                                    bloc.add(RejectLeaveRequest(
                                                        leave.workflowItemId,
                                                        leave.leaveId,
                                                        note));
                                                  },
                                                )),
                                            delay: 200,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          DelayedAnimation(
                                            child: ButtonTheme(
                                                minWidth: 100.0,
                                                height: 30.0,
                                                child: RaisedButton(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          new BorderRadius
                                                              .circular(15.0),
                                                      side: BorderSide(
                                                          color: Colors.white)),
                                                  materialTapTargetSize:
                                                      MaterialTapTargetSize
                                                          .shrinkWrap,
                                                  color: Color.fromRGBO(
                                                      243, 119, 55, 0.7),
                                                  child: Text(
                                                    "Pending",
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.white),
                                                  ),
                                                  onPressed: () {
                                                    bloc.add(
                                                        PendingLeaveRequest(
                                                            leave
                                                                .workflowItemId,
                                                            leave.leaveId,
                                                            note));
                                                  },
                                                )),
                                            delay: 200,
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                )))
                      ],
                    ));
                  },
                );
              }
            }),
      ),
    );
  }
}
