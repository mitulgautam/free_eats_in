import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:freeeatsin/core/model/food_point_single_event_model.dart';
import 'package:freeeatsin/core/model/profile_response_model.dart';
import 'package:freeeatsin/core/services/api.dart';
import 'package:freeeatsin/resources/fonts.dart';
import 'package:freeeatsin/resources/strings.dart';
import 'package:freeeatsin/resources/themes.dart';
import 'package:freeeatsin/ui/widgets/add_new_event.dart';
import 'package:freeeatsin/ui/widgets/event_card.dart';
import 'package:google_fonts/google_fonts.dart';

class FoodPointEventList extends StatelessWidget {
  final List<FoodPointEvents> foodPointEvent;

  const FoodPointEventList({Key key, this.foodPointEvent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return foodPointEvent.length == 0
        ? Center(
            child: Text("No food point event posted!"),
          )
        : ListView.builder(
            itemBuilder: (context, index) => GestureDetector(
                onTap: () async {
                  dynamic response = await API
                      .getSingleFoodPointEvent(foodPointEvent[index].id);

                  if (response is bool && response == false) {
                    await showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                                title: Text("Error"),
                                content: Center(
                                    child: Text(
                                        "Some error occurred. Please try again later!")),
                                actions: <Widget>[
                                  MaterialButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text("Okay"))
                                ]));
                  } else if (response is FoodPointSingleEventModel) {
                    var model = response.message[0];
                    await showDialog(
                        context: context,
                        builder: (context) => AddNewFoodPointEvent(
                              isUpdate: true,
                              id: model.id,
                              state: model.state,
                              banner: model.banner,
                              address: model.address,
                              city: model.city,
                              name: model.eventName,
                              date: model.date,
                              place: model.place,
                              eventDescription: model.description,
                              organizerName: model.organizerName,
                              items: model.eventItem,
                              fee: model.eventFee,
                              eventFrequency: model.frequency,
                              fromTime: model.startTime,
                              toTime: model.endTime,
                            ));
                  }
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
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              child: Image.network(
                                                  foodPointEvent[index]
                                                      .banner))),
                                      CostTypeChip(
                                          cost:
                                              foodPointEvent[index].costType ==
                                                      "free"
                                                  ? Cost.FREE
                                                  : Cost.PAID)
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
                                              Text(foodPointEvent[index].name,
                                                  style: TextStyle(
                                                      fontSize: 18.0)),
                                              Text(foodPointEvent[index]
                                                  .description),
                                              Text(
                                                  foodPointEvent[index].place +
                                                      ",\n " +
                                                      foodPointEvent[index]
                                                          .address,
                                                  maxLines: 3,
                                                  style: GoogleFonts.quicksand(
                                                      textStyle: Theme.of(
                                                              context)
                                                          .textTheme
                                                          .caption
                                                          .copyWith(
                                                              fontFamily: Fonts
                                                                  .METROPOLIS_REGULAR,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400))),
                                              RatingBar(
                                                  initialRating:
                                                      foodPointEvent[index]
                                                              .rating ??
                                                          0,
                                                  minRating: 0,
                                                  itemSize: 24.0,
                                                  direction: Axis.horizontal,
                                                  allowHalfRating: true,
                                                  itemCount: 5,
                                                  itemPadding:
                                                      EdgeInsets.symmetric(
                                                          horizontal: 4.0),
                                                  itemBuilder: (context, _) =>
                                                      Icon(Icons.star,
                                                          color: Colors.amber),
                                                  ignoreGestures: true,
                                                  onRatingUpdate:
                                                      (double value) {}),
                                              foodPointEvent[index].costType ==
                                                      "paid"
                                                  ? Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 4.0),
                                                      child: Text(
                                                          "₹" +
                                                              foodPointEvent[
                                                                      index]
                                                                  .fee,
                                                          style: TextStyle(
                                                              color: Themes
                                                                  .DARK_BROWN_COOKIE)))
                                                  : SizedBox()
                                            ]))))
                              ])
                        ])))),
            itemCount: foodPointEvent.length,
            shrinkWrap: true);
  }
}
