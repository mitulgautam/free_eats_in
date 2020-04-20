import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:freeeatsin/resources/strings.dart';
import 'package:freeeatsin/resources/themes.dart';
import 'package:freeeatsin/ui/widgets/add_new_event.dart';
import 'package:freeeatsin/ui/widgets/food_point.dart';
import 'package:freeeatsin/ui/widgets/help.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final _widget = [FoodPoint(), Help()];
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FreeEats"),
        centerTitle: true,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: RaisedButton(
        onPressed: () => Navigator.pushNamed(context, Strings.ADD_EVENT),
        color: Themes.DARK_BROWN_COOKIE,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              Icons.add,
              color: Colors.white,
            ),
            Text(
              "Add Event",
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
        shape: StadiumBorder(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("Food Point")),
          BottomNavigationBarItem(icon: Icon(Icons.help), title: Text("Help"))
        ],
        currentIndex: _currentPage,
        onTap: (_) {
          setState(() {
            _currentPage = _;
          });
        },
      ),
      body: SafeArea(child: _widget[_currentPage]),
    );
  }
}
