import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:freeeatsin/resources/fonts.dart';
import 'package:freeeatsin/resources/strings.dart';
import 'package:freeeatsin/resources/themes.dart';
import 'package:google_fonts/google_fonts.dart';

class HomepageCard extends StatelessWidget {
  final Cost cost;

  const HomepageCard({Key key, this.cost}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(16.0, 4.0, 16.0, 8.0),
      elevation: 8.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                          "https://d2xww5ont629tp.cloudfront.net/event/e51cec7a-0e56-11e7-b813-12bd195f6152/2d6583cc0f22f5a0c74f711e2bf88aa5a03da3ea-256x256"),
                    ),
                  ),
                  CostTypeChip(cost: cost),
                ],
              ),
              flex: 1,
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text("Akshay Patra Kitchen", style: TextStyle(fontSize: 18.0)),
                      Text(
                        "KH-001, Kavinagar, Ghaziabad, U.P. India 201001",
                        maxLines: 3,
                        style: GoogleFonts.quicksand(textStyle: Theme.of(context).textTheme.bodyText2.copyWith(fontFamily: Fonts.METROPOLIS_REGULAR)),
                      ),
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
                      RatingBar(
                        initialRating: 3,
                        minRating: 1,
                        itemSize: 24.0,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      ),
                      cost == Cost.PAID
                          ? Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Text("₹ 100 to 200 per person", style: TextStyle(color: Themes.DARK_BROWN_COOKIE)))
                          : SizedBox()
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CostTypeChip extends StatefulWidget {
  final Cost cost;

  const CostTypeChip({Key key, this.cost}) : super(key: key);

  @override
  _CostTypeChipState createState() => _CostTypeChipState();
}

class _CostTypeChipState extends State<CostTypeChip> {
  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(widget.cost == Cost.FREE ? "FREE" : "PAID", style: TextStyle(color: Colors.white, fontSize: 12.0)),
      backgroundColor: widget.cost == Cost.FREE ? Colors.lightGreen : Colors.amber,
      shadowColor: widget.cost == Cost.FREE ? Colors.lightGreenAccent : Colors.amberAccent,
      shape: RoundedRectangleBorder(),
      padding: EdgeInsets.all(0.0),
    );
  }
}
