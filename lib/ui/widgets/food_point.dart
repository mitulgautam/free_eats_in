import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:freeeatsin/resources/strings.dart';
import 'package:freeeatsin/ui/widgets/event_card.dart';

class FoodPoint extends StatefulWidget {
  @override
  _FoodPointState createState() => _FoodPointState();
}

class _FoodPointState extends State<FoodPoint> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 16 / 7,
          child: Carousel(
            images: [
              Image.asset("assets/images/banner.png"),
              Image.asset("assets/images/banner.png"),
            ],
            boxFit: BoxFit.cover,
            showIndicator: false,
          ),
        ),
        EventCard(cost: Cost.FREE, index: 0),
        EventCard(cost: Cost.PAID, index: 1),
        EventCard(cost: Cost.PAID, index: 2),
        EventCard(cost: Cost.FREE, index: 3),
        EventCard(cost: Cost.FREE, index: 4),
        EventCard(cost: Cost.PAID, index: 5),
      ],
    );
  }
}
