import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orc_hr/Bloc/Project/bloc/leave_bloc.dart';
import 'package:orc_hr/Models/Project/DropdownItemModel.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:orc_hr/Models/Project/LeaveRequest.dart';
import 'package:orc_hr/Models/Project/LeaveSetting.dart';
import 'package:orc_hr/Models/Project/LeaveReason.dart';
import 'package:orc_hr/Models/Project/LeaveInfoModel.dart';
import 'package:orc_hr/Widgets/General/Drawer.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

import 'package:orc_hr/Widgets/General/Dropdown.dart';
import 'package:orc_hr/Widgets/General/TextFormField.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LeaveRequestPage extends StatefulWidget {
  int id;
  LeaveRequestPage(this.id);
  @override
  _LeaveRequestState createState() => _LeaveRequestState(this.id);
}

class _LeaveRequestState extends State<LeaveRequestPage> {
  int id;
  double duration;
  bool isDivisibleToHours;
  bool isIndivisible;
  DropDownListItem _selectedSetting;
  DropDownListItem _selectedReason;
  LeaveBloc bloc;
  List<ChartData> chartData;
  TextEditingController _controller, _textController;
  String requestDate, startDate, endDate, fromTime, toTime, note;
  bool hourly;
  List<DropdownMenuItem<DropDownListItem>> _dropdownMenuItems =
      new List<DropdownMenuItem<DropDownListItem>>();
  List<DropdownMenuItem<DropDownListItem>> _reasonsDropdownMenuItems =
      new List<DropdownMenuItem<DropDownListItem>>();
  List<LeaveSetting> settings = new List<LeaveSetting>();
  List<LeaveReason> reasons = new List<LeaveReason>();
  LeaveInfoModel info;

  _LeaveRequestState(this.id);
  @override
  void initState() {
    super.initState();
    fromTime = DateTime.now().toString();
    isIndivisible = false;
    isDivisibleToHours = true;
    startDate = DateTime.now().toString();
    endDate = DateTime.now().toString();
    requestDate = DateTime.now().toString();
    duration = 0.0;
    hourly = false;
    _controller = new TextEditingController(text: DateTime.now().toString());
    _textController = new TextEditingController(text: duration.toString());
    toTime = DateTime.now().toString();

    bloc = new LeaveBloc();
    bloc.add(GetLeaveSettings());
    bloc.add(GetLeaveReasons());
    if (id != null && id != 0) {
      bloc.add(GetLeaveSettingInfo(id, DateTime.now()));
    }
    var model = new LeaveRequest(
        "",
        0,
        DateTime.parse(endDate.substring(0, 10)),
        DateTime.parse(startDate.substring(0, 10)),
        fromTime == null ? new DateTime.now() : DateTime.parse(fromTime),
        "",
        hourly,
        false,
        0,
        "",
        0,
        _selectedSetting == null ? 0 : _selectedSetting.id,
        "",
        0,
        0,
        "",
        DateTime.parse(requestDate),
        0,
        DateTime.parse(startDate.substring(0, 10)),
        DateTime.parse(endDate.substring(0, 10)),
        toTime== null ? new DateTime.now() : DateTime.parse(toTime),
        0);
    bloc.add(GetSpentDays(model));
  }

  List<DropdownMenuItem<DropDownListItem>> buildDropdownMenuItems(
      List<LeaveSetting> _items) {
    List<DropdownMenuItem<DropDownListItem>> items = List();
    for (LeaveSetting item in _items) {
      var i = new DropDownListItem(item.id, item.title);
      items.add(
        DropdownMenuItem(
          value: i,
          child: Text(i.name),
        ),
      );
    }
    return items;
  }

  List<DropdownMenuItem<DropDownListItem>> buildReasonsDropdownMenuItems(
      List<LeaveReason> _items) {
    List<DropdownMenuItem<DropDownListItem>> items = List();
    for (LeaveReason item in _items) {
      var i = new DropDownListItem(item.id, item.title);
      items.add(
        DropdownMenuItem(
          value: i,
          child: Text(i.name),
        ),
      );
    }
    return items;
  }

  onChangeTextField(String value) {
    setState(() {
      note = value;
    });
  }

  onChangeDropdownItem(DropDownListItem selectedItem) {
    setState(() {
      _selectedSetting = selectedItem;
    });
    bloc.add(GetLeaveSettingInfo(selectedItem.id, DateTime.now()));
    var model = new LeaveRequest(
        "",
        0,
        DateTime.parse(endDate.substring(0, 10)),
        DateTime.parse(startDate.substring(0, 10)),
        fromTime == null ? new DateTime.now() : DateTime.parse(fromTime),
        "",
        hourly,
        false,
        0,
        "",
        0,
        _selectedSetting == null ? 0 : _selectedSetting.id,
        "",
        0,
        0,
        "",
        DateTime.parse(requestDate),
        0,
        DateTime.parse(startDate.substring(0, 10)),
        DateTime.parse(endDate.substring(0, 10)),
        toTime== null ? new DateTime.now() : DateTime.parse(toTime),
        0);
    bloc.add(GetSpentDays(model));
  }

  onChangeReasonsDropdownItem(DropDownListItem selectedItem) {
    setState(() {
      _selectedReason = selectedItem;
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
          'Leave Request',
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
            if (state is GetLeaveSettingInfoSuccessfully) {
              setState(() {
                info = state.info;
                _selectedSetting = _dropdownMenuItems
                    .firstWhere((i) => i.value.id == state.info.id)
                    .value;
                if (info.isDivisibleToHours!=null){
                  isDivisibleToHours = info.isDivisibleToHours;
                }
                if (info.isIndivisible!=null){
                  isIndivisible = info.isIndivisible;
                }
                var model = new LeaveRequest(
                    "",
                    0,
                    DateTime.parse(endDate.substring(0, 10)),
                    DateTime.parse(startDate.substring(0, 10)),
                    fromTime == null ? new DateTime.now() : DateTime.parse(fromTime),
                    "",
                    hourly,
                    false,
                    0,
                    "",
                    0,
                    _selectedSetting == null ? 0 : _selectedSetting.id,
                    "",
                    0,
                    0,
                    "",
                    DateTime.parse(requestDate),
                    0,
                    DateTime.parse(startDate.substring(0, 10)),
                    DateTime.parse(endDate.substring(0, 10)),
                    toTime== null ? new DateTime.now() : DateTime.parse(toTime),
                    0);
                bloc.add(GetSpentDays(model));
                chartData = [
                  ChartData('Granted', state.info.granted, Colors.red),
                  ChartData('Remain', state.info.remain, Colors.green)
                ];
              });
            }
            if (state is PostLeaveRequestSuccessfully) {
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text(
                  "Leave Requested Successfully",
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
            if (state is GetLeaveSettingsSuccessfully) {
              setState(() {
                settings = state.settings;
                _dropdownMenuItems = buildDropdownMenuItems(state.settings);
              });
            }

            if (state is GetLeaveReasonsSuccessfully) {
              setState(() {
                reasons = state.reasons;
                _reasonsDropdownMenuItems =
                    buildReasonsDropdownMenuItems(state.reasons);
              });
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
                                    text: "Leave Type",
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
                              dropdown(context, _selectedSetting, "Leave Type",
                                  _dropdownMenuItems, onChangeDropdownItem),
                            ]),
                            SizedBox(
                              height: 10,
                            ),
                            Row(children: <Widget>[
                              RichText(
                                text: TextSpan(
                                    text: "Request Date",
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
                                  initialValue: requestDate ??
                                      (new DateTime(
                                              DateTime.now().year,
                                              DateTime.now().month,
                                              DateTime.now().day))
                                          .toString(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2100),
                                  icon: Icon(Icons.event),
                                  dateLabelText: 'Date',
                                  onChanged: (val) {
                                    requestDate = val;
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
                                    text: "Start Date",
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
                                  dateLabelText: 'Date',
                                  onChanged: (val) {
                                    setState(() {
                                      startDate = val + "  00:00:00";
                                      var model = new LeaveRequest(
                                          "",
                                          0,
                                          DateTime.parse(
                                              endDate.substring(0, 10)),
                                          DateTime.parse(
                                              startDate.substring(0, 10)),
                                          fromTime == null ? new DateTime.now() : fromTime == null ? new DateTime.now() : DateTime.parse(fromTime),
                                          "",
                                          hourly,
                                          false,
                                          0,
                                          "",
                                          0,
                                          _selectedSetting == null
                                              ? 0
                                              : _selectedSetting.id,
                                          "",
                                          0,
                                          0,
                                          "",
                                          DateTime.parse(requestDate),
                                          0,
                                          DateTime.parse(
                                              startDate.substring(0, 10)),
                                          DateTime.parse(
                                              endDate.substring(0, 10)),
                                          toTime== null ? new DateTime.now() : DateTime.parse(toTime),
                                          0);
                                      bloc.add(GetSpentDays(model));
                                    });
                                  },
                                ),
                              ),
                            ]),
                            SizedBox(
                              height: 10,
                            ),
                            !isIndivisible? Row(children: <Widget>[
                              RichText(
                                text: TextSpan(
                                    text: "End Date",
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
                                      var model = new LeaveRequest(
                                          "",
                                          0,
                                          DateTime.parse(
                                              endDate.substring(0, 10)),
                                          DateTime.parse(
                                              startDate.substring(0, 10)),
                                          fromTime == null ? new DateTime.now() : DateTime.parse(fromTime),
                                          "",
                                          hourly,
                                          false,
                                          0,
                                          "",
                                          0,
                                          _selectedSetting == null
                                              ? 0
                                              : _selectedSetting.id,
                                          "",
                                          0,
                                          0,
                                          "",
                                          DateTime.parse(requestDate),
                                          0,
                                          DateTime.parse(
                                              startDate.substring(0, 10)),
                                          DateTime.parse(
                                              endDate.substring(0, 10)),
                                          toTime== null ? new DateTime.now() : DateTime.parse(toTime),
                                          0);
                                      bloc.add(GetSpentDays(model));
                                    });
                                  },
                                ),
                              ),
                            ]):Container(),
                            SizedBox(
                              height:!isIndivisible? 10:0,
                            ),
                            (isDivisibleToHours && !isIndivisible)? Row(children: <Widget>[
                              Text("Hourly Leave"),
                              SizedBox(
                                width: 20,
                              ),
                              Checkbox(
                                value: hourly,
                                onChanged: (bool value) {
                                  setState(() {
                                    hourly = value;
                                    _controller.text =
                                        DateTime.now().toString();
                                    endDate = startDate;
                                    if (!hourly) {
                                      fromTime = DateTime.now().toString();

                                      toTime = DateTime.now().toString();
                                    }
                                    var model = new LeaveRequest(
                                        "",
                                        0,
                                        DateTime.parse(
                                            endDate.substring(0, 10)),
                                        DateTime.parse(
                                            startDate.substring(0, 10)),
                                        fromTime == null ? new DateTime.now() : DateTime.parse(fromTime),
                                        "",
                                        hourly,
                                        false,
                                        0,
                                        "",
                                        0,
                                        _selectedSetting == null
                                            ? 0
                                            : _selectedSetting.id,
                                        "",
                                        0,
                                        0,
                                        "",
                                        DateTime.parse(requestDate),
                                        0,
                                        DateTime.parse(
                                            startDate.substring(0, 10)),
                                        DateTime.parse(
                                            endDate.substring(0, 10)),
                                        toTime== null ? new DateTime.now() : DateTime.parse(toTime),
                                        0);
                                    bloc.add(GetSpentDays(model));
                                  });
                                },
                              ),
                            ]):Container(),
                            hourly
                                ? Row(children: <Widget>[
                                    RichText(
                                      text: TextSpan(
                                          text: "From Time",
                                          style: TextStyle(color: Colors.black),
                                          children: [
                                            TextSpan(
                                                text: ' *',
                                                style: TextStyle(
                                                    color: Colors.red))
                                          ]),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width /
                                          2.2,
                                      child: DateTimePicker(
                                        type: DateTimePickerType.time,
                                        firstDate: DateTime(2000),
                                        lastDate: DateTime(2100),
                                        initialValue: DateTime.now().toIso8601String().substring(11,16),
                                        icon: Icon(Icons.access_time),
                                        dateLabelText: 'Time',
                                        onChanged: (val) {
                                          setState(() {
                                            fromTime =
                                                startDate.substring(0, 11) +
                                                    val;
                                            var model = new LeaveRequest(
                                                "",
                                                0,
                                                DateTime.parse(
                                                    endDate.substring(0, 10)),
                                                DateTime.parse(
                                                    startDate.substring(0, 10)),
                                                fromTime == null ? new DateTime.now() : DateTime.parse(fromTime),
                                                "",
                                                hourly,
                                                false,
                                                0,
                                                "",
                                                0,
                                                _selectedSetting == null
                                                    ? 0
                                                    : _selectedSetting.id,
                                                "",
                                                0,
                                                0,
                                                "",
                                                DateTime.parse(requestDate),
                                                0,
                                                DateTime.parse(
                                                    startDate.substring(0, 10)),
                                                DateTime.parse(
                                                    endDate.substring(0, 10)),
                                                toTime== null ? new DateTime.now() : DateTime.parse(toTime),
                                                0);
                                            bloc.add(GetSpentDays(model));
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
                                          text: "To Time",
                                          style: TextStyle(color: Colors.black),
                                          children: [
                                            TextSpan(
                                                text: ' *',
                                                style: TextStyle(
                                                    color: Colors.red))
                                          ]),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width /
                                          2.2,
                                      child: DateTimePicker(
                                        type: DateTimePickerType.time,
                                        firstDate: DateTime(2000),
                                        initialValue: DateTime.now().toIso8601String().substring(11,16),
                                        lastDate: DateTime(2100),
                                        icon: Icon(Icons.access_time),
                                        dateLabelText: 'Time',
                                        onChanged: (val) {
                                          setState(() {
                                            toTime =
                                                startDate.substring(0, 11) +
                                                    val;
                                            var model = new LeaveRequest(
                                                "",
                                                0,
                                                DateTime.parse(
                                                    endDate.substring(0, 10)),
                                                DateTime.parse(
                                                    startDate.substring(0, 10)),
                                                fromTime == null ? new DateTime.now() : DateTime.parse(fromTime),
                                                "",
                                                hourly,
                                                false,
                                                0,
                                                "",
                                                0,
                                                _selectedSetting == null
                                                    ? 0
                                                    : _selectedSetting.id,
                                                "",
                                                0,
                                                0,
                                                "",
                                                DateTime.parse(requestDate),
                                                0,
                                                DateTime.parse(
                                                    startDate.substring(0, 10)),
                                                DateTime.parse(
                                                    endDate.substring(0, 10)),
                                                toTime== null ? new DateTime.now() : DateTime.parse(toTime),
                                                0);
                                            bloc.add(GetSpentDays(model));
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
                              Text("Duration"),
                              SizedBox(
                                width: 20,
                              ),
                              Container(
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: TextFormField(
                                    controller: _textController,
                                    onChanged: (_) {},
                                    readOnly: true,
                                    decoration: new InputDecoration(
                                      contentPadding: EdgeInsets.fromLTRB(
                                          20.0, 10.0, 20.0, 10.0),
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintText: "Duration",
                                      labelStyle: TextStyle(
                                          color:
                                              Color.fromRGBO(243, 119, 55, 1)),
                                      enabledBorder: new OutlineInputBorder(
                                        borderRadius:
                                            new BorderRadius.circular(20.0),
                                        borderSide: new BorderSide(
                                            style: BorderStyle.solid,
                                            color: Color.fromRGBO(
                                                243, 119, 55, 0.5)),
                                      ),
                                      focusedBorder: new OutlineInputBorder(
                                        borderRadius:
                                            new BorderRadius.circular(20.0),
                                        borderSide: new BorderSide(
                                            style: BorderStyle.solid,
                                            color: Color.fromRGBO(
                                                243, 119, 55, 0.5)),
                                      ),
                                      focusedErrorBorder:
                                          new OutlineInputBorder(
                                        borderRadius:
                                            new BorderRadius.circular(20.0),
                                        borderSide: new BorderSide(
                                            style: BorderStyle.solid,
                                            color: Colors.red[200]),
                                      ),
                                      errorBorder: new OutlineInputBorder(
                                        borderRadius:
                                            new BorderRadius.circular(20.0),
                                        borderSide: new BorderSide(
                                            style: BorderStyle.solid,
                                            color: Colors.red[200]),
                                      ),
                                      errorStyle: TextStyle(
                                        color: Colors.red[200],
                                      ),
                                    ),
                                  )),
                              SizedBox(
                                width: 10,
                              ),
                              BlocBuilder<LeaveBloc, LeaveState>(
                                cubit: bloc,
                                builder: (context, state) {
                                  if (state is DaysLoading) {
                                    return CircularProgressIndicator();
                                  }
                                  return Container();
                                },
                              )
                            ]),
                            SizedBox(
                              height: 10,
                            ),
                            Row(children: <Widget>[
                              RichText(
                                text: TextSpan(
                                    text: "Leave Reason",
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
                              dropdown(
                                  context,
                                  _selectedReason,
                                  "Leave Reason",
                                  _reasonsDropdownMenuItems,
                                  onChangeReasonsDropdownItem),
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
                                    onChangeTextField,
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
                                    "Apply",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                  onPressed: () {
                                    var model = new LeaveRequest(
                                        note??"",
                                        0,
                                        DateTime.parse(
                                            endDate.substring(0, 10)),
                                        DateTime.parse(
                                            startDate.substring(0, 10)),
                                        fromTime == null ? new DateTime.now() : DateTime.parse(fromTime),
                                        "",
                                        hourly,
                                        false,
                                        0,
                                        _selectedReason == null
                                            ? ""
                                            : _selectedReason.name,
                                        _selectedReason == null
                                            ? 0
                                            : _selectedReason.id,
                                        _selectedSetting == null
                                            ? 0
                                            : _selectedSetting.id,
                                        _selectedSetting == null
                                            ? ""
                                            : _selectedSetting.name,
                                        0,
                                        0,
                                        "",
                                        DateTime.parse(requestDate),
                                        double.parse(_textController.text),
                                        DateTime.parse(
                                            startDate.substring(0, 10)),
                                        DateTime.parse(
                                            endDate.substring(0, 10)),
                                        toTime== null ? new DateTime.now() : DateTime.parse(toTime),
                                        0);
                                    bloc.add(PostLeaveRequest(model,info,duration));
                                  },
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                builder: (context, state) {
                  return Stack(
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
                        color: Color.fromRGBO(243, 119, 55, 0.5),
                        height: 500,
                        child: Center(
                            child: info != null
                                ? Column(
                                    children: <Widget>[
                                      SizedBox(
                                        height: 60,
                                      ),
                                      SfCircularChart(
                                          legend: Legend(
                                              isVisible: true,
                                              position: LegendPosition.bottom),
                                          series: <CircularSeries>[
                                            DoughnutSeries<ChartData, String>(
                                                dataSource: chartData,
                                                pointColorMapper:
                                                    (ChartData data, _) =>
                                                        data.color,
                                                xValueMapper:
                                                    (ChartData data, _) =>
                                                        data.x,
                                                yValueMapper:
                                                    (ChartData data, _) =>
                                                        data.y,
                                                name: info.title,
                                                dataLabelSettings:
                                                    DataLabelSettings(
                                                        isVisible: true))
                                          ]),
                                      Text(
                                        info.title,
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            "Balance :",
                                            style: TextStyle(fontSize: 15),
                                          ),
                                          Text(info.balance.toString())
                                        ],
                                      ),
                                    ],
                                  )
                                : Text(
                                    "Please Select Leave Type",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  )),
                      )
                    ],
                  );
                },
              );
            },
          )),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, [this.color]);
  final String x;
  final double y;
  final Color color;
}
