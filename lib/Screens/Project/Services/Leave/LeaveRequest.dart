import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orc_hr/Models/Project/DropdownItemModel.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:orc_hr/Models/Project/LeaveRequest.dart';
import 'package:orc_hr/Localization/Localization.dart';
import 'package:orc_hr/Models/Project/LeaveSetting.dart';
import 'package:orc_hr/Models/Project/LeaveReason.dart';
import 'package:orc_hr/Models/Project/LeaveInfoModel.dart';
import 'package:orc_hr/SharedPref/SharedPref.dart';
import 'package:orc_hr/Widgets/General/Drawer.dart';
import 'package:orc_hr/Bloc/Project/bloc/leave_bloc.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

import 'package:orc_hr/Widgets/General/Dropdown.dart';
import 'package:orc_hr/Widgets/General/TextFormField.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LeaveRequestPage extends StatefulWidget {
  int id;
  LeaveBloc? bloc;
  LeaveRequestPage(this.id, this.bloc);
  @override
  _LeaveRequestState createState() => _LeaveRequestState(this.id);
}

class _LeaveRequestState extends State<LeaveRequestPage> {
  int? id;
  double? duration;
  bool? isDivisibleToHours;
  String? locale;

  bool? isIndivisible;
  DropDownListItem? _selectedSetting;
  DropDownListItem? _selectedReason;
  LeaveBloc? bloc;
  List<ChartData>? chartData;
  TextEditingController _controller = new TextEditingController();
  TextEditingController? _textController;
  String? requestDate, startDate, endDate, fromTime, toTime, note;
  bool? hourly;
  List<DropdownMenuItem<DropDownListItem>> _dropdownMenuItems = [];
  List<DropdownMenuItem<DropDownListItem>> _reasonsDropdownMenuItems = [];
  List<LeaveSetting> settings = [];
  List<LeaveReason> reasons = [];
  LeaveInfoModel? info;

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
    bloc!.add(GetLeaveSettings());
    bloc!.add(GetLeaveReasons());
    if (id != null && id != 0) {
      bloc!.add(GetLeaveSettingInfo(id!, DateTime.now()));
    }
    var model = new LeaveRequest(
        "",
        0,
        DateTime.parse(endDate!.substring(0, 10)),
        DateTime.parse(startDate!.substring(0, 10)),
        fromTime! == null ? new DateTime.now() : DateTime.parse(fromTime!),
        "",
        hourly!,
        false,
        0,
        "",
        0,
        _selectedSetting?.id ?? 0,
        "",
        0,
        0,
        "",
        DateTime.parse(requestDate!),
        0,
        DateTime.parse(startDate!.substring(0, 10)),
        DateTime.parse(endDate!.substring(0, 10)),
        toTime! == null ? new DateTime.now() : DateTime.parse(toTime!),
        0,
        "");
    bloc!.add(GetSpentDays(model));
  }

  List<DropdownMenuItem<DropDownListItem>> buildDropdownMenuItems(
      List<LeaveSetting> _items) {
    List<DropdownMenuItem<DropDownListItem>> items = [];
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
    List<DropdownMenuItem<DropDownListItem>> items = [];
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

  onChangeDropdownItem(DropDownListItem? selectedItem) {
    setState(() {
      _selectedSetting = selectedItem;
    });
    bloc!.add(GetLeaveSettingInfo(selectedItem?.id ?? 0, DateTime.now()));
    var model = new LeaveRequest(
        "",
        0,
        DateTime.parse(endDate!.substring(0, 10)),
        DateTime.parse(startDate!.substring(0, 10)),
        fromTime! == null ? new DateTime.now() : DateTime.parse(fromTime!),
        "",
        hourly!,
        false,
        0,
        "",
        0,
        _selectedSetting?.id ?? 0,
        "",
        0,
        0,
        "",
        DateTime.parse(requestDate!),
        0,
        DateTime.parse(startDate!.substring(0, 10)),
        DateTime.parse(endDate!.substring(0, 10)),
        toTime! == null ? new DateTime.now() : DateTime.parse(toTime!),
        0,
        "");
    bloc!.add(GetSpentDays(model));
  }

  onChangeReasonsDropdownItem(DropDownListItem? selectedItem) {
    setState(() {
      _selectedReason = selectedItem;
    });
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(milliseconds: 0), () async {
      String? _locale = await SharedPref.pref.getLocale();
      setState(() {
        locale = _locale;
      });
    });
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          Localization.of(context).getTranslatedValue("LeaveRequest"),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      backgroundColor: Colors.white,
      body: BlocListener<LeaveBloc, LeaveState>(
          bloc: bloc!,
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
                    .firstWhere((i) => i.value?.id == state.info.id)
                    .value!;
                if (info!.isDivisibleToHours != null) {
                  isDivisibleToHours = info!.isDivisibleToHours;
                }
                if (info!.isIndivisible != null) {
                  isIndivisible = info!.isIndivisible;
                }
                var model = new LeaveRequest(
                    "",
                    0,
                    DateTime.parse(endDate!.substring(0, 10)),
                    DateTime.parse(startDate!.substring(0, 10)),
                    fromTime! == null
                        ? new DateTime.now()
                        : DateTime.parse(fromTime!),
                    "",
                    hourly!,
                    false,
                    0,
                    "",
                    0,
                    _selectedSetting?.id ?? 0,
                    "",
                    0,
                    0,
                    "",
                    DateTime.parse(requestDate!),
                    0,
                    DateTime.parse(startDate!.substring(0, 10)),
                    DateTime.parse(endDate!.substring(0, 10)),
                    toTime! == null
                        ? new DateTime.now()
                        : DateTime.parse(toTime!),
                    0,
                    "");
                bloc!.add(GetSpentDays(model));
                chartData = [
                  ChartData(
                      Localization.of(context).getTranslatedValue("Granted"),
                      state.info.granted,
                      Colors.red),
                  ChartData(
                      Localization.of(context).getTranslatedValue("Remain"),
                      state.info.remain,
                      Colors.green)
                ];
              });
            }
            if (state is PostLeaveRequestSuccessfully) {
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text(
                  Localization.of(context)
                      .getTranslatedValue("LeaveRequestedSuccessfully"),
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.green,
              ));
              Future.delayed(Duration(milliseconds: 1000), () {
                if (widget.bloc != null) {
                  widget.bloc!.add(InitMainLeavesBalancePage());
                }
                Navigator.of(context).pop();
              });
            }
            if (state is GetSpentDaysSuccessfully) {
              setState(() {
                _textController!.text = state.days.toString();
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
            bloc: bloc,
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
                              Container(
                                width: 90,
                                child: RichText(
                                  text: TextSpan(
                                      text: Localization.of(context)
                                          .getTranslatedValue("LeaveType"),
                                      style: TextStyle(color: Colors.black),
                                      children: [
                                        TextSpan(
                                            text: ' *',
                                            style: TextStyle(color: Colors.red))
                                      ]),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              dropdown(
                                  context,
                                  _selectedSetting,
                                  Localization.of(context)
                                      .getTranslatedValue("LeaveType"),
                                  _dropdownMenuItems,
                                  onChangeDropdownItem),
                            ]),
                            SizedBox(
                              height: 10,
                            ),
                            Row(children: <Widget>[
                              Container(
                                width: 90,
                                child: RichText(
                                  text: TextSpan(
                                      text: Localization.of(context)
                                          .getTranslatedValue("RequestDate"),
                                      style: TextStyle(color: Colors.black),
                                      children: [
                                        TextSpan(
                                            text: ' *',
                                            style: TextStyle(color: Colors.red))
                                      ]),
                                ),
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
                                  dateLabelText: Localization.of(context)
                                      .getTranslatedValue("Date"),
                                  onChanged: (val) {
                                    setState(() {
                                      requestDate = val;
                                    });
                                  },
                                ),
                              ),
                            ]),
                            SizedBox(
                              height: 10,
                            ),
                            Row(children: <Widget>[
                              Container(
                                width: 90,
                                child: RichText(
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
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 2,
                                child: DateTimePicker(
                                  type: DateTimePickerType.date,
                                  dateMask: 'dd MMM, yyyy',
                                  initialValue: startDate!,
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2100),
                                  icon: Icon(Icons.event),
                                  dateLabelText: Localization.of(context)
                                      .getTranslatedValue("Date"),
                                  onChanged: (val) {
                                    setState(() {
                                      startDate = val + " 00:00:00";
                                      var model = new LeaveRequest(
                                          "",
                                          0,
                                          DateTime.parse(
                                              endDate!.substring(0, 10)),
                                          DateTime.parse(
                                              startDate!.substring(0, 10)),
                                          fromTime! == null
                                              ? new DateTime.now()
                                              : fromTime! == null
                                                  ? new DateTime.now()
                                                  : DateTime.parse(fromTime!),
                                          "",
                                          hourly!,
                                          false,
                                          0,
                                          "",
                                          0,
                                          _selectedSetting?.id ?? 0,
                                          "",
                                          0,
                                          0,
                                          "",
                                          DateTime.parse(requestDate!),
                                          0,
                                          DateTime.parse(
                                              startDate!.substring(0, 10)),
                                          DateTime.parse(
                                              endDate!.substring(0, 10)),
                                          toTime! == null
                                              ? new DateTime.now()
                                              : DateTime.parse(toTime!),
                                          0,
                                          "");
                                      bloc!.add(GetSpentDays(model));
                                    });
                                  },
                                ),
                              ),
                            ]),
                            SizedBox(
                              height: 10,
                            ),
                            !isIndivisible!
                                ? Row(children: <Widget>[
                                    Container(
                                      width: 90,
                                      child: RichText(
                                        text: TextSpan(
                                            text: Localization.of(context)
                                                .getTranslatedValue("EndDate"),
                                            style:
                                                TextStyle(color: Colors.black),
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
                                          MediaQuery.of(context).size.width / 2,
                                      child: DateTimePicker(
                                        readOnly: hourly!,
                                        initialValue: endDate!,
                                        enabled: !hourly!,
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
                                                    endDate!.substring(0, 10)),
                                                DateTime.parse(startDate!
                                                    .substring(0, 10)),
                                                fromTime! == null
                                                    ? new DateTime.now()
                                                    : DateTime.parse(fromTime!),
                                                "",
                                                hourly!,
                                                false,
                                                0,
                                                "",
                                                0,
                                                _selectedSetting?.id ?? 0,
                                                "",
                                                0,
                                                0,
                                                "",
                                                DateTime.parse(requestDate!),
                                                0,
                                                DateTime.parse(startDate!
                                                    .substring(0, 10)),
                                                DateTime.parse(
                                                    endDate!.substring(0, 10)),
                                                toTime! == null
                                                    ? new DateTime.now()
                                                    : DateTime.parse(toTime!),
                                                0,
                                                "");
                                            bloc!.add(GetSpentDays(model));
                                          });
                                        },
                                      ),
                                    ),
                                  ])
                                : Container(),
                            SizedBox(
                              height: !isIndivisible! ? 10 : 0,
                            ),
                            (isDivisibleToHours! && !isIndivisible!)
                                ? Row(children: <Widget>[
                                    Container(
                                      width: 90,
                                      child: Text(Localization.of(context)
                                          .getTranslatedValue("HourlyLeave")),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Checkbox(
                                      value: hourly!,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          hourly = value ?? false;
                                          endDate = startDate!;
                                          _controller.text = DateTime.parse(
                                                  endDate!.substring(0, 10))
                                              .toIso8601String();
                                          if (!hourly!) {
                                            fromTime =
                                                DateTime.now().toString();

                                            toTime = DateTime.now().toString();
                                          }
                                          var model = new LeaveRequest(
                                              "",
                                              0,
                                              DateTime.parse(
                                                  endDate!.substring(0, 10)),
                                              DateTime.parse(
                                                  startDate!.substring(0, 10)),
                                              fromTime! == null
                                                  ? new DateTime.now()
                                                  : DateTime.parse(fromTime!),
                                              "",
                                              hourly!,
                                              false,
                                              0,
                                              "",
                                              0,
                                              _selectedSetting?.id ?? 0,
                                              "",
                                              0,
                                              0,
                                              "",
                                              DateTime.parse(requestDate!),
                                              0,
                                              DateTime.parse(
                                                  startDate!.substring(0, 10)),
                                              DateTime.parse(
                                                  endDate!.substring(0, 10)),
                                              toTime! == null
                                                  ? new DateTime.now()
                                                  : DateTime.parse(toTime!),
                                              0,
                                              "");
                                          bloc!.add(GetSpentDays(model));
                                        });
                                      },
                                    ),
                                  ])
                                : Container(),
                            hourly!
                                ? Row(children: <Widget>[
                                    Container(
                                      width: 90,
                                      child: RichText(
                                        text: TextSpan(
                                            text: Localization.of(context)
                                                .getTranslatedValue(
                                                    "FromTime"),
                                            style:
                                                TextStyle(color: Colors.black),
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
                                      width: MediaQuery.of(context).size.width /
                                          2.2,
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
                                                startDate!.substring(0, 11) +
                                                    val;
                                            var model = new LeaveRequest(
                                                "",
                                                0,
                                                DateTime.parse(
                                                    endDate!.substring(0, 10)),
                                                DateTime.parse(startDate!
                                                    .substring(0, 10)),
                                                fromTime! == null
                                                    ? new DateTime.now()
                                                    : DateTime.parse(fromTime!),
                                                "",
                                                hourly!,
                                                false,
                                                0,
                                                "",
                                                0,
                                                _selectedSetting?.id ?? 0,
                                                "",
                                                0,
                                                0,
                                                "",
                                                DateTime.parse(requestDate!),
                                                0,
                                                DateTime.parse(startDate!
                                                    .substring(0, 10)),
                                                DateTime.parse(
                                                    endDate!.substring(0, 10)),
                                                toTime! == null
                                                    ? new DateTime.now()
                                                    : DateTime.parse(toTime!),
                                                0,
                                                "");
                                            bloc!.add(GetSpentDays(model));
                                          });
                                        },
                                      ),
                                    ),
                                  ])
                                : Container(),
                            hourly!
                                ? Row(children: <Widget>[
                                    Container(
                                      width: 90,
                                      child: RichText(
                                        text: TextSpan(
                                            text: Localization.of(context)
                                                .getTranslatedValue("ToTime"),
                                            style:
                                                TextStyle(color: Colors.black),
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
                                      width: MediaQuery.of(context).size.width /
                                          2.2,
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
                                                startDate!.substring(0, 11) +
                                                    val;
                                            var model = new LeaveRequest(
                                                "",
                                                0,
                                                DateTime.parse(
                                                    endDate!.substring(0, 10)),
                                                DateTime.parse(startDate!
                                                    .substring(0, 10)),
                                                fromTime! == null
                                                    ? new DateTime.now()
                                                    : DateTime.parse(fromTime!),
                                                "",
                                                hourly!,
                                                false,
                                                0,
                                                "",
                                                0,
                                                _selectedSetting?.id ?? 0,
                                                "",
                                                0,
                                                0,
                                                "",
                                                DateTime.parse(requestDate!),
                                                0,
                                                DateTime.parse(startDate!
                                                    .substring(0, 10)),
                                                DateTime.parse(
                                                    endDate!.substring(0, 10)),
                                                toTime! == null
                                                    ? new DateTime.now()
                                                    : DateTime.parse(toTime!),
                                                0,
                                                "");
                                            bloc!.add(GetSpentDays(model));
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
                              Container(
                                width: 90,
                                child: Text(Localization.of(context)
                                    .getTranslatedValue("Duration")),
                              ),
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
                                      hintText: Localization.of(context)
                                          .getTranslatedValue("Duration"),
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
                                            color: Colors.red[200] ??
                                                Color(0x000000)),
                                      ),
                                      errorBorder: new OutlineInputBorder(
                                        borderRadius:
                                            new BorderRadius.circular(20.0),
                                        borderSide: new BorderSide(
                                            style: BorderStyle.solid,
                                            color: Colors.red[200] ??
                                                Color(0x000000)),
                                      ),
                                      errorStyle: TextStyle(
                                        color:
                                            Colors.red[200] ?? Color(0x000000),
                                      ),
                                    ),
                                  )),
                              SizedBox(
                                width: 10,
                              ),
                              BlocBuilder<LeaveBloc, LeaveState>(
                                bloc: bloc!,
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
                              Container(
                                width: 90,
                                child: RichText(
                                  text: TextSpan(
                                      text: Localization.of(context)
                                          .getTranslatedValue("LeaveReason"),
                                      style: TextStyle(color: Colors.black),
                                      children: [
                                        TextSpan(
                                            text: ' *',
                                            style: TextStyle(color: Colors.red))
                                      ]),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              dropdown(
                                  context,
                                  _selectedReason,
                                  Localization.of(context)
                                      .getTranslatedValue("LeaveReason"),
                                  _reasonsDropdownMenuItems,
                                  onChangeReasonsDropdownItem),
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
                                    var model = new LeaveRequest(
                                        note??"",
                                        0,
                                        DateTime.parse(
                                            endDate!.substring(0, 10)),
                                        DateTime.parse(
                                            startDate!.substring(0, 10)),
                                        fromTime! == null
                                            ? new DateTime.now()
                                            : DateTime.parse(fromTime!),
                                        "",
                                        hourly!,
                                        false,
                                        0,
                                        _selectedReason?.name ?? "",
                                        _selectedReason?.id ?? 0,
                                        _selectedSetting?.id ?? 0,
                                        _selectedSetting?.name ?? "",
                                        0,
                                        0,
                                        "",
                                        DateTime.parse(requestDate!),
                                        double.parse(_textController!.text),
                                        DateTime.parse(
                                            startDate!.substring(0, 10)),
                                        DateTime.parse(
                                            endDate!.substring(0, 10)),
                                        toTime == null
                                            ? new DateTime.now()
                                            : DateTime.parse(toTime!),
                                        0,
                                        "");
                                    bloc!.add(PostLeaveRequest(
                                        model, info!, duration!));
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
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            width: MediaQuery.of(context).size.width,
                                            child: Column(children: <Widget>[
                                              SfCircularChart(
                                                legend: Legend(
                                                    overflowMode:
                                                        LegendItemOverflowMode
                                                            .wrap,
                                                    isVisible: false,
                                                    position:
                                                        LegendPosition.bottom),
                                                series: <CircularSeries>[
                                                  DoughnutSeries<ChartData,
                                                          String>(
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
                                                      name: info!.title,
                                                      dataLabelSettings:
                                                          DataLabelSettings(
                                                              isVisible: true))
                                                ],
                                              ),
                                            ]),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        info!.title,
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            Localization.of(context)
                                                .getTranslatedValue("Balanc:"),
                                            style: TextStyle(fontSize: 15),
                                          ),
                                          Text(info!.balance.toString())
                                        ],
                                      ),
                                    ],
                                  )
                                : Text(
                                    Localization.of(context).getTranslatedValue(
                                        "PleaseSelectLeaveType"),
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
  ChartData(this.x, this.y, this.color);
  final String x;
  final double y;
  final Color color;
}
