import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orc_hr/Bloc/Project/bloc/entranceexit_bloc.dart';
import 'package:orc_hr/Bloc/Project/bloc/leave_bloc.dart';
import 'package:orc_hr/Localization/Localization.dart';
import 'package:orc_hr/Models/Project/DropdownItemModel.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:orc_hr/Models/Project/EntranceExitRequest.dart';
import 'package:orc_hr/Widgets/General/Drawer.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

import 'package:orc_hr/Widgets/General/Dropdown.dart';
import 'package:orc_hr/Widgets/General/TextFormField.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class EntranceExitRequestPage extends StatefulWidget {
  EntranceExitRequestPage();
  @override
  _EntranceExitRequestState createState() => _EntranceExitRequestState();
}

class _EntranceExitRequestState extends State<EntranceExitRequestPage> {
  EntranceexitBloc bloc;
  TextEditingController _controller;
  String recordDateTime, note;
  int _selectedType;
  int recordType;
  List<DropdownMenuItem<int>> _dropdownMenuItems =
      new List<DropdownMenuItem<int>>();

  _EntranceExitRequestState();
  @override
  void initState() {
    super.initState();
    recordDateTime = DateTime.now().toString();
    _controller = new TextEditingController(text: DateTime.now().toString());
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

    bloc = new EntranceexitBloc();
  }

  onChangeTextField(String value) {
    setState(() {
      note = value;
    });
  }

  onChangeDropdownItem(int selectedItem) {
    setState(() {
      _selectedType = selectedItem;
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
          Localization.of(context).getTranslatedValue("EntranceExitRequest"),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      backgroundColor: Colors.white,
      body: BlocListener<EntranceexitBloc, EntranceexitState>(
          cubit: bloc,
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
            if (state is PostEntranceExitRequestSuccessfully) {
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text(
                  Localization.of(context).getTranslatedValue("EntranceExitRequestedSuccessfully"),
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.green,
              ));
              Future.delayed(Duration(milliseconds: 1000),
                  () => Navigator.of(context).pop());
            }
          },
          child: BlocBuilder<EntranceexitBloc, EntranceexitState>(
            cubit: bloc,
            builder: (context, state) {
              if (state is EntranceExitLoading) {
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
                                  text: Localization.of(context).getTranslatedValue("RecordDate"),
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
                                initialValue: DateTime.now().toString(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2100),
                                icon: Icon(Icons.event),
                                dateLabelText: Localization.of(context).getTranslatedValue("Date"),
                                onChanged: (val) {
                                  recordDateTime = val;
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
                                  text: Localization.of(context).getTranslatedValue("RecordType"),
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
                            DropdownButton(
                              underline: Container(
                                width: MediaQuery.of(context).size.width - 60,
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(243, 119, 55, 1),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromRGBO(243, 119, 55, 1),
                                      blurRadius: 20.0,
                                    ),
                                    BoxShadow(
                                      color: Color.fromRGBO(243, 119, 55, 1),
                                      blurRadius: 20.0,
                                    ),
                                  ],
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Color.fromRGBO(243, 119, 55, 1),
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                              ),
                              hint: Text(
                                Localization.of(context).getTranslatedValue("RecordType"),
                                style: TextStyle(fontSize: 16),
                              ), // Not necessary for Option 1
                              value: _selectedType,
                              onChanged: onChangeDropdownItem,
                              items: _dropdownMenuItems,
                            ),
                          ]),
                          SizedBox(
                            height: 10,
                          ),
                          Row(children: <Widget>[
                            Text(Localization.of(context).getTranslatedValue("Note")),
                            SizedBox(
                              width: 20,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 2,
                              child: textFormField(
                                  onChangeTextField,
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
                                  Localization.of(context).getTranslatedValue("Apply"),
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                                onPressed: () {
                                  var model = new EntranceExitRequest(
                                      "",
                                      0,
                                      DateTime.parse(recordDateTime),
                                      _selectedType,
                                      note??"",
                                      "",
                                      0);
                                  bloc.add(PostEntranceExitRequest(model));
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
