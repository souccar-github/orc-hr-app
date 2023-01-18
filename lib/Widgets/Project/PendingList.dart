import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orc_hr/Localization/Localization.dart';
import 'package:orc_hr/Models/Project/WorkflowInfo.dart';

Widget pendingRequests(List<WorkflowInfo> list, BuildContext _context) {
  if (list.length == 0) {
    return Padding(
        padding: EdgeInsets.all(7),
        child: Center(
          child: Text(
            Localization.of(_context).getTranslatedValue("NoItemsToShow"),
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ));
  }
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
                                ? Column(
                                    children: [
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            Localization.of(context)
                                                .getTranslatedValue(
                                                    "LeaveSetting"),
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            " : " + list[index].leaveSetting!,
                                            style: TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
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
                                                                "RequestDate"),
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Text(
                                                        " : " +
                                                            list[index]
                                                                .date!
                                                                .toIso8601String()
                                                                .substring(
                                                                    0, 10),
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  list[index].isHourly
                                                      ? Row(
                                                          children: <Widget>[
                                                            Text(
                                                              Localization.of(
                                                                      context)
                                                                  .getTranslatedValue(
                                                                      "FromTime"),
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            Text(
                                                              " : " +
                                                                  list[index]
                                                                      .fromTime!
                                                                      .toIso8601String()
                                                                      .substring(
                                                                          11,
                                                                          16),
                                                              style: TextStyle(
                                                                fontSize: 14,
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      : Container(),
                                                ]),
                                            SizedBox(
                                              width: 30,
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: <Widget>[
                                                    Text(
                                                      Localization.of(context)
                                                          .getTranslatedValue(
                                                              "IsHourly"),
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(
                                                      list[index].isHourly
                                                          ? " : " +
                                                              Localization.of(
                                                                      context)
                                                                  .getTranslatedValue(
                                                                      "Yes")
                                                          : " : " +
                                                              Localization.of(
                                                                      context)
                                                                  .getTranslatedValue(
                                                                      "No"),
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                list[index].isHourly
                                                    ? Row(
                                                        children: <Widget>[
                                                          Text(
                                                            Localization.of(
                                                                    context)
                                                                .getTranslatedValue(
                                                                    "ToTime"),
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          Text(
                                                            " : " +
                                                                list[index]
                                                                    .toTime!
                                                                    .toIso8601String()
                                                                    .substring(
                                                                        11, 16),
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    : Container()
                                              ],
                                            ),
                                          ]),
                                      SizedBox(
                                        height: 10,
                                      )
                                    ],
                                  )
                                : list[index].type == "12" ?
                                Column(
                                    children: [
                                      Row(
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
                                                                "RequestDate"),
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Text(
                                                        " : " +
                                                            list[index]
                                                                .date!
                                                                .toIso8601String()
                                                                .substring(
                                                                    0, 10),
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  list[index].isHourly
                                                      ? Row(
                                                          children: <Widget>[
                                                            Text(
                                                              Localization.of(
                                                                      context)
                                                                  .getTranslatedValue(
                                                                      "FromTime"),
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            Text(
                                                              " : " +
                                                                  list[index]
                                                                      .fromTime!
                                                                      .toIso8601String()
                                                                      .substring(
                                                                          11,
                                                                          16),
                                                              style: TextStyle(
                                                                fontSize: 14,
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      : Container(),
                                                ]),
                                            SizedBox(
                                              width: 30,
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: <Widget>[
                                                    Text(
                                                      Localization.of(context)
                                                          .getTranslatedValue(
                                                              "IsHourly"),
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(
                                                      list[index].isHourly
                                                          ? " : " +
                                                              Localization.of(
                                                                      context)
                                                                  .getTranslatedValue(
                                                                      "Yes")
                                                          : " : " +
                                                              Localization.of(
                                                                      context)
                                                                  .getTranslatedValue(
                                                                      "No"),
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                list[index].isHourly
                                                    ? Row(
                                                        children: <Widget>[
                                                          Text(
                                                            Localization.of(
                                                                    context)
                                                                .getTranslatedValue(
                                                                    "ToTime"),
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          Text(
                                                            " : " +
                                                                list[index]
                                                                    .toTime!
                                                                    .toIso8601String()
                                                                    .substring(
                                                                        11, 16),
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    : Container()
                                              ],
                                            ),
                                          ]),
                                      SizedBox(
                                        height: 10,
                                      )
                                    ],
                                  )
                                       : list[index].type == "11"
                                    ? Row(
                                        children: <Widget>[
                                          Text(
                                            Localization.of(context)
                                                .getTranslatedValue(
                                                    "RequestDate"),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            " : " +
                                                list[index]
                                                    .date!
                                                    .toIso8601String()
                                                    .substring(0, 10),
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
                                                                "RecordDate"),
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Text(
                                                        " : " +
                                                            list[index]
                                                                .date!
                                                                .toIso8601String()
                                                                .substring(
                                                                    0, 10),
                                                        style: TextStyle(),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      Text(
                                                        Localization.of(context)
                                                            .getTranslatedValue(
                                                                "RecordTime"),
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Text(
                                                        " : " +
                                                            list[index]
                                                                .date!
                                                                .toIso8601String()
                                                                .substring(
                                                                    11, 16),
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
                                                          "Type"),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  list[index].logType == 0
                                                      ? " : " +
                                                          Localization.of(
                                                                  context)
                                                              .getTranslatedValue(
                                                                  "Entrance")
                                                      : list[index].logType == 1
                                                          ? " : " +
                                                              Localization.of(
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
                            Text(list[index].pendingStep!,
                                style: TextStyle(
                                    fontSize: 14, color: Colors.black54)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
             Positioned(
              bottom: 0,
              left:Localizations.localeOf(context).languageCode == 'en'
                    ? MediaQuery.of(context).size.width -170
                    : 0 ,
                  child: Align(
                alignment: Localizations.localeOf(context).languageCode == 'en'
                    ? Alignment.bottomRight
                    : Alignment.bottomRight,
                child: Column(
                  children: <Widget>[
                    list[index].waitingApprove
                        ? Text(
                            Localization.of(context)
                                .getTranslatedValue("WaitingforApprove"),
                            style: TextStyle(
                                fontSize: 14,
                                fontStyle: FontStyle.italic,
                                color: Colors.black54))
                        : Container()
                  ],
                ),) ,
              )
            ]),
          ),
        );
      },
    ),
  );
}
