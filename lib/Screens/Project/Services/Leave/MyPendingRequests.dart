import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orc_hr/Bloc/Project/bloc/leave_bloc.dart';
import 'package:orc_hr/Localization/Localization.dart';
import 'package:orc_hr/Widgets/Project/PendingList.dart';

class MyPendingRequests extends StatefulWidget {
  const MyPendingRequests();

  @override
  _MyPendingRequestsState createState() => _MyPendingRequestsState();
}

class _MyPendingRequestsState extends State<MyPendingRequests> {
  LeaveBloc ?bloc;
  @override
  void initState() {
    super.initState();
    bloc = new LeaveBloc();
    bloc!.add(GetMyPendingRequests());
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
            Localization.of(context).getTranslatedValue("MyPendingRequests"),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        backgroundColor: Colors.white,
        body: BlocListener<LeaveBloc, LeaveState>(
            bloc: bloc,
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
            },
            child: BlocBuilder<LeaveBloc, LeaveState>(
              bloc: bloc,
              builder: (context, state) {
                if (state is LeaveLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is GetMyPendingRequestsSuccessfully){
                  return pendingRequests(state.list,context);
                }
                return Container();
              },
            )));
  }
}
