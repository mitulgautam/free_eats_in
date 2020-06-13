import 'dart:convert';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:freeeatsin/core/model/city_model.dart';
import 'package:freeeatsin/core/model/create_help_event_model.dart';
import 'package:freeeatsin/core/provider/user_provider.dart';
import 'package:freeeatsin/core/services/api.dart';
import 'package:freeeatsin/resources/fonts.dart';
import 'package:freeeatsin/resources/themes.dart';
import 'package:freeeatsin/ui/widgets/common_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddHelpEvent extends StatefulWidget {
  final bool isUpdate;
  final String eventName;
  final String eventDescription;
  final String address;
  final String state;
  final String helpType;
  final DateTime date;
  final TimeOfDay timeOfDay;
  final String banner;
  final String postby;
  final String place;
  final int id;
  final String city;

  const AddHelpEvent(
      {Key key,
      this.isUpdate,
      this.eventName,
      this.eventDescription,
      this.address,
      this.helpType,
      this.date,
      this.timeOfDay,
      this.city,
      this.state,
      this.banner,
      this.id,
      this.postby,
      this.place})
      : super(key: key);

  @override
  _AddHelpEventState createState() => _AddHelpEventState();
}

class _AddHelpEventState extends State<AddHelpEvent> {
  DateTime _currentDateTime = DateTime.now();
  DateTime _fromDate;
  File _image;
  var _formKey = GlobalKey<FormState>();
  TimeOfDay _timeOfDayStart;

  TextEditingController _eventName;
  TextEditingController _eventDescription;
  TextEditingController _address;
  TextEditingController _helpType;

  StateAndCity data;
  States _states;
  String _city;
  bool isLoading = true;
  bool autoValidate = false;
  String errorText;

  String _stateError = "Please select state!";
  String _cityError = "Please select city!";
  bool _stateErrorStatus = false, _cityErrorStatus = false;

  @override
  void initState() {
    CommonWidget.loadCrosswordAsset("assets/images/cities.json").then((value) {
      data = StateAndCity.fromJson(json.decode(value));
      setState(() {
        if (widget.isUpdate) {
          _states =
              data.state.where((element) => element.name == widget.state).first;
          _city =
              _states.cities.where((element) => element == widget.city).first;
        }
        isLoading = false;
      });
    });
    _eventName =
        TextEditingController(text: widget.isUpdate ? widget.eventName : "");
    _address =
        TextEditingController(text: widget.isUpdate ? widget.address : "");
    _eventDescription = TextEditingController(
        text: widget.isUpdate ? widget.eventDescription : "");
    _helpType =
        TextEditingController(text: widget.isUpdate ? widget.helpType : "");
    if (widget.isUpdate) {
      _timeOfDayStart = widget.timeOfDay;
      _fromDate = widget.date;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        backgroundColor: Colors.white,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        child: SingleChildScrollView(
            child: SafeArea(
                child: isLoading
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: CircularProgressIndicator()))
                    : Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, right: 16.0, top: 16.0, bottom: 16.0),
                        child: Form(
                            key: _formKey,
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  widget.isUpdate
                                      ? SizedBox()
                                      : GestureDetector(
                                          onTap: () async {
                                            _image =
                                                await ImagePicker.pickImage(
                                                    source:
                                                        ImageSource.gallery);
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
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: Icon(
                                                                  Icons.image,
                                                                  color: Themes
                                                                      .DARK_BROWN_COOKIE)),
                                                        )
                                                      : Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Image.file(
                                                              _image),
                                                        )))),
                                  TextFormField(
                                      autovalidate: autoValidate,
                                      validator: (_) => _.length < 3
                                          ? "Event name should be greater than 3"
                                          : null,
                                      controller: _eventName,
                                      decoration: InputDecoration(
                                          labelText: "Event Name")),
                                  TextFormField(
                                      autovalidate: autoValidate,
                                      validator: (_) => _.length < 15
                                          ? "Event description should be greater than 15 letters"
                                          : null,
                                      controller: _eventDescription,
                                      decoration: InputDecoration(
                                          labelText: "Event Description")),
                                  TextFormField(
                                      autovalidate: autoValidate,
                                      validator: (_) => _.length < 10
                                          ? "Address should be greater than 10 letters"
                                          : null,
                                      controller: _address,
                                      decoration: InputDecoration(
                                          labelText: "Address")),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: DropdownButton<States>(
                                        isExpanded: true,
                                        value: _states,
                                        onChanged: (States newValue) {
                                          setState(() {
                                            _city = null;
                                            _states = newValue;
                                          });
                                        },
                                        items: data.state.map((States state) {
                                          return DropdownMenuItem<States>(
                                              value: state,
                                              child: Text(state.name));
                                        }).toList()),
                                  ),
                                  _stateErrorStatus
                                      ? Text(_stateError,
                                          style: TextStyle(color: Colors.red))
                                      : SizedBox.shrink(),
                                  _states == null
                                      ? SizedBox()
                                      : Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8.0),
                                          child: DropdownButton<String>(
                                              isExpanded: true,
                                              hint: Text("Select City"),
                                              value: _city,
                                              onChanged: (String newValue) {
                                                setState(() {
                                                  _city = newValue;
                                                });
                                              },
                                              items: data.state
                                                  .where((element) =>
                                                      element.name ==
                                                      _states.name)
                                                  .first
                                                  .cities
                                                  .map((String city) {
                                                return DropdownMenuItem<String>(
                                                    value: city,
                                                    child: Text(city));
                                              }).toList()),
                                        ),
                                  _cityErrorStatus
                                      ? Text(_cityError,
                                          style: TextStyle(color: Colors.red))
                                      : SizedBox.shrink(),
                                  TextFormField(
                                      autovalidate: autoValidate,
                                      validator: (_) => _.length < 3
                                          ? "Help Type should be greater than 3 letters"
                                          : null,
                                      controller: _helpType,
                                      decoration: InputDecoration(
                                          labelText: "Help Type")),
                                  Padding(
                                      padding: const EdgeInsets.only(top: 16.0),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            FlatButton(
                                                padding: EdgeInsets.all(0.0),
                                                onPressed: () async {
                                                  DateTime _tempDate =
                                                      await showDatePicker(
                                                          context: context,
                                                          initialDate:
                                                              _currentDateTime,
                                                          firstDate:
                                                              _currentDateTime,
                                                          lastDate: DateTime(
                                                              _currentDateTime.year +
                                                                  1,
                                                              _currentDateTime
                                                                  .month,
                                                              _currentDateTime
                                                                  .day),
                                                          confirmText:
                                                              "Select FROM",
                                                          cancelText: "Cancel");
                                                  setState(() {
                                                    _fromDate = _tempDate;
                                                  });
                                                },
                                                child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Text("Date",
                                                          style: TextStyle(
                                                              color: Themes
                                                                  .DARK_BROWN_COOKIE)),
                                                      Container(
                                                          color: Colors
                                                              .grey[200],
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 4.0,
                                                                  right: 4.0,
                                                                  top: 4.0,
                                                                  bottom: 4.0),
                                                          child: Text(_fromDate ==
                                                                  null
                                                              ? "DD/MM/YYYY"
                                                              : _fromDate.day
                                                                      .toString() +
                                                                  "/" +
                                                                  _fromDate
                                                                      .month
                                                                      .toString() +
                                                                  "/" +
                                                                  _fromDate.year
                                                                      .toString()))
                                                    ])),
                                            FlatButton(
                                                padding: EdgeInsets.all(0.0),
                                                onPressed: () async {
                                                  TimeOfDay _tempDate = await showTimePicker(
                                                      context: context,
                                                      initialTime:
                                                          TimeOfDay.now(),
                                                      builder: (context, child) => Theme(
                                                          data: ThemeData(
                                                              primaryColor:
                                                                  Colors.white,
                                                              accentColor: Themes
                                                                  .DARK_BROWN_COOKIE,
                                                              primarySwatch:
                                                                  Colors.brown,
                                                              fontFamily: Fonts
                                                                  .JAAPOKKI_REGULAR),
                                                          child: child));
                                                  setState(() {
                                                    _timeOfDayStart = _tempDate;
                                                  });
                                                },
                                                child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Text("From",
                                                          style: TextStyle(
                                                              color: Themes
                                                                  .DARK_BROWN_COOKIE)),
                                                      Container(
                                                          color:
                                                              Colors.grey[200],
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 4.0,
                                                                  right: 4.0,
                                                                  top: 4.0,
                                                                  bottom: 4.0),
                                                          child: Text(_timeOfDayStart ==
                                                                  null
                                                              ? "Start Time"
                                                              : _timeOfDayStart
                                                                      .hour
                                                                      .toString() +
                                                                  ":" +
                                                                  _timeOfDayStart
                                                                      .minute
                                                                      .toString()))
                                                    ]))
                                          ])),
                                  Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(errorText ?? "",
                                          style: TextStyle(color: Colors.red))),
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          top: 16.0, bottom: 4.0),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: <Widget>[
                                            OutlineButton(
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                                borderSide: BorderSide(
                                                    color: Themes
                                                        .DARK_BROWN_COOKIE),
                                                child: Text("Cancel",
                                                    style: TextStyle(
                                                        color: Themes
                                                            .DARK_BROWN_COOKIE))),
                                            SizedBox(width: 8.0),
                                            RaisedButton(
                                              color: Themes.DARK_BROWN_COOKIE,
                                              onPressed: () async {
                                                setState(() {
                                                  autoValidate = true;
                                                });
                                                errorText = "";
                                                if (_image == null &&
                                                    !widget.isUpdate)
                                                  errorText +=
                                                      " Select Event Banner.";
                                                if (_timeOfDayStart == null)
                                                  errorText +=
                                                      " Select Start Time.";
                                                if (_fromDate == null)
                                                  errorText +=
                                                      " Select Date for event";

                                                if (_states == null) {
                                                  setState(() {
                                                    _stateErrorStatus = true;
                                                  });
                                                } else {
                                                  setState(() {
                                                    _stateErrorStatus = false;
                                                  });
                                                }
                                                if (_city == null) {
                                                  setState(() {
                                                    _cityErrorStatus = true;
                                                  });
                                                } else {
                                                  setState(() {
                                                    _cityErrorStatus = false;
                                                  });
                                                }
                                                setState(() {
                                                  errorText.trim();
                                                });
                                                if (errorText == "" &&
                                                    _formKey.currentState
                                                        .validate() &&
                                                    !_cityErrorStatus &&
                                                    !_stateErrorStatus) {
                                                  CommonWidget.loading(context);
                                                  CreateHelpEventModel help =
                                                      CreateHelpEventModel(
                                                          address:
                                                              _address.text,
                                                          city: _city,
                                                          description:
                                                              _eventDescription
                                                                  .text,
                                                          name: _eventName.text,
                                                          type: _helpType.text,
                                                          date: _fromDate,
                                                          startTime:
                                                              "${_timeOfDayStart.hour < 10 ? ("0${_timeOfDayStart.hour}") : _timeOfDayStart.hour}:${_timeOfDayStart.minute < 10 ? ("0${_timeOfDayStart.minute}") : _timeOfDayStart.minute}:00",
                                                          banner: _image);
                                                  bool response;
                                                  if (widget.isUpdate) {
                                                    response = await API
                                                        .updateHelpEvent(
                                                            help,
                                                            widget.banner,
                                                            widget.id,
                                                            widget.postby,
                                                            widget.place,
                                                            widget.state,
                                                            Provider.of<UserProvider>(
                                                                    context,listen: false)
                                                                .profileResponseModel
                                                                .message
                                                                .id);
                                                  } else {
                                                    response = await API
                                                        .postHelpEvent(help);
                                                  }
                                                  Navigator.pop(context);
                                                  Navigator.pop(context);

                                                  !response
                                                      ? await showDialog(
                                                          context: context,
                                                          barrierDismissible:
                                                              false,
                                                          builder: (context) =>
                                                              AlertDialog(
                                                                  title: Text(
                                                                      "Error"),
                                                                  actions: <
                                                                      Widget>[
                                                                    MaterialButton(
                                                                        onPressed: () =>
                                                                            Navigator.pop(
                                                                                context),
                                                                        child: Text(
                                                                            "Close",
                                                                            style:
                                                                                TextStyle(color: Themes.DARK_BROWN_COOKIE)))
                                                                  ],
                                                                  content: Text(
                                                                      "Some error has occurred, Event has not been created!")))
                                                      : await showDialog(
                                                          context: context,
                                                          barrierDismissible:
                                                              false,
                                                          builder: (context) =>
                                                              AlertDialog(
                                                                  title: Text(
                                                                      "Success"),
                                                                  actions: <
                                                                      Widget>[
                                                                    MaterialButton(
                                                                        onPressed: () =>
                                                                            Navigator.pop(
                                                                                context),
                                                                        child: Text(
                                                                            "Close",
                                                                            style:
                                                                                TextStyle(color: Themes.DARK_BROWN_COOKIE)))
                                                                  ],
                                                                  content: Text(widget
                                                                          .isUpdate
                                                                      ? "Event has been updated!"
                                                                      : "Event has been created!")));
                                                }
                                              },
                                              child: Text("Add",
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                            )
                                          ]))
                                ]))))));
  }
}
