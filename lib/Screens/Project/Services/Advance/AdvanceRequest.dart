import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orc_hr/Bloc/Project/bloc/advance_bloc.dart';
import 'package:orc_hr/Models/Project/DropdownItemModel.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:orc_hr/Models/Project/AdvanceRequest.dart';
import 'package:orc_hr/Localization/Localization.dart';
import 'package:orc_hr/Models/Project/MissionRequest.dart';
import 'package:orc_hr/Widgets/General/Drawer.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

import 'package:orc_hr/Widgets/General/Dropdown.dart';
import 'package:orc_hr/Widgets/General/TextFormField.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AdvanceRequestPage extends StatefulWidget {
  @override
  _AdvanceRequestState createState() => _AdvanceRequestState();
}

class _AdvanceRequestState extends State<AdvanceRequestPage> {
  double? amount, desAmount;
  AdvanceBloc? bloc;
  TextEditingController? _controller, _textController;
  String? operationDate, note;

  @override
  void initState() {
    super.initState();
    operationDate = DateTime.now().toString();
    _controller = new TextEditingController(text: "0");
    bloc = new AdvanceBloc();
    bloc!.add(GetDesAmount());
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
          Localization.of(context).getTranslatedValue("AdvanceRequest"),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      backgroundColor: Colors.white,
      body: BlocListener<AdvanceBloc, AdvanceState>(
          bloc: bloc,
          listener: (context, state) {
            if (state is AdvanceError) {
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text(
                  state.error,
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.red,
              ));
            }

            if (state is GetDesAmountSuccessfully) {
              setState(() {
                desAmount = state.desAmount;
                _textController =
                    new TextEditingController(text: desAmount.toString());
              });
            }

            if (state is PostAdvanceRequestSuccessfully) {
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text(
                  Localization.of(context)
                      .getTranslatedValue("AdvanceRequestedSuccessfully"),
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.green,
              ));
              Future.delayed(Duration(milliseconds: 1000),
                  () => Navigator.of(context).pop());
            }
          },
          child: BlocBuilder<AdvanceBloc, AdvanceState>(
            bloc: bloc,
            builder: (context, state) {
              if (state is AdvanceLoading) {
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
                                        .getTranslatedValue("DeservableAmount"),
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
                                  controller: _textController,
                                  onChanged: (_) {},
                                  readOnly: true,
                                  decoration: new InputDecoration(
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.0, 10.0, 20.0, 10.0),
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: Localization.of(context)
                                        .getTranslatedValue("DeservableAmount"),
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
                                        .getTranslatedValue("Amount"),
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
                                      amount = double.parse(value);
                                    });
                                  },
                                  decoration: new InputDecoration(
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.0, 10.0, 20.0, 10.0),
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: Localization.of(context)
                                        .getTranslatedValue("Amount"),
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
                                  var model = new AdvanceRequest(
                                      0,
                                      "",
                                      0,
                                      amount!,
                                      desAmount!,
                                      0,
                                      0,
                                      "",
                                      new DateTime.now(),
                                      0,
                                      0,
                                      note ?? "",
                                      "");
                                  bloc!.add(PostAdvanceRequest(model));
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
