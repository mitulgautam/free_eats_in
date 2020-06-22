import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freeeatsin/core/model/dashboard_events_response_model.dart';
import 'package:freeeatsin/core/provider/fodd_point_provider.dart';
import 'package:freeeatsin/core/provider/user_provider.dart';
import 'package:freeeatsin/core/services/api.dart';
import 'package:freeeatsin/ui/widgets/event_card.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class FoodPoint extends StatefulWidget {
  @override
  _FoodPointState createState() => _FoodPointState();
}

class _FoodPointState extends State<FoodPoint> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FoodPointProvider>(
        create: (_) => FoodPointProvider(),
        child: Consumer<FoodPointProvider>(
            builder: (_, model, __) => SmartRefresher(
                  controller: _refreshController,
                  enablePullDown: true,
                  onRefresh: () {
                    setState(() {});
                    _refreshController.refreshCompleted();
                  },
                  child: Column(children: <Widget>[
                    AspectRatio(
                        aspectRatio: 16 / 7,
                        child: Carousel(images: [
                          Image.asset("assets/images/banner.png"),
                          Image.asset("assets/images/banner.png")
                        ], boxFit: BoxFit.cover, showIndicator: false)),
                    Expanded(
                        child: FutureBuilder(
                            future: API.getDashboardEvents(context
                                .read<UserProvider>()
                                .userLoginResponseModel
                                .message
                                .id),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState !=
                                  ConnectionState.done) {
                                return Center(
                                    child: CircularProgressIndicator());
                              } else {
                                if (snapshot.data
                                    is DashboardEventsResponseModel) {
                                  DashboardEventsResponseModel model =
                                      snapshot.data;
                                  if (!model.success)
                                    return Text("Model doest return");
                                  if (model.message.length == 0)
                                    return Center(
                                        child: Text(
                                            "No event available! Check back later.",
                                            style: TextStyle(fontSize: 18.0)));
                                  return ListView.builder(
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) =>
                                          EventCard(
                                              foodPointModel:
                                                  model.message[index],
                                              index: index,
                                              cardType: CardType.FOOD_POINT,
                                              isHelp: false),
                                      itemCount: model.message.length);
                                } else
                                  return Text("Unable to load data");
                              }
                            }))
                  ]),
                )));
  }
}
