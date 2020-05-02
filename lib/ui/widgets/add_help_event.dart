import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freeeatsin/resources/fonts.dart';
import 'package:freeeatsin/resources/themes.dart';
import 'package:image_picker/image_picker.dart';

class AddHelpEvent extends StatefulWidget {
  @override
  _AddHelpEventState createState() => _AddHelpEventState();
}

class _AddHelpEventState extends State<AddHelpEvent> {
  DateTime _currentDateTime = DateTime.now();
  DateTime _fromDate;
  File _image;
  var _formKey = GlobalKey<FormState>();
  TimeOfDay _timeOfDayStart;

  @override
  Widget build(BuildContext context) {
    return Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        child: SingleChildScrollView(
            child: SafeArea(
                child: Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0, bottom: 16.0),
                    child: Form(
                        key: _formKey,
                        child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                          GestureDetector(
                              onTap: () async {
                                _image = await ImagePicker.pickImage(source: ImageSource.gallery);
                                setState(() {});
                              },
                              child: DottedBorder(
                                  dashPattern: [4, 8, 1],
                                  color: Themes.DARK_BROWN_COOKIE,
                                  child: Align(
                                      alignment: Alignment.center,
                                      child: _image == null
                                          ? SizedBox(
                                              width: 64.0,
                                              height: 64.0,
                                              child: Align(alignment: Alignment.center, child: Icon(Icons.image, color: Themes.DARK_BROWN_COOKIE)),
                                            )
                                          : Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Image.file(_image),
                                            )))),
                          TextFormField(decoration: InputDecoration(labelText: "Event Name")),
                          TextFormField(decoration: InputDecoration(labelText: "Event Description")),
                          TextFormField(decoration: InputDecoration(labelText: "Address")),
                          Padding(padding: const EdgeInsets.only(top: 16.0), child: Text("Help Type")),
                          DropdownButton(items: [
                            DropdownMenuItem(child: Text("Cloth")),
                          ], onChanged: (_) {}, isExpanded: true),
                          Padding(
                              padding: const EdgeInsets.only(top: 16.0),
                              child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <Widget>[
                                FlatButton(
                                    padding: EdgeInsets.all(0.0),
                                    onPressed: () async {
                                      DateTime _tempDate = await showDatePicker(
                                          context: context,
                                          initialDate: _currentDateTime,
                                          firstDate: _currentDateTime,
                                          lastDate: DateTime(_currentDateTime.year + 1, _currentDateTime.month, _currentDateTime.day),
                                          confirmText: "Select FROM",
                                          cancelText: "Cancel");
                                      setState(() {
                                        _fromDate = _tempDate;
                                      });
                                    },
                                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                                      Text("Date", style: TextStyle(color: Themes.DARK_BROWN_COOKIE)),
                                      Container(
                                          color: Colors.grey[200],
                                          padding: EdgeInsets.only(left: 4.0, right: 4.0, top: 4.0, bottom: 4.0),
                                          child: Text(_fromDate == null
                                              ? "DD/MM/YYYY"
                                              : _fromDate.day.toString() + "/" + _fromDate.month.toString() + "/" + _fromDate.year.toString()))
                                    ])),
                                FlatButton(
                                    padding: EdgeInsets.all(0.0),
                                    onPressed: () async {
                                      TimeOfDay _tempDate = await showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now(),
                                          builder: (context, child) => Theme(
                                              data: ThemeData(
                                                  primaryColor: Colors.white,
                                                  accentColor: Themes.DARK_BROWN_COOKIE,
                                                  primarySwatch: Colors.brown,
                                                  fontFamily: Fonts.JAAPOKKI_REGULAR),
                                              child: child));
                                      setState(() {
                                        _timeOfDayStart = _tempDate;
                                      });
                                    },
                                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                                      Text("From", style: TextStyle(color: Themes.DARK_BROWN_COOKIE)),
                                      Container(
                                          color: Colors.grey[200],
                                          padding: EdgeInsets.only(left: 4.0, right: 4.0, top: 4.0, bottom: 4.0),
                                          child: Text(_timeOfDayStart == null
                                              ? "Start Time"
                                              : _timeOfDayStart.hour.toString() + ":" + _timeOfDayStart.minute.toString()))
                                    ]))
                              ])),
                          Padding(
                              padding: const EdgeInsets.only(top: 16.0, bottom: 4.0),
                              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
                                OutlineButton(
                                    onPressed: () => Navigator.pop(context),
                                    borderSide: BorderSide(color: Themes.DARK_BROWN_COOKIE),
                                    child: Text("Cancel", style: TextStyle(color: Themes.DARK_BROWN_COOKIE))),
                                SizedBox(width: 8.0),
                                RaisedButton(
                                  color: Themes.DARK_BROWN_COOKIE,
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("Add", style: TextStyle(color: Colors.white)),
                                )
                              ]))
                        ]))))));
  }
}
