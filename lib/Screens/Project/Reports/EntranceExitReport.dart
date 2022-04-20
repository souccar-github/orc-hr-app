import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orc_hr/Bloc/Project/bloc/entranceexit_bloc.dart';
import 'package:orc_hr/Localization/Localization.dart';
import 'package:orc_hr/Models/Project/EntranceExitRequest.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/src/theme/datagrid_theme.dart';

class EntranceExitReport extends StatefulWidget {
  @override
  State<EntranceExitReport> createState() => _EntranceExitReportState();
}

class _EntranceExitReportState extends State<EntranceExitReport> {
  EntranceexitBloc? bloc;
  List<EntranceExitRequest> items = [];
  late EntranceExitDataSource entranceExitDataSource;
  late DateTime fromDate, toDate;
  @override
  void initState() {
    super.initState();
    entranceExitDataSource = EntranceExitDataSource(entranceExitData: items);
    fromDate = DateTime.now();
    toDate = DateTime.now();
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
            Localization.of(context).getTranslatedValue("EntranceExitReport"),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        backgroundColor: Colors.white,
        body: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Row(children: <Widget>[
                Container(
                  width: 90,
                  child: RichText(
                    text: TextSpan(
                        text: Localization.of(context)
                            .getTranslatedValue("FromDate"),
                        style: TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                              text: ' *', style: TextStyle(color: Colors.red))
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
                    initialValue: fromDate.toString(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    icon: Icon(Icons.event),
                    dateLabelText:
                        Localization.of(context).getTranslatedValue("Date"),
                    onChanged: (val) {
                      setState(() {
                        fromDate = DateTime.parse(val);
                      });
                    },
                  ),
                ),
              ]),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Row(children: <Widget>[
                Container(
                  width: 90,
                  child: RichText(
                    text: TextSpan(
                        text: Localization.of(context)
                            .getTranslatedValue("ToDate"),
                        style: TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                              text: ' *', style: TextStyle(color: Colors.red))
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
                    initialValue: toDate.toString(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    icon: Icon(Icons.event),
                    dateLabelText:
                        Localization.of(context).getTranslatedValue("Date"),
                    onChanged: (val) {
                      setState(() {
                        toDate = DateTime.parse(val);
                      });
                    },
                  ),
                ),
              ]),
            ),
            SizedBox(
              height: 10,
            ),
            ButtonTheme(
                minWidth: 100.0,
                height: 50.0,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(15.0),
                      side: BorderSide(color: Colors.white)),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  color: Color.fromRGBO(243, 119, 55, 1),
                  child: Text(
                    Localization.of(context).getTranslatedValue("Apply"),
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  onPressed: () {
                    bloc!.add(GetEntranceExitReport(fromDate, toDate));
                  },
                )),
            SizedBox(
              height: 10,
            ),
            BlocListener<EntranceexitBloc, EntranceexitState>(
              bloc: bloc,
              listener: (context, state) {
                if (state is EntranceExitError) {
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text(
                      state.error,
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.red,
                  ));
                }
                if (state is GetEntranceExitReportSuccessfully) {
                  setState(() {
                    items = state.items;
                    entranceExitDataSource =
                        EntranceExitDataSource(entranceExitData: items);
                  });
                }
              },
              child: BlocBuilder<EntranceexitBloc, EntranceexitState>(
                bloc: bloc,
                builder: (context, state) {
                  if (state is EntranceExitLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is GetEntranceExitReportSuccessfully) {
                    Timer(Duration(milliseconds: 500), () {});
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height - 300,
                      child: SfDataGrid(
                        source: entranceExitDataSource,
                        columns: <GridColumn>[
                          GridColumn(
                              width: MediaQuery.of(context).size.width /4,
                              columnName: 'logTypeString',
                              label: Container(
                                  padding: EdgeInsets.all(16.0),
                                  alignment: Alignment.center,
                                  child: AutoSizeText(
                                    Localization.of(context)
                                        .getTranslatedValue("LogType"),maxLines: 1,
                                  ))),
                          GridColumn(
                              width: MediaQuery.of(context).size.width / 3.5,
                              columnName: 'recordDate',
                              label: Container(
                                  padding: EdgeInsets.all(16.0),
                                  alignment: Alignment.center,
                                  child: AutoSizeText(Localization.of(context)
                                      .getTranslatedValue("RecordDate"),maxLines: 1,))),
                          GridColumn(
                              width: MediaQuery.of(context).size.width / 3.5,
                              columnName: 'recordTime',
                              label: Container(
                                  padding: EdgeInsets.all(16.0),
                                  alignment: Alignment.center,
                                  child: AutoSizeText(Localization.of(context)
                                      .getTranslatedValue("RecordTime"),maxLines: 1,))),
                          GridColumn(
                              width: MediaQuery.of(context).size.width / 9,
                              columnName: 'logTypeIcon',
                              label: Container(
                                  padding: EdgeInsets.all(16.0),
                                  alignment: Alignment.center,
                                  child: Text(Localization.of(context)
                                      .getTranslatedValue("")))),
                        ],
                      ),
                    );
                  }
                  return Container();
                },
              ),
            )
          ],
        ));
  }
}

class EntranceExitDataSource extends DataGridSource {
  EntranceExitDataSource(
      {required List<EntranceExitRequest> entranceExitData}) {
    _entranceExitData = entranceExitData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(
                  columnName: 'logTypeString', value: e.logTypeString),
              DataGridCell<String>(
                  columnName: 'recordDate',
                  value: e.recordDate.day.toString() +
                      " / " +
                      e.recordDate.month.toString() +
                      " / " +
                      e.recordDate.year.toString()),
              DataGridCell<Widget>(
                  columnName: 'recordTime',
                  value:AutoSizeText( e.recordDate.hour.toString() +
                      " : " +
                      e.recordDate.minute.toString(),textDirection: TextDirection.ltr,)),
              DataGridCell<Widget>(
                  columnName: 'logTypeIcon',
                  value: e.logType == 0
                      ? Image.asset('lib/assets/up.png')
                      : Image.asset('lib/assets/down.png')),
            ]))
        .toList();
  }

  List<DataGridRow> _entranceExitData = [];

  @override
  List<DataGridRow> get rows => _entranceExitData;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      return Container(
        padding: EdgeInsets.all(5.0),
        alignment: Alignment.center,
        child:dataGridCell.columnName == "logTypeIcon"||dataGridCell.columnName == "recordTime"?dataGridCell.value: AutoSizeText(
          dataGridCell.value.toString(),
        ),
      );
    }).toList());
  }
}
