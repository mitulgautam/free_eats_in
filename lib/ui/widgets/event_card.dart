import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:freeeatsin/core/model/dashboard_events_response_model.dart';
import 'package:freeeatsin/resources/fonts.dart';
import 'package:freeeatsin/resources/strings.dart';
import 'package:freeeatsin/resources/themes.dart';
import 'package:google_fonts/google_fonts.dart';

class EventCard extends StatelessWidget {
  final int index;
  final FoodPointCard model;
  final bool isHelp;
  final CardType cardType;

  const EventCard(
      {Key key, @required this.index, this.cardType, this.model, this.isHelp})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, Strings.EVENT_DETAILS,
              arguments: <String, String>{
                'index': '$index',
                'banner':
                    'https://img.evbuc.com/https%3A%2F%2Fcdn.evbuc.com%2Fimages%2F62679204%2F308865560717%2F1%2Foriginal.20190521-235843?auto=compress&s=29f6b1dc86bb911823947f24b1530861',
                'name': 'Horn OK Please',
                'date': DateTime.now().toString(),
                'start-time': DateTime.now().toString(),
                'end-time': DateTime.now().toString(),
                'address': 'Manhattan, New York City',
                'place': 'Central Park',
                'fee': '₹200',
                'description':
                    'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
                'cost': 'FREE',
                'frequency': 'DAILY',
                'items': 'Chicken,Picken,Tiken'
              });
        },
        child: Card(
            margin: EdgeInsets.fromLTRB(16.0, 4.0, 16.0, 8.0),
            elevation: 8.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(children: <Widget>[
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                            child: Stack(children: <Widget>[
                              Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.network(
                                          "https://d2xww5ont629tp.cloudfront.net/event/e51cec7a-0e56-11e7-b813-12bd195f6152/2d6583cc0f22f5a0c74f711e2bf88aa5a03da3ea-256x256"))),
                              CostTypeChip(
                                  cost: model.costType.toLowerCase() == "paid"
                                      ? Cost.PAID
                                      : Cost.FREE,
                                  helpType: isHelp ? "Change help code" : null)
                            ]),
                            flex: 1),
                        Expanded(
                            flex: 2,
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                      Text(model.name,
                                          style: TextStyle(fontSize: 18.0)),
                                      Text(model.address,
                                          maxLines: 2,
                                          style: GoogleFonts.quicksand(
                                              textStyle: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2
                                                  .copyWith(
                                                      fontFamily: Fonts
                                                          .METROPOLIS_REGULAR))),
/*                      Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                RaisedButton(
                                  onPressed: () {},
                                  child: Text("Attend", style: TextStyle(color: Colors.white)),
                                  color: Themes.DARK_BROWN_COOKIE,
                                  shape: StadiumBorder(),
                                ),
                                SizedBox(
                                  width: 8.0,
                                ),
                                OutlineButton(
                                    shape: StadiumBorder(),
                                    onPressed: () {},
                                    child: Text(
                                      "Donate",
                                      style: TextStyle(color: Themes.DARK_BROWN_COOKIE),
                                    ),
                                    borderSide: BorderSide(color: Themes.DARK_BROWN_COOKIE)),
                              ],
                            )*/ //this will be added in future update
                                      isHelp
                                          ? Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 4.0),
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text("post by @MitulGautam",
                                                        style: TextStyle(
                                                            color: Themes
                                                                .DARK_BROWN_COOKIE)),
                                                    ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(24.0),
                                                        child: Image.network(
                                                            "https://he-s3.s3.amazonaws.com/media/avatars/mitulgautam/resized/180/3ac6ba2img_20190321_221417_860.jpg",
                                                            height: 24.0))
                                                  ]))
                                          : SizedBox(),
                                      cardType == CardType.HELP_SECTION
                                          ? SizedBox()
                                          : RatingBar(
                                              initialRating:
                                                  model.rating.roundToDouble(),
                                              minRating: 0,
                                              itemSize: 24.0,
                                              direction: Axis.horizontal,
                                              allowHalfRating: true,
                                              itemCount: 5,
                                              itemPadding: EdgeInsets.symmetric(
                                                  horizontal: 4.0),
                                              itemBuilder: (context, _) => Icon(
                                                  Icons.star,
                                                  color: Colors.amber),
                                              ignoreGestures: true),
                                      model.costType.toLowerCase() == "paid"
                                          ? Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 4.0),
                                              child: Text(model.fee,
                                                  style: TextStyle(
                                                      color: Themes
                                                          .DARK_BROWN_COOKIE)))
                                          : SizedBox(),
                                    ]))))
                      ]),
                  cardType == CardType.HELP_SECTION
                      ? Text(
                          "Sample description for food help from ngo or any other society. This is done by some socirty",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis)
                      : SizedBox()
                ]))));
  }
}

class CostTypeChip extends StatefulWidget {
  final Cost cost;
  final String helpType;

  const CostTypeChip({Key key, @required this.cost, this.helpType})
      : super(key: key);

  @override
  _CostTypeChipState createState() => _CostTypeChipState();
}

class _CostTypeChipState extends State<CostTypeChip> {
  @override
  Widget build(BuildContext context) {
    return Chip(
        label: Text(
            widget.cost == Cost.FREE
                ? widget.helpType == null ? "FREE" : widget.helpType
                : "PAID",
            style: TextStyle(color: Colors.white, fontSize: 12.0)),
        backgroundColor:
            widget.cost == Cost.FREE ? Colors.lightGreen : Colors.amber,
        shadowColor: widget.cost == Cost.FREE
            ? Colors.lightGreenAccent
            : Colors.amberAccent,
        shape: RoundedRectangleBorder(),
        padding: EdgeInsets.all(0.0));
  }
}

enum CardType { FOOD_POINT, HELP_SECTION }
