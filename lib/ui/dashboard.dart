import 'package:flutter/material.dart';
import 'package:freeeatsin/resources/strings.dart';
import 'package:freeeatsin/resources/themes.dart';
import 'package:freeeatsin/ui/widgets/add_help_event.dart';
import 'package:freeeatsin/ui/widgets/add_new_event.dart';
import 'package:freeeatsin/ui/widgets/food_point.dart';
import 'package:freeeatsin/ui/widgets/help.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final _widget = [FoodPoint(), Help()];
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
          child: SafeArea(
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("FreeEats.in", style: TextStyle(fontSize: 26.0)),
                        Divider(color: Colors.grey),
                        FlatButton(
                            child: Row(children: <Widget>[
                              Icon(Icons.person_outline),
                              Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Profile"))
                            ]),
                            onPressed: () =>
                                Navigator.pushNamed(context, Strings.PROFILE)),
                        Divider(color: Colors.grey),
                        FlatButton(
                            child: Row(children: <Widget>[
                              Icon(Icons.help_outline),
                              Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Help and feedback"))
                            ]),
                            onPressed: () {}),
                        Divider(color: Colors.grey),
                        FlatButton(
                            child: Row(children: <Widget>[
                              Icon(Icons.help_outline),
                              Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Log Out"))
                            ]),
                            onPressed: () async {
                              SharedPreferences _sharedPrefs =
                                  await SharedPreferences.getInstance();
                              _sharedPrefs.clear().then((value) =>
                                  Navigator.pushReplacementNamed(
                                      context, Strings.LOGIN));
                            })
                      ])))),
      appBar: AppBar(
        title: Text("FreeEats"),
        centerTitle: true,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: RaisedButton(
        onPressed: () => showDialog(
            context: context,
            builder: (context) =>
                _currentPage == 0 ? AddNewFoodPointEvent() : AddHelpEvent(),
            barrierDismissible: false),
        color: Themes.DARK_BROWN_COOKIE,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(Icons.add, color: Colors.white),
            Text(
              _currentPage == 0 ? "Add Event" : "Help Event",
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
        shape: StadiumBorder(),
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home), title: Text("Food Point")),
            BottomNavigationBarItem(icon: Icon(Icons.help), title: Text("Help"))
          ],
          currentIndex: _currentPage,
          onTap: (_) {
            setState(() {
              _currentPage = _;
            });
          }),
      body:
          SafeArea(child: IndexedStack(index: _currentPage, children: _widget)),
    );
  }
}
