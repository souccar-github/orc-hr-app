import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:orc_hr/Bloc/Project/bloc/loan_bloc.dart';
import 'package:orc_hr/Models/Project/LoanRequest.dart';
import 'package:orc_hr/Widgets/General/Animation/delayed_animation.dart';
import 'package:orc_hr/Widgets/General/TextFormField.dart';
import 'package:orc_hr/Localization/Localization.dart';
import 'package:sliding_sheet/sliding_sheet.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ApprovePage extends StatefulWidget {
  final LoanRequest loan;
  final LoanBloc bloc;
  const ApprovePage({required this.bloc, required this.loan});
  @override
  _ApprovePageState createState() => _ApprovePageState(this.loan);
}

class _ApprovePageState extends State<ApprovePage> {
  final LoanRequest loan;
  String? description;
  LoanBloc? bloc;
  DateFormat formatter = DateFormat('dd/MM/yyyy');
  TextEditingController? _totalAmountCountroller,
      _paymentCountController,
      _firstRepController,
      _secRepController;
  _ApprovePageState(this.loan);
  @override
  void initState() {
    super.initState();
    _totalAmountCountroller =
        new TextEditingController(text: loan.totalAmount.toString());
    _paymentCountController =
        new TextEditingController(text: loan.paymentsCount.toString());
    _firstRepController = new TextEditingController(
        text: loan.firstRepresentativeName.toString());
    _secRepController = new TextEditingController(
        text: loan.secondRepresentativeName.toString());
    bloc = new LoanBloc();
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
          Localization.of(context).getTranslatedValue("LoanApprove"),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      backgroundColor: Colors.white,
      body: BlocListener<LoanBloc, LoanState>(
        bloc: bloc,
        listener: (context, state) {
          if (state is AcceptLoanRequestSuccessfully) {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(
                Localization.of(context)
                    .getTranslatedValue("LoanAcceptedSuccessfully"),
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.green,
            ));
            if (widget.bloc != null) {
              widget.bloc.add(GetPendingLoanRequests());
            }
            Future.delayed(Duration(milliseconds: 1500),
                () => Navigator.of(context).pop());
          }
          if (state is PendingLoanRequestSuccessfully) {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(
                Localization.of(context)
                    .getTranslatedValue("LoanPendingSuccessfully"),
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.green,
            ));
            if (widget.bloc != null) {
              widget.bloc.add(GetPendingLoanRequests());
            }
            Future.delayed(Duration(milliseconds: 1500),
                () => Navigator.of(context).pop());
          }
          if (state is RejectLoanRequestSuccessfully) {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(
                Localization.of(context)
                    .getTranslatedValue("LoanRejectedSuccessfully"),
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.green,
            ));
            if (widget.bloc != null) {
              widget.bloc.add(GetPendingLoanRequests());
            }
            Future.delayed(Duration(milliseconds: 1500),
                () => Navigator.of(context).pop());
          }
          if (state is LoanError) {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(
                state.error,
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.red,
            ));
          }
        },
        child: BlocBuilder<LoanBloc, LoanState>(
            bloc: bloc,
            builder: (context, state) {
              if (state is LoanLoading) {
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
                                Text(Localization.of(context)
                                    .getTranslatedValue("RequestDate")),
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
                                      formatter.format(loan.requestDate),
                                      true,
                                      context),
                                ),
                              ]),
                              SizedBox(
                                height: 10,
                              ),
                              Row(children: <Widget>[
                                Text(Localization.of(context)
                                    .getTranslatedValue("EmployeeName")),
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
                                      loan.fullName,
                                      true,
                                      context),
                                ),
                              ]),
                              SizedBox(
                                height: 10,
                              ),
                              Row(children: <Widget>[
                                RichText(
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
                                SizedBox(
                                  width: 20,
                                ),
                                Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    child: TextFormField(
                                      onChanged: (_) {},
                                      controller: _totalAmountCountroller,
                                      readOnly: true,
                                      decoration: new InputDecoration(
                                        contentPadding: EdgeInsets.fromLTRB(
                                            20.0, 10.0, 20.0, 10.0),
                                        filled: true,
                                        fillColor: Colors.white,
                                        hintText: Localization.of(context)
                                            .getTranslatedValue(
                                                "DeservableAmount"),
                                        labelStyle: TextStyle(
                                            color: Color.fromRGBO(
                                                243, 119, 55, 1)),
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
                                RichText(
                                  text: TextSpan(
                                      text: Localization.of(context)
                                          .getTranslatedValue("PaymentsCount"),
                                      style: TextStyle(color: Colors.black),
                                      children: [
                                        TextSpan(
                                            text: '',
                                            style: TextStyle(color: Colors.red))
                                      ]),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    child: TextFormField(
                                      onChanged: (_) {},
                                      controller: _paymentCountController,
                                      readOnly: true,
                                      decoration: new InputDecoration(
                                        contentPadding: EdgeInsets.fromLTRB(
                                            20.0, 10.0, 20.0, 10.0),
                                        filled: true,
                                        fillColor: Colors.white,
                                        hintText: Localization.of(context)
                                            .getTranslatedValue(
                                                "PaymentsCount"),
                                        labelStyle: TextStyle(
                                            color: Color.fromRGBO(
                                                243, 119, 55, 1)),
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
                                RichText(
                                  text: TextSpan(
                                      text: Localization.of(context)
                                          .getTranslatedValue(
                                              "FirstRepresentative"),
                                      style: TextStyle(color: Colors.black),
                                      children: [
                                        TextSpan(
                                            text: '',
                                            style: TextStyle(color: Colors.red))
                                      ]),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    child: TextFormField(
                                      onChanged: (_) {},
                                      controller: _firstRepController,
                                      readOnly: true,
                                      decoration: new InputDecoration(
                                        contentPadding: EdgeInsets.fromLTRB(
                                            20.0, 10.0, 20.0, 10.0),
                                        filled: true,
                                        fillColor: Colors.white,
                                        hintText: Localization.of(context)
                                            .getTranslatedValue(
                                                "FirstRepresentative"),
                                        labelStyle: TextStyle(
                                            color: Color.fromRGBO(
                                                243, 119, 55, 1)),
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
                                RichText(
                                  text: TextSpan(
                                      text: Localization.of(context)
                                          .getTranslatedValue(
                                              "SecondRepresentative"),
                                      style: TextStyle(color: Colors.black),
                                      children: [
                                        TextSpan(
                                            text: '',
                                            style: TextStyle(color: Colors.red))
                                      ]),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    child: TextFormField(
                                      onChanged: (_) {},
                                      controller: _secRepController,
                                      readOnly: true,
                                      decoration: new InputDecoration(
                                        contentPadding: EdgeInsets.fromLTRB(
                                            20.0, 10.0, 20.0, 10.0),
                                        filled: true,
                                        fillColor: Colors.white,
                                        hintText: Localization.of(context)
                                            .getTranslatedValue(
                                                "SecondRepresentative"),
                                        labelStyle: TextStyle(
                                            color: Color.fromRGBO(
                                                243, 119, 55, 1)),
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
                                Text(Localization.of(context)
                                    .getTranslatedValue("Note")),
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
                                      loan.note,
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
                                            description = value;
                                          });
                                        },
                                            Localization.of(context)
                                                .getTranslatedValue(
                                                    "Typeanote"),
                                            false,
                                            TextInputType.multiline,
                                            false,
                                            5,
                                            loan.description ,
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
                                                    bloc!.add(AcceptLoanRequest(
                                                        loan.workflowItemId,
                                                        loan.requestId,
                                                        description!));
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
                                                    bloc!.add(RejectLoanRequest(
                                                        loan.workflowItemId,
                                                        loan.requestId,
                                                        description!));
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
                                                    bloc!.add(PendingLoanRequest(
                                                        loan.workflowItemId,
                                                        loan.requestId,
                                                        description!));
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
