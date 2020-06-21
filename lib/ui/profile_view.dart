import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freeeatsin/core/provider/user_provider.dart';
import 'package:freeeatsin/resources/themes.dart';
import 'package:freeeatsin/ui/widgets/food_point_profile.dart';
import 'package:freeeatsin/ui/widgets/help_profile.dart';
import 'package:freeeatsin/ui/widgets/update_profile_view.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

final spacer12 = SizedBox(width: 12, height: 12);

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    super.initState();
    context.read<UserProvider>().updateUserModel();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: Provider.of<UserProvider>(context),
        child: Consumer<UserProvider>(
            builder: (_, model, __) => DefaultTabController(
                length: 2,
                child: Scaffold(
                    backgroundColor: Color(0xffF5F7F9),
                    appBar: AppBar(
                        centerTitle: true,
                        leading: GestureDetector(
                            child:
                                Icon(Icons.arrow_back_ios, color: Colors.black),
                            onTap: () => Navigator.pop(context)),
                        backgroundColor: Colors.white,
                        elevation: 0.0,
                        title: Text("Profile",
                            style: TextStyle(color: Colors.black)),
                        actions: <Widget>[
                          IconButton(
                              icon: Icon(Icons.edit,
                                  color: Themes.DARK_BROWN_COOKIE),
                              onPressed: () async {
                                await showDialog(
                                    context: context,
                                    builder: (context) => Dialog(
                                        elevation: 4.0,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(16.0)),
                                        child: UpdateProfileView(
                                            city: model.profileResponseModel
                                                .message.city,
                                            address: model.profileResponseModel
                                                .message.address,
                                            banner: model.profileResponseModel
                                                .message.banner,
                                            email: model.profileResponseModel
                                                .message.email,
                                            firstName: model
                                                .profileResponseModel
                                                .message
                                                .firstName,
                                            bio: model.profileResponseModel
                                                .message.bio,
                                            state: model.profileResponseModel
                                                .message.state,
                                            lastName: model.profileResponseModel
                                                .message.lastName)));
                              })
                        ]),
                    body: SafeArea(
                        child: model.profileResponseModel == null
                            ? Center(child: CircularProgressIndicator())
                            : Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(children: <Widget>[
                                  Row(children: <Widget>[
                                    Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Material(
                                            elevation: 2.0,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        196.0)),
                                            shadowColor:
                                                Themes.DARK_BROWN_COOKIE,
                                            child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        196.0),
                                                child: Image.network(
                                                    model.userLoginResponseModel
                                                        .message.image,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            3,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            3,
                                                    fit: BoxFit.cover)))),
                                    Expanded(
                                        child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                      model.userLoginResponseModel
                                                              .message.firstName +
                                                          " " +
                                                          model
                                                              .userLoginResponseModel
                                                              .message
                                                              .lastName,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 20.0)),
                                                  Text(
                                                      model
                                                          .userLoginResponseModel
                                                          .message
                                                          .email,
                                                      style: TextStyle(
                                                          color: Themes
                                                              .DARK_BROWN_COOKIE,
                                                          fontSize: 16.0)),
                                                  spacer12,
                                                  Text(
                                                      model
                                                          .userLoginResponseModel
                                                          .message
                                                          .bio,
                                                      style: TextStyle(
                                                          color: Themes
                                                              .DARK_BROWN_COOKIE,
                                                          fontSize: 16.0)),
                                                  spacer12,
                                                  Text(
                                                      model.userLoginResponseModel.message
                                                                      .address ==
                                                                  null ||
                                                              model
                                                                      .userLoginResponseModel
                                                                      .message
                                                                      .city ==
                                                                  ""
                                                          ? "Please Update Your Address!"
                                                          : model
                                                              .userLoginResponseModel
                                                              .message
                                                              .address,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 16.0))
                                                ])))
                                  ]),
                                  spacer12,
                                  Card(
                                      child: Column(children: <Widget>[
                                    Text("NGO Volunteer",
                                        style: TextStyle(
                                            color: Themes.DARK_BROWN_COOKIE,
                                            fontSize: 16.0),
                                        textAlign: TextAlign.center),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          Column(children: <Widget>[
                                            Text("Event Posted",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16.0),
                                                textAlign: TextAlign.center),
                                            Text(
                                                model.userLoginResponseModel
                                                    .message.eventPosted
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 26.0),
                                                textAlign: TextAlign.center)
                                          ]),
                                          Column(children: <Widget>[
                                            Text("Event Attended",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16.0),
                                                textAlign: TextAlign.center),
                                            Text(
                                                model.userLoginResponseModel
                                                    .message.eventAttended
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 26.0),
                                                textAlign: TextAlign.center)
                                          ])
                                        ])
                                  ])),
                                  spacer12,
                                  TabBar(tabs: [
                                    Tab(
                                        child: Text("Food Point",
                                            style: TextStyle(
                                                color:
                                                    Themes.DARK_BROWN_COOKIE))),
                                    Tab(
                                        child: Text("Help",
                                            style: TextStyle(
                                                color:
                                                    Themes.DARK_BROWN_COOKIE)))
                                  ]),
                                  Expanded(
                                      child: TabBarView(children: [
                                    FoodPointEventList(
                                        foodPointEvent: model
                                            .profileResponseModel
                                            .message
                                            .events),
                                    HelpCard(
                                        helpCard: model
                                            .profileResponseModel.message.helps)
                                  ]))
                                ])))))));
  }
}
