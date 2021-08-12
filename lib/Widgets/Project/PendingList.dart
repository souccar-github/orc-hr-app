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
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            list[index].type == "3"
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
                                                .getTranslatedValue(
                                                    "RequestDate:"),
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
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                            Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Row(
                                                    children: <Widget>[
                                                      Text(
                                                        Localization.of(context)
                                                            .getTranslatedValue(
                                                                "Record Date:"),
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Text(
                                                        list[index]
                                                                .date
                                                                .toIso8601String()
                                                                .substring(
                                                                    0, 10) ??
                                                            "",
                                                        style: TextStyle(),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      Text(
                                                        Localization.of(context)
                                                            .getTranslatedValue(
                                                                "Record Time:"),
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Text(
                                                        list[index]
                                                                .date
                                                                .toIso8601String()
                                                                .substring(
                                                                    11, 16) ??
                                                            "",
                                                        style: TextStyle(),
                                                      ),
                                                    ],
                                                  ),
                                                ]),
                                            SizedBox(
                                              width: 30,
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Text(
                                                  Localization.of(context)
                                                      .getTranslatedValue(
                                                          "Type:"),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  list[index].logType == 0
                                                      ? Localization.of(context)
                                                          .getTranslatedValue(
                                                              "Entrance")
                                                      : list[index].logType == 1
                                                          ? Localization.of(
                                                                  context)
                                                              .getTranslatedValue(
                                                                  "Exit")
                                                          : "",
                                                  style: TextStyle(),
                                                ),
                                              ],
                                            ),
                                          ]),
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
