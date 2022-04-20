import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orc_hr/Bloc/Project/bloc/loan_bloc.dart';
import 'package:orc_hr/Models/Project/DropdownItemModel.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:orc_hr/Models/Project/ListItem.dart';
import 'package:orc_hr/Models/Project/LoanRequest.dart';
import 'package:orc_hr/Localization/Localization.dart';
import 'package:orc_hr/Models/Project/MissionRequest.dart';
import 'package:orc_hr/Widgets/General/Drawer.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

import 'package:orc_hr/Widgets/General/Dropdown.dart';
import 'package:orc_hr/Widgets/General/TextFormField.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LoanRequestPage extends StatefulWidget {
  @override
  _LoanRequestState createState() => _LoanRequestState();
}

class _LoanRequestState extends State<LoanRequestPage> {
  double? totalAmount;
  int? paymentCount;
  LoanBloc? bloc;
  DropDownListItem? _selectedFirstRep, _selectedSecRep;
  List<DropdownMenuItem<DropDownListItem>> _firstRepDropdownMenuItems =
      [];
  List<DropdownMenuItem<DropDownListItem>> _secRepDropdownMenuItems =
      [];
  List<ListItem>? items;
  TextEditingController? _controller, _textController;
  String? requestDate, note;

  @override
  void initState() {
    super.initState();
    requestDate = DateTime.now().toString();
    _controller = new TextEditingController(text: "0");
    bloc = new LoanBloc();
    bloc!.add(GetLoanEmps());
  }

  onChangeTextField(String value) {
    setState(() {
      note = value;
    });
  }

  List<DropdownMenuItem<DropDownListItem>> buildDropdownMenuItems(
      List<ListItem> _items) {
    List<DropdownMenuItem<DropDownListItem>> items = [];
    for (ListItem item in _items) {
      var i = new DropDownListItem(item.id, item.name);
      items.add(
        DropdownMenuItem(
          value: i,
          child: Text(i.name),
        ),
      );
    }
    return items;
  }

  onChangeFirstRepsDropdownItem(DropDownListItem? selectedItem) {
    setState(() {
      _selectedFirstRep = selectedItem;
    });
  }

  onChangeSecRepsDropdownItem(DropDownListItem ?selectedItem) {
    setState(() {
      _selectedSecRep = selectedItem;
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
          Localization.of(context).getTranslatedValue("LoanRequest"),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      backgroundColor: Colors.white,
      body: BlocListener<LoanBloc, LoanState>(
          bloc: bloc,
          listener: (context, state) {
            if (state is LoanError) {
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text(
                  state.error,
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.red,
              ));
            }

            if (state is GetLoanEmpsSuccessfully) {
              setState(() {
                items = state.items;
                _firstRepDropdownMenuItems =
                    buildDropdownMenuItems(state.items);
                _secRepDropdownMenuItems = buildDropdownMenuItems(state.items);
              });
            }

            if (state is PostLoanRequestSuccessfully) {
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text(
                  Localization.of(context)
                      .getTranslatedValue("LoanRequestedSuccessfully"),
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.green,
              ));
              Future.delayed(Duration(milliseconds: 1000),
                  () => Navigator.of(context).pop());
            }
          },
          child: BlocBuilder<LoanBloc, LoanState>(
            bloc: bloc,
            builder: (context, state) {
              if (state is LoanLoading) {
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
                            Container(
                              width: 90,
                              child: RichText(
                                text: TextSpan(
                                    text: Localization.of(context)
                                        .getTranslatedValue("TotalAmount"),
                                    style: TextStyle(color: Colors.black),
                                    children: [
                                      TextSpan(
                                          text: '',
                                          style: TextStyle(color: Colors.red))
                                    ]),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Container(
                                width: MediaQuery.of(context).size.width / 2,
                                child: TextFormField(
                                  onChanged: (value) {
                                    totalAmount = double.parse(value);
                                  },
                                  decoration: new InputDecoration(
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.0, 10.0, 20.0, 10.0),
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: Localization.of(context)
                                        .getTranslatedValue("TotalAmount"),
                                    labelStyle: TextStyle(
                                        color: Color.fromRGBO(243, 119, 55, 1)),
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
                                    focusedErrorBorder: new OutlineInputBorder(
                                      borderRadius:
                                          new BorderRadius.circular(20.0),
                                      borderSide: new BorderSide(
                                          style: BorderStyle.solid,
                                          color: Colors.red[200]??Color(0x000000)),
                                    ),
                                    errorBorder: new OutlineInputBorder(
                                      borderRadius:
                                          new BorderRadius.circular(20.0),
                                      borderSide: new BorderSide(
                                          style: BorderStyle.solid,
                                          color: Colors.red[200]??Color(0x000000)),
                                    ),
                                    errorStyle: TextStyle(
                                      color: Colors.red[200]??Color(0x000000),
                                    ),
                                  ),
                                )),
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
                                        .getTranslatedValue("PaymentsCount"),
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
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: _controller,
                                  onChanged: (value) {
                                    setState(() {
                                      paymentCount = int.parse(value);
                                    });
                                  },
                                  decoration: new InputDecoration(
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.0, 10.0, 20.0, 10.0),
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: Localization.of(context)
                                        .getTranslatedValue("PaymentsCount"),
                                    labelStyle: TextStyle(
                                        color: Color.fromRGBO(243, 119, 55, 1)),
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
                                    focusedErrorBorder: new OutlineInputBorder(
                                      borderRadius:
                                          new BorderRadius.circular(20.0),
                                      borderSide: new BorderSide(
                                          style: BorderStyle.solid,
                                          color: Colors.red[200]??Color(0x000000)),
                                    ),
                                    errorBorder: new OutlineInputBorder(
                                      borderRadius:
                                          new BorderRadius.circular(20.0),
                                      borderSide: new BorderSide(
                                          style: BorderStyle.solid,
                                          color: Colors.red[200]??Color(0x000000)),
                                    ),
                                    errorStyle: TextStyle(
                                      color: Colors.red[200]??Color(0x000000),
                                    ),
                                  ),
                                )),
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
                                        .getTranslatedValue(
                                            "FirstRepresentative"),
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
                                _selectedFirstRep,
                                Localization.of(context)
                                    .getTranslatedValue("FirstRepresentative"),
                                _firstRepDropdownMenuItems,
                                onChangeFirstRepsDropdownItem),
                          ]),
                          SizedBox(
                            height: 10,
                          ),
                          Row(children: <Widget>[
                            Container(
                              width: 90,
                              child: RichText(
                                textWidthBasis: TextWidthBasis.parent,
                                text: TextSpan(
                                    text: Localization.of(context)
                                        .getTranslatedValue(
                                            "SecondRepresentative"),
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
                                _selectedSecRep,
                                Localization.of(context)
                                    .getTranslatedValue("SecondRepresentative"),
                                _secRepDropdownMenuItems,
                                onChangeSecRepsDropdownItem),
                          ]),
                          SizedBox(
                            height: 10,
                          ),
                          Row(children: <Widget>[
                            Container(
                              width: 90,
                              child: Text(Localization.of(context)
                                  .getTranslatedValue("Note")),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 2,
                              child: textFormField(
                                  onChangeTextField,
                                  Localization.of(context)
                                      .getTranslatedValue("TypeANote"),
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
                                  var model = new LoanRequest(
                                      0,
                                      "",
                                      0,
                                      totalAmount!,
                                      0,
                                      0,
                                      0,
                                      "",
                                      new DateTime.now(),
                                      0,
                                      _selectedFirstRep?.id??0,
                                      _selectedSecRep?.id??0,
                                      note ?? "",
                                      "",
                                      _selectedFirstRep?.name??"",
                                      _selectedSecRep?.name??"",
                                      paymentCount!);
                                  bloc!.add(PostLoanRequest(model));
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
