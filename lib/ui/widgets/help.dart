import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';

class Help extends StatefulWidget {
  @override
  _HelpState createState() => _HelpState();
}

class _HelpState extends State<Help> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(children: <Widget>[
      AspectRatio(
      aspectRatio: 16 / 7,
      child: Carousel(images: [
    Image.asset("assets/images/banner.png"),
    Image.asset("assets/images/banner.png")
      ], boxFit: BoxFit.cover, showIndicator: false)),
    ]));
  }
}
