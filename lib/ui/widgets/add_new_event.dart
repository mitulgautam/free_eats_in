import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freeeatsin/resources/fonts.dart';
import 'package:freeeatsin/resources/strings.dart';
import 'package:freeeatsin/resources/themes.dart';
import 'package:image_picker/image_picker.dart';

class AddNewEvent extends StatefulWidget {
  @override
  _AddNewEventState createState() => _AddNewEventState();
}

class _AddNewEventState extends State<AddNewEvent> {
  Cost _costType = Cost.PAID;
  Frequency _eventFrequency;
  DateTime _currentDateTime = DateTime.now();
  DateTime _fromDate;
  List<String> _itemList = [];
  TextEditingController _item = TextEditingController();
  var _animListState = GlobalKey<AnimatedListState>();
  File _image;
  var _formKey = GlobalKey<FormState>();
  TimeOfDay _timeOfDayStart;
  TimeOfDay _timeOfDayEnd;

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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
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
                                child: Align(
                                    alignment: Alignment.center,
                                    child: Icon(
                                      Icons.image,
                                      color: Themes.DARK_BROWN_COOKIE,
                                    )),
                              )
                            : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.file(_image),
                              ),
                      ),
                    ),
                  ),
                  TextFormField(decoration: InputDecoration(labelText: "Event Name")),
                  TextFormField(decoration: InputDecoration(labelText: "Organizer Name")),
                  TextFormField(decoration: InputDecoration(labelText: "Event Description")),
                  TextFormField(decoration: InputDecoration(labelText: "Address")),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Text("Fee Type"),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text(
                            _costType == Cost.PAID ? "PAID" : "FREE",
                            style: TextStyle(fontSize: 36.0, color: _costType == Cost.PAID ? Colors.amber : Colors.green),
                          ),
                          Text(
                            _costType == Cost.PAID ? "Fill Event Fees" : "OMG! Its Free",
                            style: TextStyle(fontSize: 12.0, color: _costType == Cost.PAID ? Colors.amber : Colors.green),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Transform.scale(
                            scale: 1.5,
                            child: Switch(
                                value: _costType == Cost.FREE,
                                onChanged: (_) {
                                  setState(() {
                                    _costType = _ ? Cost.FREE : Cost.PAID;
                                  });
                                },
                                activeThumbImage: AssetImage("assets/images/donut.png"),
                                inactiveThumbImage: AssetImage("assets/images/coin.png"))),
                      )
                    ],
                  ),
                  _costType == Cost.FREE
                      ? SizedBox()
                      : TextFormField(
                          decoration: InputDecoration(labelText: "Event Fee"),
                          textInputAction: TextInputAction.go,
                        ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: TextFormField(
                          validator: (_) {
                            if (_.length < 3) return "Food name should be greater than 3";
                            return null;
                          },
                          decoration: InputDecoration(labelText: "Items"),
                          controller: _item,
                        ),
                      ),
                      IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();
                              setState(() {
                                _itemList.add(_item.text.toString());
                              });
                              _item.clear();
                              _animListState.currentState.insertItem(0, duration: Duration(milliseconds: 0));
                            }
                          })
                    ],
                  ),
                  AnimatedList(
                    key: _animListState,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    initialItemCount: _itemList.length,
                    itemBuilder: (context, i, _anim) => Row(
                      children: <Widget>[
                        IconButton(
                            icon: Icon(Icons.close, color: Themes.DARK_BROWN_COOKIE),
                            onPressed: () {
                              _animListState.currentState
                                  .removeItem(i, (context, animation) => Text(_itemList[i], style: TextStyle(color: Themes.DARK_BROWN_COOKIE)));
                              _itemList.removeAt(i);
                            }),
                        Expanded(child: Text(_itemList[i], style: TextStyle(color: Themes.DARK_BROWN_COOKIE)))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
                    child: Text("Event Frequency"),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: ToggleButtons(
                        children: [
                          Text("Once"),
                          Text("Daily"),
                          Text("Random"),
                        ],
                        selectedColor: Colors.white,
                        fillColor: Themes.DARK_BROWN_COOKIE,
                        isSelected: [_eventFrequency == Frequency.ONCE, _eventFrequency == Frequency.DAILY, _eventFrequency == Frequency.RANDOM],
                        onPressed: (_) {
                          setState(() {
                            _eventFrequency = _ == 0 ? Frequency.ONCE : _ == 1 ? Frequency.DAILY : Frequency.RANDOM;
                          });
                        },
                        borderRadius: BorderRadius.circular(8.0)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        FlatButton(
                          padding: EdgeInsets.all(0.0),
                          onPressed: () async {
                            DateTime _tempDate = await showDatePicker(
                              context: context,
                              initialDate: _currentDateTime,
                              firstDate: _currentDateTime,
                              lastDate: DateTime(_currentDateTime.year + 1, _currentDateTime.month, _currentDateTime.day),
                              confirmText: "Select FROM",
                              cancelText: "Cancel",
                            );
                            setState(() {
                              _fromDate = _tempDate;
                            });
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("Date", style: TextStyle(color: Themes.DARK_BROWN_COOKIE)),
                              Container(
                                color: Colors.grey[200],
                                padding: EdgeInsets.only(left: 4.0, right: 4.0, top: 4.0, bottom: 4.0),
                                child: Text(_fromDate == null
                                    ? "DD/MM/YYYY"
                                    : _fromDate.day.toString() + "/" + _fromDate.month.toString() + "/" + _fromDate.year.toString()),
                              ),
                            ],
                          ),
                        ),
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
                                        fontFamily: Fonts.JAAPOKKI_REGULAR,
                                      ),
                                      child: child,
                                    ));
                            setState(() {
                              _timeOfDayStart = _tempDate;
                            });
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("From", style: TextStyle(color: Themes.DARK_BROWN_COOKIE)),
                              Container(
                                  color: Colors.grey[200],
                                  padding: EdgeInsets.only(left: 4.0, right: 4.0, top: 4.0, bottom: 4.0),
                                  child:
                                      Text(_timeOfDayStart == null ? "Start Time" : _timeOfDayStart.hour.toString() + ":" + _timeOfDayStart.minute.toString())),
                            ],
                          ),
                        ),
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
                                        fontFamily: Fonts.JAAPOKKI_REGULAR,
                                      ),
                                      child: child,
                                    ));
                            setState(() {
                              _timeOfDayEnd = _tempDate;
                            });
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("To", style: TextStyle(color: Themes.DARK_BROWN_COOKIE)),
                              Container(
                                  color: Colors.grey[200],
                                  padding: EdgeInsets.only(left: 4.0, right: 4.0, top: 4.0, bottom: 4.0),
                                  child: Text(_timeOfDayEnd == null ? "End Time" : _timeOfDayEnd.hour.toString() + ":" + _timeOfDayEnd.minute.toString())),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0, bottom: 4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        OutlineButton(
                          onPressed: () => Navigator.pop(context),
                          borderSide: BorderSide(color: Themes.DARK_BROWN_COOKIE),
                          child: Text(
                            "Cancel",
                            style: TextStyle(color: Themes.DARK_BROWN_COOKIE),
                          ),
                        ),
                        SizedBox(width: 8.0),
                        RaisedButton(
                          color: Themes.DARK_BROWN_COOKIE,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Submit",
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
