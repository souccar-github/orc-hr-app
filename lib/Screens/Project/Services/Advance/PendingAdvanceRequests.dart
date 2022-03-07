import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orc_hr/Localization/Localization.dart';
import 'package:orc_hr/Bloc/Project/bloc/advance_bloc.dart';
import 'package:orc_hr/Screens/Project/Services/Advance/ApprovePage.dart';
import 'package:orc_hr/Widgets/General/Animation/delayed_animation.dart';

import '../../Notifications.dart';

class PendingAdvances extends StatefulWidget {
  @override
  _PendingAdvancesState createState() => _PendingAdvancesState();
}

class _PendingAdvancesState extends State<PendingAdvances> {
  AdvanceBloc bloc;
  @override
  void initState() {
    super.initState();
    bloc = new AdvanceBloc();
    bloc.add(GetPendingAdvanceRequests());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.notifications,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => NotificationPage()),
              );
            },
          )
        ],
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          Localization.of(context).getTranslatedValue("PendingAdvanceRequests"),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      backgroundColor: Colors.white,
      body: BlocListener<AdvanceBloc, AdvanceState>(
        cubit: bloc,
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
        },
        child: BlocBuilder<AdvanceBloc, AdvanceState>(
          cubit: bloc,
          builder: (context, state) {
            if (state is AdvanceLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is GetPendingAdvanceRequestsSuccessfully) {
              if (state.items.length == 0){
                return Container(
                  child: Center(
                    child: Text(
                        Localization.of(context).getTranslatedValue("ThereAreNoItemsToShow")),
                  ),
                );
              }
              return Padding(
                padding: EdgeInsets.all(7),
                child: ListView.builder(
                  itemCount: state.items.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 5,
                      child: Padding(
                        padding: EdgeInsets.all(7),
                        child: Stack(children: <Widget>[
                          Align(
                            alignment: Alignment.topLeft,
                            child: Stack(
                              children: <Widget>[
                                Positioned(
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.only(left: 10, top: 5),
                                    child: Column(
                                      children: <Widget>[
                                        Text(
                                          state.items[index].fullName ?? "",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text( Localization.of(context)
                                                    .getTranslatedValue(
                                                        "AdvanceRequest"),
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black54)),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Stack(
                              children: <Widget>[
                                Positioned(
                                  child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, top: 5),
                                      child: DelayedAnimation(
                                        child: ButtonTheme(
                                            minWidth: 100.0,
                                            height: 30.0,
                                            child: RaisedButton(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      new BorderRadius.circular(
                                                          15.0),
                                                  side: BorderSide(
                                                      color: Colors.white)),
                                              materialTapTargetSize:
                                                  MaterialTapTargetSize
                                                      .shrinkWrap,
                                              color: Color.fromRGBO(
                                                  243, 119, 55, 0.7),
                                              child: Text(
                                                Localization.of(context)
                                                    .getTranslatedValue(
                                                        "Approve"),
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.white),
                                              ),
                                              onPressed: () {
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ApprovePage(
                                                              bloc: bloc,
                                                              advance:
                                                                  state.items[
                                                                      index])),
                                                );
                                              },
                                            )),
                                        delay: 200,
                                      )),
                                ),
                              ],
                            ),
                          )
                        ]),
                      ),
                    );
                  },
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
