import 'package:flutter/material.dart';
import 'package:freeeatsin/resources/strings.dart';
import 'package:freeeatsin/ui/widgets/event_card.dart';

class Help extends StatefulWidget {
  @override
  _HelpState createState() => _HelpState();
}

class _HelpState extends State<Help> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
            child: SingleChildScrollView(
                child: Column(children: <Widget>[
      EventCard(cost: Cost.FREE, index: 1, cardType: CardType.HELP_SECTION, helpType: "Education"),
      EventCard(cost: Cost.FREE, index: 2, cardType: CardType.HELP_SECTION, helpType: "Nearby Living"),
      EventCard(cost: Cost.FREE, index: 3, cardType: CardType.HELP_SECTION, helpType: "Education"),
      EventCard(cost: Cost.FREE, index: 4, cardType: CardType.HELP_SECTION, helpType: "Cloth")
    ]))));
  }
}
