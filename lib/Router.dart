

import 'package:flutter/material.dart';
import 'package:orc_hr/RoutesNames.dart';
import 'package:orc_hr/Screens/Project/Notifications.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Notifications:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: NotificationPage()
      );
    default:
      return MaterialPageRoute(
          builder: (_) => Scaffold(
                body: Center(
                    child: Text('No route defined for ${settings.name}')),
              ));
  }
}

PageRoute _getPageRoute({String? routeName, Widget? viewToShow}) {
  return MaterialPageRoute(
      settings: RouteSettings(
        name: routeName,
      ),
      builder: (_) => viewToShow!);
}
