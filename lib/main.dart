import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freeeatsin/core/model/user_login_response_model.dart';
import 'package:freeeatsin/core/provider/user_provider.dart';
import 'package:freeeatsin/core/services/api.dart';
import 'package:freeeatsin/resources/fonts.dart';
import 'package:freeeatsin/resources/strings.dart';
import 'package:freeeatsin/routes.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

File defaultImage;

main() async {
  runApp(App());
  var temp = await rootBundle.load("assets/images/free_eats_logo.png");
  String dir = (await getApplicationDocumentsDirectory()).path;
  defaultImage = await writeToFile(temp, '$dir/logo');
}

Future<File> writeToFile(ByteData data, String path) {
  final buffer = data.buffer;
  return new File(path)
      .writeAsBytes(buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(create: (_) => UserProvider())
      ],
      child: MaterialApp(
          home: DetermineRoute(),
          debugShowCheckedModeBanner: false,
          onGenerateRoute: Router.onGenerateRoute,
          theme: ThemeData(
              fontFamily: Fonts.JAAPOKKI_REGULAR, primarySwatch: Colors.brown)),
    );
  }
}

class DetermineRoute extends StatefulWidget {
  @override
  _DetermineRouteState createState() => _DetermineRouteState();
}

class _DetermineRouteState extends State<DetermineRoute> {
  String phoneNumber;

  @override
  void initState() {
    determineRoute().then((value) => Navigator.pushReplacementNamed(
        context, value,
        arguments: value == Strings.SIGN_UP
            ? {Strings.LOGIN_NUMBER: phoneNumber}
            : {}));
    super.initState();
  }

  Future<String> determineRoute() async {
    SharedPreferences _sharedPrefs = await SharedPreferences.getInstance();
    phoneNumber = _sharedPrefs.get(Strings.LOGIN_NUMBER);
    if (phoneNumber == null) {
      return Strings.LOGIN;
    } else {
      dynamic userDetails = await API.userLogin(phoneNumber);
      print(userDetails);
      if (userDetails is bool && userDetails == false)
        return Strings.SIGN_UP;
      else if (userDetails is UserLoginResponseModel) {
        context.read<UserProvider>().userLoginResponseModel = userDetails;
        return Strings.HOMEPAGE;
      } else
        return Strings.LOGIN;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Loading..."),
          )
        ],
      )),
    );
  }
}
