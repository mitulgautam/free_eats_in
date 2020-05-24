import 'package:flutter/material.dart';
import 'package:freeeatsin/core/provider/user_provider.dart';
import 'package:freeeatsin/resources/themes.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

final spacer12 = SizedBox(width: 12, height: 12);

class _ProfileState extends State<Profile> {
  final profileImageUrl =
      "https://he-s3.s3.amazonaws.com/media/avatars/mitulgautam/resized/180/3ac6ba2img_20190321_221417_860.jpg";

  @override
  void initState() {
    super.initState();
    context.read<UserProvider>().updateUserModel();
  }

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
        body: ChangeNotifierProvider.value(
          value: Provider.of<UserProvider>(context),
          child: Consumer<UserProvider>(
            builder: (_, model, __) => SafeArea(
              child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                      child: Column(children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Material(
                            elevation: 8.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(196.0)),
                            shadowColor: Themes.DARK_BROWN_COOKIE,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(196.0),
                                child: Image.network(profileImageUrl)))),
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(children: <Widget>[
                          Text(
                              model.userLoginResponseModel.message.firstName +
                                  " " +
                                  model.userLoginResponseModel.message.lastName,
                              style: TextStyle(
                                  color: Colors.black, fontSize: 20.0)),
                          Text(model.userLoginResponseModel.message.email,
                              style: TextStyle(
                                  color: Themes.DARK_BROWN_COOKIE,
                                  fontSize: 16.0)),
                          spacer12,
                          Text(
                              model.userLoginResponseModel.message.address ==
                                          null ||
                                      model.userLoginResponseModel.message
                                              .address ==
                                          ""
                                  ? "Please Update Your Address!"
                                  : model
                                      .userLoginResponseModel.message.address,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black, fontSize: 16.0))
                        ])),
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
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16.0),
                                  textAlign: TextAlign.center),
                              Text(
                                  model.userLoginResponseModel.message
                                      .eventPosted
                                      .toString(),
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 26.0),
                                  textAlign: TextAlign.center)
                            ]),
                            Column(children: <Widget>[
                              Text("Event Attended",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16.0),
                                  textAlign: TextAlign.center),
                              Text(
                                  model.userLoginResponseModel.message
                                      .eventAttended
                                      .toString(),
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 26.0),
                                  textAlign: TextAlign.center)
                            ])
                          ])
                    ]))
                  ], crossAxisAlignment: CrossAxisAlignment.center))),
            ),
          ),
        ));
  }
}
