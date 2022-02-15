import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orc_hr/Bloc/Project/bloc/mission_bloc.dart';
import 'package:orc_hr/Models/Project/DropdownItemModel.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:orc_hr/Models/Project/MissionRequest.dart';
import 'package:orc_hr/Localization/Localization.dart';
import 'package:orc_hr/Widgets/General/Drawer.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

import 'package:orc_hr/Widgets/General/Dropdown.dart';
import 'package:orc_hr/Widgets/General/TextFormField.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MissionRequestPage extends StatefulWidget {
  @override
  _MissionRequestState createState() => _MissionRequestState();
}

class _MissionRequestState extends State<MissionRequestPage> {
  double duration;
  MissionBloc bloc;
  TextEditingController _controller, _textController;
  String requestDate, startDate, endDate, fromTime, toTime, note;
  bool hourly;

  _MissionRequestState();
  @override
  void initState() {
    super.initState();
    fromTime = DateTime.now().toString();
    startDate = DateTime.now().toString();
    endDate = DateTime.now().toString();
    hourly = false;
    toTime = DateTime.now().toString();
    _controller = new TextEditingController(text: DateTime.now().toString());
    bloc = new MissionBloc();
  }

  onChangeTextField(String value) {
    setState(() {
      note = value;
    });
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
          Localization.of(context).getTranslatedValue("MissionRequest"),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      backgroundColor: Colors.white,
      body: BlocListener<MissionBloc, MissionState>(
          cubit: bloc,
          listener: (context, state) {
            if (state is MissionError) {
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text(
                  state.error,
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.red,
              ));
            }

            if (state is PostMissionRequestSuccessfully) {
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text(
                  Localization.of(context)
                      .getTranslatedValue("MissionRequestedSuccessfully"),
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.green,
              ));
              Future.delayed(Duration(milliseconds: 1000),
                  () => Navigator.of(context).pop());
            }
            if (state is GetSpentDaysSuccessfully) {
              setState(() {
                _textController.text = state.days.toString();
                duration = double.parse(state.days);
              });
            }
          },
          child: BlocBuilder<MissionBloc, MissionState>(
            cubit: bloc,
            builder: (context, state) {
              if (state is MissionLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Container(
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
                            RichText(
                              text: TextSpan(
                                  text: Localization.of(context)
                                      .getTranslatedValue("StartDate"),
                                  style: TextStyle(color: Colors.black),
                                  children: [
                                    TextSpan(
                                        text: ' *',
                                        style: TextStyle(color: Colors.red))
                                  ]),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 2,
                              child: DateTimePicker(
                                type: DateTimePickerType.date,
                                dateMask: 'dd MMM, yyyy',
                                initialValue: DateTime.now().toString(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2100),
                                icon: Icon(Icons.event),
                                dateLabelText: Localization.of(context)
                                    .getTranslatedValue("Date"),
                                onChanged: (val) {
                                  setState(() {
                                    startDate = val + "  00:00:00";
                                  });
                                },
                              ),
                            ),
                          ]),
                          SizedBox(
                            height: 10,
                          ),
                          Row(children: <Widget>[
                            RichText(
                              text: TextSpan(
                                  text: Localization.of(context)
                                      .getTranslatedValue("EndDate"),
                                  style: TextStyle(color: Colors.black),
                                  children: [
                                    TextSpan(
                                        text: ' *',
                                        style: TextStyle(color: Colors.red))
                                  ]),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 2,
                              child: DateTimePicker(
                                readOnly: hourly,
                                controller: _controller,
                                enabled: !hourly,
                                type: DateTimePickerType.date,
                                dateMask: 'dd MMM, yyyy',
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2100),
                                icon: Icon(Icons.event),
                                dateLabelText: 'Date',
                                onChanged: (val) {
                                  setState(() {
                                    endDate = val + " 00:00:00";
                                  });
                                },
                              ),
                            ),
                          ]),
                          SizedBox(
                            height: 10,
                          ),
                          Row(children: <Widget>[
                            Text(Localization.of(context)
                                .getTranslatedValue("HourlyMission")),
                            SizedBox(
                              width: 20,
                            ),
                            Checkbox(
                              value: hourly,
                              onChanged: (bool value) {
                                setState(() {
                                  hourly = value;
                                  _controller.text = DateTime.now().toString();
                                  endDate = startDate;
                                  if (!hourly) {
                                    fromTime = DateTime.now().toString();

                                    toTime = DateTime.now().toString();
                                  }
                                });
                              },
                            ),
                          ]),
                          hourly
                              ? Row(children: <Widget>[
                                  RichText(
                                    text: TextSpan(
                                        text: Localization.of(context)
                                            .getTranslatedValue("FromTime"),
                                        style: TextStyle(color: Colors.black),
                                        children: [
                                          TextSpan(
                                              text: ' *',
                                              style:
                                                  TextStyle(color: Colors.red))
                                        ]),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2.2,
                                    child: DateTimePicker(
                                      type: DateTimePickerType.time,
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2100),
                                      initialValue: DateTime.now()
                                          .toIso8601String()
                                          .substring(11, 16),
                                      icon: Icon(Icons.access_time),
                                      dateLabelText: Localization.of(context)
                                          .getTranslatedValue("Time"),
                                      onChanged: (val) {
                                        setState(() {
                                          fromTime =
                                              startDate.substring(0, 11) + val;
                                        });
                                      },
                                    ),
                                  ),
                                ])
                              : Container(),
                          hourly
                              ? Row(children: <Widget>[
                                  RichText(
                                    text: TextSpan(
                                        text: Localization.of(context)
                                            .getTranslatedValue("ToTime"),
                                        style: TextStyle(color: Colors.black),
                                        children: [
                                          TextSpan(
                                              text: ' *',
                                              style:
                                                  TextStyle(color: Colors.red))
                                        ]),
                                  ),
                                  SizedBox(
                                    width: 25,
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2.2,
                                    child: DateTimePicker(
                                      type: DateTimePickerType.time,
                                      firstDate: DateTime(2000),
                                      initialValue: DateTime.now()
                                          .toIso8601String()
                                          .substring(11, 16),
                                      lastDate: DateTime(2100),
                                      icon: Icon(Icons.access_time),
                                      dateLabelText: Localization.of(context)
                                          .getTranslatedValue("Time"),
                                      onChanged: (val) {
                                        setState(() {
                                          toTime =
                                              startDate.substring(0, 11) + val;
                                        });
                                      },
                                    ),
                                  ),
                                ])
                              : Container(),
                          SizedBox(
                            height: 10,
                          ),
                          Row(children: <Widget>[
                            Text(Localization.of(context)
                                .getTranslatedValue("Description")),
                            SizedBox(
                              width: 20,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 2,
                              child: textFormField(
                                  onChangeTextField,
                                  Localization.of(context)
                                      .getTranslatedValue("Typeadescription"),
                                  false,
                                  TextInputType.multiline,
                                  false,
                                  5,
                                  "",
                                  false,
                                  context),
                            ),
                          ]),
                          SizedBox(
                            height: 10,
                          ),
                          ButtonTheme(
                              minWidth: 100.0,
                              height: 50.0,
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(15.0),
                                    side: BorderSide(color: Colors.white)),
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                color: Color.fromRGBO(243, 119, 55, 1),
                                child: Text(
                                  Localization.of(context)
                                      .getTranslatedValue("Apply"),
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                                onPressed: () {
                                  var model = new MissionRequest(
                                      note ?? "",
                                      0,
                                      DateTime.parse(endDate.substring(0, 10)),
                                      fromTime == null
                                          ? new DateTime.now()
                                          : DateTime.parse(fromTime),
                                      "",
                                      hourly,
                                      0,
                                      0,
                                      0,
                                      "",
                                      new DateTime.now(),
                                      DateTime.parse(
                                          startDate.substring(0, 10)),
                                      toTime == null
                                          ? new DateTime.now()
                                          : DateTime.parse(toTime),
                                      0,"");
                                  bloc.add(PostMissionRequest(model));
                                },
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          )),
    );
  }
}
