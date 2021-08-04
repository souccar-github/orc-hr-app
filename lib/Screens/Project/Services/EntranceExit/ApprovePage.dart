import 'package:auto_size_text/auto_size_text.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:orc_hr/Bloc/Project/bloc/entranceexit_bloc.dart';
import 'package:orc_hr/Models/Project/EntranceExitRequest.dart';
import 'package:orc_hr/Localization/Localization.dart';
import 'package:orc_hr/Widgets/General/Animation/delayed_animation.dart';
import 'package:orc_hr/Widgets/General/TextFormField.dart';
import 'package:sliding_sheet/sliding_sheet.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ApprovePage extends StatefulWidget {
  final EntranceExitRequest record;
  final EntranceexitBloc bloc;
  const ApprovePage({this.bloc, this.record});
  @override
  _ApprovePageState createState() => _ApprovePageState(this.record);
}

class _ApprovePageState extends State<ApprovePage> {
  final EntranceExitRequest record;
  String note;
  EntranceexitBloc bloc;
  DateFormat formatter = DateFormat('dd/MM/yyyy');
  DateFormat timeFormatter = DateFormat('hh:mm');
  _ApprovePageState(this.record);
  List<DropdownMenuItem<int>> _dropdownMenuItems =
      new List<DropdownMenuItem<int>>();
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 0), () {
      List<DropdownMenuItem<int>> items = List();
      items.add(
        DropdownMenuItem(
          value: 0,
          child: Text(Localization.of(context).getTranslatedValue("Entrance")),
        ),
      );
      items.add(
        DropdownMenuItem(
          value: 1,
          child: Text(Localization.of(context).getTranslatedValue("Exit")),
        ),
      );
      _dropdownMenuItems = items;
    });
    bloc = new EntranceexitBloc();
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
          Localization.of(context).getTranslatedValue("EntranceExitApprove"),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      backgroundColor: Colors.white,
      body: BlocListener<EntranceexitBloc, EntranceexitState>(
        cubit: bloc,
        listener: (context, state) {
          if (state is AcceptEntranceexitRequestSuccessfully) {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(
                Localization.of(context)
                    .getTranslatedValue("EntranceExitAcceptedSuccessfully"),
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.green,
            ));
            if (widget.bloc != null) {
              widget.bloc.add(GetPendingEntranceexitRequests());
            }
            Future.delayed(Duration(milliseconds: 1500),
                () => Navigator.of(context).pop());
          }
          if (state is PendingEntranceexitRequestSuccessfully) {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(
                Localization.of(context)
                    .getTranslatedValue("EntranceExitPendingSuccessfully"),
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.green,
            ));
            if (widget.bloc != null) {
              widget.bloc.add(GetPendingEntranceexitRequests());
            }
            Future.delayed(Duration(milliseconds: 1500),
                () => Navigator.of(context).pop());
          }
          if (state is RejectEntranceexitRequestSuccessfully) {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(
                Localization.of(context)
                    .getTranslatedValue("EntranceExitRejectedSuccessfully"),
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.green,
            ));
            if (widget.bloc != null) {
              widget.bloc.add(GetPendingEntranceexitRequests());
            }
            Future.delayed(Duration(milliseconds: 1500),
                () => Navigator.of(context).pop());
          }
          if (state is EntranceExitError) {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(
                state.error,
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.red,
            ));
          }
        },
        child: BlocBuilder<EntranceexitBloc, EntranceexitState>(
            cubit: bloc,
            builder: (context, state) {
              if (state is EntranceExitLoading) {
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
                                RichText(
                                  text: TextSpan(
                                      text: Localization.of(context)
                                          .getTranslatedValue("RecordDate"),
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
                                    type: DateTimePickerType.dateTime,
                                    dateMask: 'dd /MM /yyyy , hh:mm',
                                    initialValue: record.recordDate.toString(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2100),
                                    icon: Icon(Icons.event),
                                    dateLabelText: Localization.of(context)
                                        .getTranslatedValue("Date"),
                                    onChanged: null,
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
                                          .getTranslatedValue("RecordType"),
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
                                  child: textFormField(
                                      (_) {},
                                      "",
                                      false,
                                      TextInputType.text,
                                      false,
                                      1,
                                      record.logTypeString,
                                      true,
                                      context),
                                ),
                              ]),
                              SizedBox(
                                height: 10,
                              ),
                              Row(children: <Widget>[
                                Text(Localization.of(context)
                                    .getTranslatedValue("Note")),
                                SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: textFormField(
                                      (_) => {},
                                      Localization.of(context)
                                          .getTranslatedValue("Typeanote"),
                                      false,
                                      TextInputType.multiline,
                                      false,
                                      5,
                                      record.note,
                                      true,
                                      context),
                                ),
                              ]),
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
                                                  .getTranslatedValue("Note"))),
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
                                            "",
                                            false,
                                            context),
                                      ),
                                    ]),
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
                                                    bloc.add(
                                                        AcceptEntranceexitRequest(
                                                            record
                                                                .workflowItemId,
                                                            record.recordId,
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
                                                            color:
                                                                Colors.white),
                                                      )),
                                                  onPressed: () {
                                                    bloc.add(
                                                        RejectEntranceexitRequest(
                                                            record
                                                                .workflowItemId,
                                                            record.recordId,
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
                                                    bloc.add(
                                                        PendingEntranceexitRequest(
                                                            record
                                                                .workflowItemId,
                                                            record.recordId,
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
