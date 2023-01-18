import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:orc_hr/Bloc/Project/bloc/mission_bloc.dart';
import 'package:orc_hr/Models/Project/MissionRequest.dart';
import 'package:orc_hr/Widgets/General/Animation/delayed_animation.dart';
import 'package:orc_hr/Widgets/General/TextFormField.dart';
import 'package:orc_hr/Localization/Localization.dart';
import 'package:sliding_sheet/sliding_sheet.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ApprovePage extends StatefulWidget {
  final MissionRequest? mission;
  final MissionBloc? bloc;
  const ApprovePage({this.bloc, required this.mission});
  @override
  _ApprovePageState createState() => _ApprovePageState(this.mission);
}

class _ApprovePageState extends State<ApprovePage> {
  final MissionRequest? mission;
  String? note;
  MissionBloc? bloc;
  DateFormat formatter = DateFormat('dd/MM/yyyy');
  DateFormat timeFormatter = DateFormat('hh:mm');
  _ApprovePageState(this.mission);
  @override
  void initState() {
    super.initState();
    bloc = new MissionBloc();
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
          Localization.of(context).getTranslatedValue("MissionApprove"),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      backgroundColor: Colors.white,
      body: BlocListener<MissionBloc, MissionState>(
        bloc: bloc,
        listener: (context, state) {
          if (state is AcceptMissionRequestSuccessfully) {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(
                Localization.of(context)
                    .getTranslatedValue("MissionAcceptedSuccessfully"),
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.green,
            ));
            if (widget.bloc != null) {
              widget.bloc?.add(GetPendingMissionRequests());
            }
            Future.delayed(Duration(milliseconds: 1500),
                () => Navigator.of(context).pop());
          }
          if (state is PendingMissionRequestSuccessfully) {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(
                Localization.of(context)
                    .getTranslatedValue("MissionPendingSuccessfully"),
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.green,
            ));
            if (widget.bloc != null) {
              widget.bloc?.add(GetPendingMissionRequests());
            }
            Future.delayed(Duration(milliseconds: 1500),
                () => Navigator.of(context).pop());
          }
          if (state is RejectMissionRequestSuccessfully) {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(
                Localization.of(context)
                    .getTranslatedValue("MissionRejectedSuccessfully"),
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.green,
            ));
            if (widget.bloc != null) {
              widget.bloc?.add(GetPendingMissionRequests());
            }
            Future.delayed(Duration(milliseconds: 1500),
                () => Navigator.of(context).pop());
          }
          if (state is MissionError) {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(
                state.error,
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.red,
            ));
          }
        },
        child: BlocBuilder<MissionBloc, MissionState>(
            bloc: bloc,
            builder: (context, state) {
              if (state is MissionLoading) {
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
                                Container(
                                  width: 90,
                                  child: Text(Localization.of(context)
                                      .getTranslatedValue("EmployeeName")),
                                ),
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
                                      mission?.fullName ?? "",
                                      true,
                                      context),
                                ),
                              ]),
                              SizedBox(
                                height: 10,
                              ),
                              Row(children: <Widget>[
                                Container(
                                  width: 90,
                                  child: Text(Localization.of(context)
                                      .getTranslatedValue("StartDate")),
                                ),
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
                                      formatter.format(mission?.startDate ??
                                          new DateTime.now()),
                                      true,
                                      context),
                                ),
                              ]),
                              SizedBox(
                                height: 10,
                              ),
                              Row(children: <Widget>[
                                Container(
                                  width: 90,
                                  child: Text(Localization.of(context)
                                      .getTranslatedValue("EndDate")),
                                ),
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
                                      formatter.format(mission?.endDate ??
                                          new DateTime.now()),
                                      true,
                                      context),
                                ),
                              ]),
                              SizedBox(
                                height: 10,
                              ),
                              Row(children: <Widget>[
                                Container(
                                  width: 90,
                                  child: Text(Localization.of(context)
                                      .getTranslatedValue("HourlyMission")),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Checkbox(
                                  value: mission?.isHourlyMission ?? false,
                                  onChanged: null,
                                ),
                              ]),
                              SizedBox(
                                height: 10,
                              ),
                              mission?.isHourlyMission ?? false
                                  ? Row(children: <Widget>[
                                      Container(
                                        width: 90,
                                        child: Text(Localization.of(context)
                                            .getTranslatedValue("FromTime")),
                                      ),
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
                                            timeFormatter.format(
                                                mission?.fromTime ??
                                                    new DateTime.now()),
                                            true,
                                            context),
                                      ),
                                    ])
                                  : Container(),
                              mission?.isHourlyMission ?? false
                                  ? SizedBox(
                                      height: 10,
                                    )
                                  : Container(),
                              mission?.isHourlyMission ?? false
                                  ? Row(children: <Widget>[
                                      Container(
                                        width: 90,
                                        child: Text(Localization.of(context)
                                            .getTranslatedValue("ToTime")),
                                      ),
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
                                            timeFormatter.format(
                                                mission?.toTime ??
                                                    new DateTime.now()),
                                            true,
                                            context),
                                      ),
                                    ])
                                  : Container(),
                              mission?.isHourlyMission == true
                                  ? Container()
                                  : SizedBox(
                                      height: 10,
                                    ),
                              mission?.isHourlyMission == true
                                  ? Container()
                                  : Row(children: <Widget>[
                                      Container(
                                        width: 90,
                                        child: RichText(
                                          text: TextSpan(
                                              text: Localization.of(context)
                                                  .getTranslatedValue("Type"),
                                              style: TextStyle(
                                                  color: Colors.black),
                                              children: [
                                                TextSpan(
                                                    text: ' *',
                                                    style: TextStyle(
                                                        color: Colors.red))
                                              ]),
                                        ),
                                      ),
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
                                            mission?.typeString ?? "",
                                            true,
                                            context),
                                      ),
                                    ]),
                              SizedBox(
                                height: 10,
                              ),
                              Row(children: <Widget>[
                                Container(
                                  width: 90,
                                  child: Text(Localization.of(context)
                                      .getTranslatedValue("Description")),
                                ),
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
                                      mission?.description ?? "",
                                      true,
                                      context),
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
                            padding: EdgeInsets.all(
                                MediaQuery.of(context).size.width * 2 / 100),
                            width: MediaQuery.of(context).size.width,
                            color: Color.fromRGBO(243, 119, 55, 0.5),
                            height: 175,
                            child: Padding(
                                padding: EdgeInsets.all(
                                    MediaQuery.of(context).size.width *
                                        4 /
                                        100),
                                child: Row(
                                  children: <Widget>[
                                    Row(children: <Widget>[
                                      Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              10 /
                                              100,
                                          child: AutoSizeText(
                                            Localization.of(context)
                                                .getTranslatedValue("Note"),
                                            maxLines: 1,
                                          )),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                2 /
                                                100,
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                    53 /
                                                    100 -
                                                20,
                                        child: textFormField((value) {
                                          setState(() {
                                            note = value;
                                          });
                                        },
                                            Localization.of(context)
                                                .getTranslatedValue(
                                                    "Typeanote"),
                                            false,
                                            TextInputType.multiline,
                                            false,
                                            5,
                                            mission?.note ?? "",
                                            false,
                                            context),
                                      ),
                                    ]),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          3 /
                                          100,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          22 /
                                          100,
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
                                                  child: Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              20 /
                                                              100,
                                                      child: AutoSizeText(
                                                        Localization.of(context)
                                                            .getTranslatedValue(
                                                                "Accept"),
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      )),
                                                  onPressed: () {
                                                    bloc!.add(AcceptMissionRequest(
                                                        mission?.workflowItemId ??
                                                            0,
                                                        mission?.missionId ?? 0,
                                                        note ?? "",
                                                        mission?.isHourlyMission ??
                                                            false));
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
                                                  child: Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            20 /
                                                            100,
                                                    child: AutoSizeText(
                                                      Localization.of(context)
                                                          .getTranslatedValue(
                                                              "Reject"),
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    bloc!.add(RejectMissionRequest(
                                                        mission?.workflowItemId ??
                                                            0,
                                                        mission?.missionId ?? 0,
                                                        note ?? "",
                                                        mission?.isHourlyMission ??
                                                            false));
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
                                                  child: Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            20 /
                                                            100,
                                                    child: AutoSizeText(
                                                      Localization.of(context)
                                                          .getTranslatedValue(
                                                              "Pending"),
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    bloc!.add(PendingMissionRequest(
                                                        mission?.workflowItemId ??
                                                            0,
                                                        mission?.missionId ?? 0,
                                                        note ?? "",
                                                        mission?.isHourlyMission ??
                                                            false));
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
