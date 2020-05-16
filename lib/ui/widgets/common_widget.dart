import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommonWidget {
  static loading(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
            child: CircularProgressIndicator(backgroundColor: Colors.white)));
  }
}
