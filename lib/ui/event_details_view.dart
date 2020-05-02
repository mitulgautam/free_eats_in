import 'package:flutter/material.dart';
import 'package:freeeatsin/resources/themes.dart';

class EventDetailsView extends StatefulWidget {
  final Map<String, String> arguments;

  const EventDetailsView({Key key, @required this.arguments}) : super(key: key);

  @override
  _EventDetailsViewState createState() => _EventDetailsViewState();
}

class _EventDetailsViewState extends State<EventDetailsView> {
  DateTime date;
  TimeOfDay startTime;
  TimeOfDay endTime;

  @override
  void initState() {
    date = DateTime.parse(widget.arguments['date']);
    startTime = TimeOfDay.fromDateTime(DateTime.parse(widget.arguments['start-time']));
    endTime = TimeOfDay.fromDateTime(DateTime.parse(widget.arguments['end-time']));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
        RaisedButton(
            shape: StadiumBorder(),
            onPressed: () {},
            color: Themes.DARK_BROWN_COOKIE,
            child: Padding(padding: const EdgeInsets.all(8.0), child: Text("Attend", style: TextStyle(color: Colors.white)))),
        SizedBox(width: 12.0),
        OutlineButton(
            shape: StadiumBorder(),
            borderSide: BorderSide(color: Themes.DARK_BROWN_COOKIE),
            onPressed: () {},
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Donate", style: TextStyle(color: Themes.DARK_BROWN_COOKIE)),
            ))
      ]),
      body: Stack(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Image.network(
              widget.arguments['banner'],
              height: MediaQuery.of(context).size.height / 4,
              fit: BoxFit.cover,
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height / 4,
                ),
                Container(
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24.0)),
                  padding: EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            widget.arguments['name'],
                            style: Theme.of(context).textTheme.headline5.copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            widget.arguments['cost'],
                            style: Theme.of(context).textTheme.headline6.copyWith(color: Colors.green),
                          )
                        ],
                      ),
                      ListTile(
                          contentPadding: EdgeInsets.all(0.0),
                          leading: Icon(Icons.calendar_today),
                          title: Text("${getWeek(date.weekday)}, ${getMonth(date.month)} ${date.day}, ${date.year}"),
                          subtitle: Text("${startTime.hour}:${startTime.minute} - ${endTime.hour}:${endTime.minute}"),
                          trailing: Text(widget.arguments['frequency'])),
                      ListTile(
                          contentPadding: EdgeInsets.all(0.0),
                          title: Text(widget.arguments['place'] ?? "N/A"),
                          leading: Icon(Icons.location_on),
                          subtitle: Text(widget.arguments['place'] ?? "N/A")),
                      ListTile(contentPadding: EdgeInsets.all(0.0), title: Text("${widget.arguments['fee']}"), leading: Icon(Icons.event_seat)),
                      Text("Description", style: Theme.of(context).textTheme.headline6),
                      Text(widget.arguments['description'],
                          style: Theme.of(context).textTheme.subtitle2.copyWith(fontWeight: FontWeight.normal, color: Colors.grey), maxLines: 4),
                      Row(children: <Widget>[]),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SafeArea(
            child: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.pop(context);
                }),
          )
        ],
      ),
    );
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
