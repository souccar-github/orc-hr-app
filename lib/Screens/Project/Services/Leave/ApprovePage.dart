import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:orc_hr/Bloc/Project/bloc/leave_bloc.dart';
import 'package:orc_hr/Models/Project/LeaveRequest.dart';
import 'package:orc_hr/Widgets/General/Animation/delayed_animation.dart';
import 'package:orc_hr/Widgets/General/TextFormField.dart';
import 'package:orc_hr/Localization/Localization.dart';
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
          Localization.of(context).getTranslatedValue("LeaveApprove"),
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
                Localization.of(context).getTranslatedValue("LeaveAcceptedSuccessfully"),
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.green,
            ));
            if (widget.bloc != null) {
              widget.bloc.add(GetPendingLeaveRequests());
            }
            Future.delayed(Duration(milliseconds: 1500),
                () => Navigator.of(context).pop());
          }
          if (state is PendingLeaveRequestSuccessfully) {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(
                Localization.of(context).getTranslatedValue("LeavePendingSuccessfully"),
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.green,
            ));
            if (widget.bloc != null) {
              widget.bloc.add(GetPendingLeaveRequests());
            }
            Future.delayed(Duration(milliseconds: 1500),
                () => Navigator.of(context).pop());
          }
          if (state is RejectLeaveRequestSuccessfully) {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(
                Localization.of(context).getTranslatedValue("LeaveRejectedSuccessfully"),
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.green,
            ));
            if (widget.bloc != null) {
              widget.bloc.add(GetPendingLeaveRequests());
            }
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
                                Text(Localization.of(context).getTranslatedValue("EmployeeName")),
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
                                      true,context),
                                ),
                              ]),
                              SizedBox(
                                height: 10,
                              ),
                              Row(children: <Widget>[
                                Text(Localization.of(context).getTranslatedValue("LeaveSetting")),
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
                                      true,context),
                                ),
                              ]),
                              SizedBox(
                                height: 10,
                              ),
                              Row(children: <Widget>[
                                Text(Localization.of(context).getTranslatedValue("RequestDate")),
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
                                      true,context),
                                ),
                              ]),
                              SizedBox(
                                height: 10,
                              ),
                              Row(children: <Widget>[
                                Text(Localization.of(context).getTranslatedValue("StartDate")),
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
                                      true,context),
                                ),
                              ]),
                              SizedBox(
                                height: 10,
                              ),
                              Row(children: <Widget>[
                                Text(Localization.of(context).getTranslatedValue("EndDate")),
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
                                      true,context),
                                ),
                              ]),
                              SizedBox(
                                height: 10,
                              ),
                              Row(children: <Widget>[
                                Text(Localization.of(context).getTranslatedValue("HourlyLeave")),
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
                                      Text(Localization.of(context).getTranslatedValue("FromTime")),
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
                                            true,context),
                                      ),
                                    ])
                                  : Container(),
                              leave.isHourlyLeave
                                  ? Row(children: <Widget>[
                                      Text(Localization.of(context).getTranslatedValue("ToTime")),
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
                                            true,context),
                                      ),
                                    ])
                                  : Container(),
                              SizedBox(
                                height: 10,
                              ),
                              Row(children: <Widget>[
                                Text(Localization.of(context).getTranslatedValue("Duration")),
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
                                      true,context),
                                ),
                              ]),
                              SizedBox(
                                height: 10,
                              ),
                              Row(children: <Widget>[
                                Text(Localization.of(context).getTranslatedValue("LeaveReason")),
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
                                      true,context),
                                ),
                              ]),
                              SizedBox(
                                height: 10,
                              ),
                              Row(children: <Widget>[
                                Text(Localization.of(context).getTranslatedValue("Description")),
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
                                      true,context),
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
                                      Text(Localization.of(context).getTranslatedValue("Note")),
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
                                            Localization.of(context).getTranslatedValue("Typeanote"),
                                            false,
                                            TextInputType.multiline,
                                            false,
                                            5,
                                            "",
                                            false,context),
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
                                                    Localization.of(context).getTranslatedValue("Accept"),
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
                                                    Localization.of(context).getTranslatedValue("Reject"),
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
                                                    Localization.of(context).getTranslatedValue("Pending"),
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
