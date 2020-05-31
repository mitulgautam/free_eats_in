import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:freeeatsin/core/model/dashboard_help_response_model.dart';
import 'package:freeeatsin/core/provider/help_provider.dart';
import 'package:freeeatsin/core/provider/user_provider.dart';
import 'package:freeeatsin/core/services/api.dart';
import 'package:freeeatsin/ui/widgets/event_card.dart';
import 'package:provider/provider.dart';

class Help extends StatefulWidget {
  @override
  _HelpState createState() => _HelpState();
}

class _HelpState extends State<Help> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HelpProvider>(
      create: (_) => HelpProvider(),
      child: Consumer<HelpProvider>(
        builder: (_, model, __) => Column(children: <Widget>[
          AspectRatio(
          aspectRatio: 16 / 7,
          child: Carousel(images: [
            Image.asset("assets/images/banner.png"),
            Image.asset("assets/images/banner.png")
          ], boxFit: BoxFit.cover, showIndicator: false)),
          Expanded(
          child: FutureBuilder(
              future: API.getDashboardHelps(context
                  .read<UserProvider>()
                  .userLoginResponseModel
                  .message
                  .id),
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  if (snapshot.data is DashboardHelpResponseModel) {
                    DashboardHelpResponseModel model = snapshot.data;
                    if (!model.success) return Text("Model doesn't return");
                    if (model.message.length == 0)
                      return Center(
                          child: Text(
                              "No event available! Check back later.",
                              style: TextStyle(fontSize: 18.0)));
                    return ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: (context, index) => EventCard(
                            helpModel: model.message[index],
                            index: index,
                            cardType: CardType.HELP_SECTION,
                            isHelp: true),
                        itemCount: model.message.length);
                  } else
                    return Text("Unable to load data");
                }
              }))
        ]),
      ),
    );
  }
}
