import 'package:flutter/material.dart';
import 'package:freeeatsin/core/model/help_single_event_model.dart';
import 'package:freeeatsin/core/model/profile_response_model.dart';
import 'package:freeeatsin/core/services/api.dart';
import 'package:freeeatsin/resources/fonts.dart';
import 'package:freeeatsin/resources/strings.dart';
import 'package:freeeatsin/ui/widgets/add_help_event.dart';
import 'package:freeeatsin/ui/widgets/event_card.dart';
import 'package:google_fonts/google_fonts.dart';

class HelpCard extends StatelessWidget {
  final List<HelpEvents> helpCard;

  const HelpCard({Key key, this.helpCard}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return helpCard.length == 0
        ? Center(
            child: Text("No help event posted!"),
          )
        : ListView.builder(
            itemBuilder: (context, index) => GestureDetector(
                onTap: () async {
                  dynamic response =
                      await API.getSingleHelpEvent(helpCard[0].id);
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
                  } else if (response is HelpSingleEventModel) {
                    var model = response.message[0];
                    print(model.banner);
                    await showDialog(
                        context: context,
                        builder: (context) => AddHelpEvent(
                              isUpdate: true,
                              city: model.city,
                              place: model.place,
                              postby: helpCard[0].postBy,
                              banner: model.banner,
                              id: model.id,
                              eventDescription: model.description,
                              address: model.address,
                              state: model.state,
                              helpType: model.type,
                              eventName: model.name,
                              timeOfDay: model.startTime,
                              date: model.date,
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
                                                  helpCard[index].image))),
                                      CostTypeChip(
                                          cost: Cost.FREE,
                                          helpType: helpCard[index].type)
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
                                              Text(helpCard[index].name,
                                                  style: TextStyle(
                                                      fontSize: 18.0)),
                                              Text(helpCard[index].address,
                                                  maxLines: 2,
                                                  style: GoogleFonts.quicksand(
                                                      textStyle: Theme.of(
                                                              context)
                                                          .textTheme
                                                          .bodyText2
                                                          .copyWith(
                                                              fontFamily: Fonts
                                                                  .METROPOLIS_REGULAR))),
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                          helpCard[index]
                                                                  .description ??
                                                              "No description",
                                                          maxLines: 3,
                                                          overflow: TextOverflow
                                                              .ellipsis)))
                                            ]))))
                              ])
                        ])))),
            itemCount: helpCard.length,
            shrinkWrap: true);
  }
}
