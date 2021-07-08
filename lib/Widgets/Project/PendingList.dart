import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orc_hr/Localization/Localization.dart';
import 'package:orc_hr/Models/Project/WorkflowInfo.dart';

Widget pendingRequests(List<WorkflowInfo> list) {
  return Padding(
    padding: EdgeInsets.all(7),
    child: ListView.builder(
      itemCount: list.length,
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
                        padding: const EdgeInsets.only(left: 10, top: 5),
                        child: Column(
                          children: <Widget>[
                            list[index].type == 3
                                ? Row(
                                    children: <Widget>[
                                      Text(
                                        Localization.of(context)
                                            .getTranslatedValue("RequestDate:"),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        list[index]
                                                .date
                                                .toIso8601String()
                                                .substring(0, 10) ??
                                            "",
                                      )
                                    ],
                                  )
                                : list[index].type == "12"
                                    ? Row(
                                    children: <Widget>[
                                      Text(
                                        Localization.of(context)
                                            .getTranslatedValue("RequestDate:"),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        list[index]
                                                .date
                                                .toIso8601String()
                                                .substring(0, 10) ??
                                            "",
                                      )
                                    ],
                                  )
                                    : Text(
                                        list[index]
                                                .date
                                                .toIso8601String()
                                                .substring(0, 10) ??
                                            "",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(list[index].pendingStep ?? "",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.black54)),
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
                    list[index].waitingApprove
                        ? Text(
                            Localization.of(context)
                                .getTranslatedValue("WaitingforApprove"),
                            style:
                                TextStyle(fontSize: 14, color: Colors.black54))
                        : Container()
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
