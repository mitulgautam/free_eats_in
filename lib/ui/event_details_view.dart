import 'package:flutter/material.dart';
import 'package:freeeatsin/core/model/food_point_single_event_model.dart';
import 'package:freeeatsin/core/services/api.dart';
import 'package:freeeatsin/resources/themes.dart';

class EventDetailsView extends StatefulWidget {
  final Map<String, String> arguments;

  const EventDetailsView({Key key, @required this.arguments}) : super(key: key);

  @override
  _EventDetailsViewState createState() => _EventDetailsViewState();
}

class _EventDetailsViewState extends State<EventDetailsView> {
  bool isLoading = true;
  bool isLoadingError = false;
  FoodPointSingleEventModel _foodPointSingleEventModel;
  bool isHelp;

  @override
  void initState() {
    isHelp = widget.arguments["is-help"] == "yes" ? true : false;
    API
        .getSingleFoodPointEvent(int.parse(widget.arguments["post_id"]))
        .then((value) {
      if (value is bool) {
        setState(() {
          isLoadingError = true;
        });
      } else {
        _foodPointSingleEventModel = value;
      }
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: isLoading
            ? SizedBox()
            : Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                RaisedButton(
                    shape: StadiumBorder(),
                    onPressed: () {
                      isHelp
                          ? API
                              .attendFoodHelpEvent(
                                  int.parse(widget.arguments["post_id"]),
                                  int.parse(widget.arguments["user_id"]))
                              .then((value) {
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                          title: Text("Notification"),
                                          content: Text(value
                                              ? "Event Attend request Successfully! Cheers"
                                              : "Event Attend request Unsuccessfully. Please try again!"),
                                          actions: <Widget>[
                                            MaterialButton(
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                                child: Text("Okay"),
                                                shape: StadiumBorder())
                                          ]));
                            })
                          : API
                              .attendFoodPointEvent(
                                  int.parse(widget.arguments["post_id"]),
                                  int.parse(widget.arguments["user_id"]))
                              .then((value) {
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                          title: Text("Notification"),
                                          content: Text(value
                                              ? "Event Attend request Successfully! Cheers"
                                              : "Event Attend request Unsuccessfully. Please try again!"),
                                          actions: <Widget>[
                                            MaterialButton(
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                                child: Text("Okay"),
                                                shape: StadiumBorder())
                                          ]));
                            });
                    },
                    color: Themes.DARK_BROWN_COOKIE,
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Attend",
                            style: TextStyle(color: Colors.white)))),
                SizedBox(width: 12.0),
                OutlineButton(
                    shape: StadiumBorder(),
                    borderSide: BorderSide(color: Themes.DARK_BROWN_COOKIE),
                    onPressed: () {},
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Donate",
                            style: TextStyle(color: Themes.DARK_BROWN_COOKIE))))
              ]),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : isLoadingError
                ? Center(child: Text("Loading Error"))
                : Stack(children: <Widget>[
                    AspectRatio(
                        aspectRatio: 16 / 9,
                        child: Image.network("",
                            height: MediaQuery.of(context).size.height / 4,
                            fit: BoxFit.cover)),
                    SingleChildScrollView(
                        child: Column(children: <Widget>[
                      SizedBox(height: MediaQuery.of(context).size.height / 4),
                      Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(24.0)),
                          padding: EdgeInsets.all(24.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                          _foodPointSingleEventModel
                                              .message[0].eventName,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5
                                              .copyWith(
                                                  fontWeight: FontWeight.bold)),
                                      Text(
                                          isHelp
                                              ? "FREE"
                                              : _foodPointSingleEventModel
                                                  .message[0].eventType
                                                  .toUpperCase(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6
                                              .copyWith(
                                                  color: isHelp
                                                      ? Colors.blue
                                                      : _foodPointSingleEventModel
                                                                  .message[0]
                                                                  .eventType
                                                                  .toUpperCase() ==
                                                              "PAID"
                                                          ? Colors.amber
                                                          : Colors.green))
                                    ]),
                                ListTile(
                                    contentPadding: EdgeInsets.all(0.0),
                                    leading: Icon(Icons.calendar_today),
                                    title: Text(
                                        "${getWeek(_foodPointSingleEventModel.message[0].date.weekday)}, ${getMonth(_foodPointSingleEventModel.message[0].date.month)} ${_foodPointSingleEventModel.message[0].date.day}, ${_foodPointSingleEventModel.message[0].date.year}"),
                                    subtitle: Text(_foodPointSingleEventModel
                                        .message[0].startTime),
                                    trailing: Text(_foodPointSingleEventModel
                                        .message[0].frequency
                                        .toUpperCase())),
                                ListTile(
                                    contentPadding: EdgeInsets.all(0.0),
                                    title: Text(
                                        "Place not added in model" ?? "N/A"),
                                    leading: Icon(Icons.location_on),
                                    subtitle: Text(_foodPointSingleEventModel
                                            .message[0].address ??
                                        "N/A")),
                                ListTile(
                                    contentPadding: EdgeInsets.all(0.0),
                                    title: Text(isHelp
                                        ? "FREE"
                                        : _foodPointSingleEventModel
                                                    .message[0].eventType
                                                    .toUpperCase() ==
                                                "PAID"
                                            ? "₹ " +
                                                _foodPointSingleEventModel
                                                    .message[0].eventFee
                                            : "FREE EVENT"),
                                    leading: Icon(Icons.event_seat)),
                                Text("Description",
                                    style:
                                        Theme.of(context).textTheme.headline6),
                                Text(
                                    _foodPointSingleEventModel
                                        .message[0].description,
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2
                                        .copyWith(
                                            fontWeight: FontWeight.normal,
                                            color: Colors.grey),
                                    maxLines: 4),
                                SizedBox(height: 8.0),
                                Text("Food Items",
                                    style:
                                        Theme.of(context).textTheme.headline6),
                                Text(
                                    _foodPointSingleEventModel
                                        .message[0].eventItem,
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2
                                        .copyWith(
                                            fontWeight: FontWeight.normal,
                                            color: Colors.grey),
                                    maxLines: 4)
                              ]))
                    ])),
                    SafeArea(
                        child: IconButton(
                            icon: Icon(Icons.arrow_back_ios),
                            onPressed: () {
                              Navigator.pop(context);
                            }))
                  ]));
  }

  String getMonth(int month) {
    switch (month) {
      case 1:
        return "Jan";
        break;
      case 2:
        return "Feb";
        break;
      case 3:
        return "Mar";
        break;
      case 4:
        return "Apr";
        break;
      case 5:
        return "May";
        break;
      case 6:
        return "Jun";
        break;
      case 7:
        return "Jul";
        break;
      case 8:
        return "Aug";
        break;
      case 9:
        return "Sep";
        break;
      case 10:
        return "Oct";
        break;
      case 11:
        return "Nov";
        break;
      case 12:
        return "Dec";
        break;
      default:
        return month.toString();
    }
  }

  String getWeek(int week) {
    switch (week) {
      case 1:
        return "Mon";
        break;
      case 2:
        return "Tue";
        break;
      case 3:
        return "Wed";
        break;
      case 4:
        return "Thu";
        break;
      case 5:
        return "Fri";
        break;
      case 6:
        return "Sat";
        break;
      case 7:
        return "Sun";
        break;
      default:
        return week.toString();
    }
  }
}
