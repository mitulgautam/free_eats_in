import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freeeatsin/resources/themes.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

final spacer12 = SizedBox(width: 12, height: 12);

class _ProfileState extends State<Profile> {
  final profileImageUrl =
      "https://he-s3.s3.amazonaws.com/media/avatars/mitulgautam/resized/180/3ac6ba2img_20190321_221417_860.jpg";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF5F7F9),
        appBar: AppBar(
            centerTitle: true,
            leading: GestureDetector(
                child: Icon(Icons.arrow_back_ios, color: Colors.black),
                onTap: () => Navigator.pop(context)),
            backgroundColor: Colors.white,
            elevation: 0.0,
            title: Text("Profile", style: TextStyle(color: Colors.black))),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(children: <Widget>[
              Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                        flex: 1,
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Material(
                                elevation: 8.0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(196.0)),
                                shadowColor: Themes.DARK_BROWN_COOKIE,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(196.0),
                                    child: Stack(
                                        alignment: Alignment.bottomCenter,
                                        children: <Widget>[
                                          Image.network(profileImageUrl),
                                          Icon(Icons.camera_alt,
                                              color: Colors.white70)
                                        ]))))),
                    Expanded(
                        flex: 2,
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(children: <Widget>[
                              Text("Mitul Gautam",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20.0)),
                              Text("mitulgautamofficial@gmail.com",
                                  style: TextStyle(
                                      color: Themes.DARK_BROWN_COOKIE,
                                      fontSize: 16.0)),
                              spacer12,
//            Text("Flutter Developer", style: TextStyle(color: Colors.black, fontSize: 20.0)),
                              Text(
                                  "KH-001, Kavinagr Ghaiziabad,\nU.P. India 201003",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16.0))
                            ])))
                  ]),
              spacer12,
              Card(
                  child: Column(children: <Widget>[
                Text("NGO Volunteer",
                    style: TextStyle(
                        color: Themes.DARK_BROWN_COOKIE, fontSize: 16.0),
                    textAlign: TextAlign.center),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(children: <Widget>[
                        Text("Event Posted",
                            style:
                                TextStyle(color: Colors.black, fontSize: 16.0),
                            textAlign: TextAlign.center),
                        Text("15",
                            style:
                                TextStyle(color: Colors.black, fontSize: 26.0),
                            textAlign: TextAlign.center)
                      ]),
                      Column(children: <Widget>[
                        Text("Event Attended",
                            style:
                                TextStyle(color: Colors.black, fontSize: 16.0),
                            textAlign: TextAlign.center),
                        Text("8",
                            style:
                                TextStyle(color: Colors.black, fontSize: 26.0),
                            textAlign: TextAlign.center)
                      ])
                    ])
              ]))
            ], crossAxisAlignment: CrossAxisAlignment.start)));
  }
}
