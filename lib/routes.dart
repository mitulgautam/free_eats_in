import 'package:flutter/material.dart';
import 'package:freeeatsin/resources/strings.dart';
import 'package:freeeatsin/ui/event_details_view.dart';
import 'package:freeeatsin/ui/homepage.dart';
import 'package:freeeatsin/ui/profile_view.dart';
import 'package:freeeatsin/ui/widgets/add_new_event.dart';

class Router {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Strings.HOMEPAGE:
        return MaterialPageRoute(builder: (_) => Homepage());
      case Strings.ADD_EVENT:
        return MaterialPageRoute(builder: (_) => AddNewEvent());
      case Strings.PROFILE:
        return MaterialPageRoute(builder: (_) => Profile());
      case Strings.EVENT_DETAILS:
        return MaterialPageRoute(builder: (_) => EventDetailsView(arguments: settings.arguments));
      default:
        return MaterialPageRoute(builder: (_) => Scaffold(body: Center(child: Text('${settings.name} does not exists.'))));
    }
  }
}
