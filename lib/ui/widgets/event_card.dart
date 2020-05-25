import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:freeeatsin/core/model/dashboard_events_response_model.dart';
import 'package:freeeatsin/core/model/dashboard_help_response_model.dart';
import 'package:freeeatsin/core/provider/user_provider.dart';
import 'package:freeeatsin/resources/fonts.dart';
import 'package:freeeatsin/resources/strings.dart';
import 'package:freeeatsin/resources/themes.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class EventCard extends StatelessWidget {
  final int index;
  final FoodPointCard foodPointModel;
  final HelpCard helpModel;
  final bool isHelp;
  final CardType cardType;

  const EventCard(
      {Key key,
      @required this.index,
      this.cardType,
      this.foodPointModel,
      this.isHelp,
      this.helpModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, Strings.EVENT_DETAILS,
              arguments: <String, String>{
                "user_id": helpModel != null
                    ? helpModel.userId.toString()
                    : context
                        .read<UserProvider>()
                        .userLoginResponseModel
                        .message
                        .id
                        .toString(),
                "post_id": helpModel != null
                    ? helpModel.id.toString()
                    : foodPointModel.id.toString(),
                "is-help": helpModel != null ? "yes" : "no"
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
                                  cost: foodPointModel == null
                                      ? Cost.FREE
                                      : foodPointModel.costType,
                                  helpType: isHelp ? helpModel.type : null)
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
                                      Text(
                                          isHelp
                                              ? helpModel.name
                                              : foodPointModel.name,
                                          style: TextStyle(fontSize: 18.0)),
                                      Text(
                                          isHelp
                                              ? helpModel.address
                                              : foodPointModel.address,
                                          maxLines: 2,
                                          style: GoogleFonts.quicksand(
                                              textStyle: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2
                                                  .copyWith(
                                                      fontFamily: Fonts
                                                          .METROPOLIS_REGULAR))),
                                      isHelp
                                          ? Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 4.0),
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(
                                                        "post by @${helpModel.postBy}",
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
                                          ? Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                      helpModel.description ??
                                                          "No description",
                                                      maxLines: 3,
                                                      overflow: TextOverflow
                                                          .ellipsis)),
                                            )
                                          : SizedBox(),
                                      cardType == CardType.HELP_SECTION
                                          ? SizedBox()
                                          : RatingBar(
                                              initialRating: foodPointModel
                                                  .rating
                                                  .roundToDouble(),
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
                                              ignoreGestures: true,
                                              onRatingUpdate:
                                                  (double value) {}),
                                      !isHelp &&
                                              foodPointModel.costType ==
                                                  Cost.PAID
                                          ? Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 4.0),
                                              child: Text(
                                                  "₹" + foodPointModel.fee,
                                                  style: TextStyle(
                                                      color: Themes
                                                          .DARK_BROWN_COOKIE)))
                                          : SizedBox()
                                    ]))))
                      ])
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
