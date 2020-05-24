import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CommonWidget {
  static loading(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
            child: CircularProgressIndicator(backgroundColor: Colors.white)));
  }

  static Future<String> loadCrosswordAsset(String path) async {
    return await rootBundle.loadString(path);
  }
}
