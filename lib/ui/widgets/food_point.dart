import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:freeeatsin/resources/strings.dart';
import 'package:freeeatsin/ui/widgets/homepage_card.dart';

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
        HomepageCard(cost: Cost.FREE),
        HomepageCard(cost: Cost.PAID),
        HomepageCard(cost: Cost.PAID),
        HomepageCard(cost: Cost.FREE),
        HomepageCard(cost: Cost.FREE),
        HomepageCard(cost: Cost.PAID),
      ],
    );
  }
}
