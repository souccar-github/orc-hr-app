import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orc_hr/Bloc/Project/bloc/mission_bloc.dart';
import 'package:orc_hr/Localization/Localization.dart';
import 'package:orc_hr/Widgets/Project/PendingList.dart';

class MyPendingRequests extends StatefulWidget {
  const MyPendingRequests();

  @override
  _MyPendingRequestsState createState() => _MyPendingRequestsState();
}

class _MyPendingRequestsState extends State<MyPendingRequests> {
  MissionBloc bloc;
  @override
  void initState() {
    super.initState();
    bloc = new MissionBloc();
    bloc.add(GetMyPendingRequests());
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
        body: BlocListener<MissionBloc, MissionState>(
            cubit: bloc,
            listener: (context, state) {
              if (state is MissionError) {
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text(
                    state.error,
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.red,
                ));
              }
            },
            child: BlocBuilder<MissionBloc, MissionState>(
              cubit: bloc,
              builder: (context, state) {
                if (state is MissionLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is GetMyPendingRequestsSuccessfully){
                  return pendingRequests(state.list);
                }
                return Container();
              },
            )));
  }
}
