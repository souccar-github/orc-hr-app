import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:orc_hr/Bloc/Project/bloc/leave_bloc.dart';
import 'package:orc_hr/Models/Project/LeaveInfoModel.dart';
import 'package:orc_hr/Screens/Project/Services/Leave/LeaveRequest.dart';
import 'package:orc_hr/Localization/Localization.dart';
import 'package:orc_hr/Widgets/General/Animation/delayed_animation.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:orc_hr/Widgets/General/Drawer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../Notifications.dart';

class LeavesBalance extends StatefulWidget {
  @override
  _LeavesBalanceState createState() => _LeavesBalanceState();
}

class _LeavesBalanceState extends State<LeavesBalance> {
  LeaveBloc bloc;
  @override
  void initState() {
    super.initState();
    bloc = new LeaveBloc();
    bloc.add(InitMainLeavesBalancePage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
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
        title: Text(
          Localization.of(context).getTranslatedValue("LeavesBalance"),
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
        },
        child: BlocBuilder<LeaveBloc, LeaveState>(
          cubit: bloc,
          builder: (context, state) {
            if (state is LeaveLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is MainLeavesBalanceInitSuccessfully) {
              List<ChartData> firstChartData = [
                ChartData(
                    Localization.of(context).getTranslatedValue("Granted"),
                    state.infos[0].granted,
                    Colors.red),
                ChartData(Localization.of(context).getTranslatedValue("Remain"),
                    state.infos[0].remain, Colors.green)
              ];
              List<ChartData> secChartData = [
                ChartData(
                    Localization.of(context).getTranslatedValue("Granted"),
                    state.infos[1].granted,
                    Colors.red),
                ChartData(Localization.of(context).getTranslatedValue("Remain"),
                    state.infos[1].remain, Colors.green)
              ];
              return SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("lib/assets/identety.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Row(
                    children: <Widget>[
                      Container(width: MediaQuery.of(context).size.width/2,child: 
                      Column(children: <Widget>[
                        SfCircularChart(
                          legend: Legend(
                              overflowMode: LegendItemOverflowMode.none,
                              isVisible: true,
                              position: LegendPosition.bottom),
                          series: <CircularSeries>[
                            DoughnutSeries<ChartData, String>(
                                dataSource: firstChartData,
                                pointColorMapper: (ChartData data, _) =>
                                    data.color,
                                xValueMapper: (ChartData data, _) => data.x,
                                yValueMapper: (ChartData data, _) => data.y,
                                name: state.infos[0].title,
                                dataLabelSettings:
                                    DataLabelSettings(isVisible: true))
                          ],
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 2 - 20,
                          height: 30,
                          child: Center(
                            child: AutoSizeText(
                              state.infos[0].title,
                              maxLines: 1,
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Text(
                          Localization.of(context)
                              .getTranslatedValue("Balance:"),
                          style: TextStyle(fontSize: 15),
                        ),
                        Text(state.infos[0].balance.toString()),
                        SizedBox(
                          height: 20,
                        ),
                        DelayedAnimation(
                          child: ButtonTheme(
                              minWidth: 100.0,
                              height: 30.0,
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
                                      .getTranslatedValue("RequestLeave"),
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) => LeaveRequestPage(
                                            state.infos[0].id, bloc)),
                                  );
                                },
                              )),
                          delay: 200,
                        )
                      ]),),
                      Container(width: MediaQuery.of(context).size.width/2,child: 

                      Column(
                        children: <Widget>[
                          SfCircularChart(
                            legend: Legend(
                                overflowMode: LegendItemOverflowMode.wrap,
                                isVisible: true,
                                position: LegendPosition.bottom),
                            series: <CircularSeries>[
                              DoughnutSeries<ChartData, String>(
                                  dataSource: secChartData,
                                  pointColorMapper: (ChartData data, _) =>
                                      data.color,
                                  xValueMapper: (ChartData data, _) => data.x,
                                  yValueMapper: (ChartData data, _) => data.y,
                                  name: state.infos[1].title,
                                  dataLabelSettings:
                                      DataLabelSettings(isVisible: true))
                            ],
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 2 - 20,
                            height: 30,
                            child: Center(
                              child: AutoSizeText(
                                state.infos[1].title,
                                maxLines: 1,
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Text(
                            Localization.of(context)
                                .getTranslatedValue("Balance:"),
                            style: TextStyle(fontSize: 15),
                          ),
                          Text(state.infos[1].balance.toString()),
                          SizedBox(
                            height: 20,
                          ),
                          DelayedAnimation(
                            child: ButtonTheme(
                                minWidth: 100.0,
                                height: 30.0,
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
                                        .getTranslatedValue("RequestLeave"),
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              LeaveRequestPage(
                                                  state.infos[1].id, bloc)),
                                    );
                                  },
                                )),
                            delay: 200,
                          )
                        ],
                      ),),
                    ],
                  ),
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

class ChartData {
  ChartData(this.x, this.y, [this.color]);
  final String x;
  final double y;
  final Color color;
}
