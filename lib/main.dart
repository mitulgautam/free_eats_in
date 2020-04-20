import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freeeatsin/resources/fonts.dart';
import 'package:freeeatsin/resources/strings.dart';
import 'package:freeeatsin/routes.dart';
import 'package:freeeatsin/ui/homepage.dart';

void main() => runApp(App());

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
//      initialRoute: Strings.HOMEPAGE,
      home: Homepage(),
      onGenerateRoute: Router.onGenerateRoute,
      theme: ThemeData(fontFamily: Fonts.JAAPOKKI_REGULAR, primarySwatch: Colors.brown),
    );
  }
}
