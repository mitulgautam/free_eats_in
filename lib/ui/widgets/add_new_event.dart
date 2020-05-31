import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:freeeatsin/core/model/city_model.dart';
import 'package:freeeatsin/core/model/create_food_point_event_model.dart';
import 'package:freeeatsin/core/provider/user_provider.dart';
import 'package:freeeatsin/core/services/api.dart';
import 'package:freeeatsin/resources/fonts.dart';
import 'package:freeeatsin/resources/strings.dart';
import 'package:freeeatsin/resources/themes.dart';
import 'package:freeeatsin/ui/widgets/common_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddNewFoodPointEvent extends StatefulWidget {
  @override
  _AddNewFoodPointEventState createState() => _AddNewFoodPointEventState();
}

class _AddNewFoodPointEventState extends State<AddNewFoodPointEvent> {
  Cost _costType = Cost.PAID;
  Frequency _eventFrequency;
  DateTime _currentDateTime = DateTime.now();
  List<DateTime> _dates = [];
  DateTime _fromDate;
  DateTime _toDate;
  List<String> _itemList = [];
  TextEditingController _item;
  TextEditingController _eventName;
  TextEditingController _organizerName;
  TextEditingController _eventDescription;
  TextEditingController _address;
  TextEditingController _fees;
  TextEditingController _place;

  var _animListState = GlobalKey<AnimatedListState>();
  File _image;
  var _formKey = GlobalKey<FormState>();
  TimeOfDay _timeOfDayStart;
  TimeOfDay _timeOfDayEnd;
  CreateFoodPointEventModel _model;
  bool autoValidate = false;

  final City selectCity = City(city: "Select City");
  List<City> data;
  List<City> _cities = [];
  States _states;
  City _city;

  bool isLoading = true;
  String errorText;

  @override
  void initState() {
    errorText = "";
    CommonWidget.loadCrosswordAsset("assets/images/cities.json").then((value) {
      data = cityFromJson(value);
      data.sort((a, b) => a.city.compareTo(b.city));
      setState(() {
        isLoading = false;
      });
    });
    _model = CreateFoodPointEventModel();
    _fees = TextEditingController();
    _eventName = TextEditingController();
    _organizerName = TextEditingController();
    _address = TextEditingController();
    _eventDescription = TextEditingController();
    _item = TextEditingController();
    _place = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _fees.dispose();
    _eventName.dispose();
    _item.dispose();
    _organizerName.dispose();
    _address.dispose();
    _eventDescription.dispose();
    super.dispose();
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
                        child: Center(child: CircularProgressIndicator()),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, right: 16.0, top: 16.0, bottom: 16.0),
                        child: Form(
                            key: _formKey,
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () async {
                                      _image = await ImagePicker.pickImage(
                                          source: ImageSource.gallery);
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
                                                      color: Themes
                                                          .DARK_BROWN_COOKIE,
                                                    )),
                                              )
                                            : Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Image.file(_image),
                                              ),
                                      ),
                                    ),
                                  ),
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
                                      validator: (_) => _.length < 3
                                          ? "Organizer name should be greater than 3"
                                          : null,
                                      controller: _organizerName,
                                      decoration: InputDecoration(
                                          labelText: "Organizer Name")),
                                  TextFormField(
                                      autovalidate: autoValidate,
                                      validator: (_) => _.length < 15
                                          ? "Event name should be greater than 15 letters"
                                          : null,
                                      controller: _eventDescription,
                                      decoration: InputDecoration(
                                          labelText: "Event Description")),
                                  TextFormField(
                                      autovalidate: autoValidate,
                                      validator: (_) => _.length < 3
                                          ? "Place name should be greater than 3 letters"
                                          : null,
                                      controller: _place,
                                      decoration:
                                          InputDecoration(labelText: "Place")),
                                  TextFormField(
                                      autovalidate: autoValidate,
                                      validator: (_) => _.length < 15
                                          ? "Address should be greater than 10 letters"
                                          : null,
                                      controller: _address,
                                      decoration: InputDecoration(
                                          labelText: "Address")),
                                  DropdownButtonFormField<States>(
                                      autovalidate: autoValidate,
                                      validator: (_) => _ == null
                                          ? "Please Select State"
                                          : null,
                                      decoration:
                                          InputDecoration(labelText: "State"),
                                      isExpanded: true,
                                      value: _states,
                                      onChanged: (States newValue) {
                                        setState(() {
                                          _city = null;
                                          _states = newValue;
                                        });
                                      },
                                      items:
                                          States.values.map((States classType) {
                                        return DropdownMenuItem<States>(
                                            value: classType,
                                            child: Text(stateValues
                                                .reverse[classType]));
                                      }).toList()),
                                  DropdownButtonFormField<City>(
                                      validator: (_) => _ == null
                                          ? "Please Select City"
                                          : null,
                                      autovalidate: autoValidate,
                                      decoration:
                                          InputDecoration(labelText: "City"),
                                      isExpanded: true,
                                      value: _city ?? null,
                                      onChanged: (City newValue) {
                                        setState(() {
                                          _city = newValue;
                                        });
                                      },
                                      items: data
                                          .where((element) =>
                                              element.state == _states)
                                          .map((City classType) {
                                        return DropdownMenuItem<City>(
                                            value: classType,
                                            child: Text(classType.city));
                                      }).toList()),
                                  Padding(
                                      padding: const EdgeInsets.only(top: 16.0),
                                      child: Text("Fee Type")),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Column(children: <Widget>[
                                          Text(
                                              _costType == Cost.PAID
                                                  ? "PAID"
                                                  : "FREE",
                                              style: TextStyle(
                                                  fontSize: 36.0,
                                                  color: _costType == Cost.PAID
                                                      ? Colors.amber
                                                      : Colors.green)),
                                          Text(
                                              _costType == Cost.PAID
                                                  ? "Fill Event Fees"
                                                  : "OMG! Its Free",
                                              style: TextStyle(
                                                  fontSize: 12.0,
                                                  color: _costType == Cost.PAID
                                                      ? Colors.amber
                                                      : Colors.green))
                                        ]),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Transform.scale(
                                              scale: 1.5,
                                              child: Switch(
                                                  value: _costType == Cost.FREE,
                                                  onChanged: (_) {
                                                    setState(() {
                                                      _costType = _
                                                          ? Cost.FREE
                                                          : Cost.PAID;
                                                    });
                                                  },
                                                  activeThumbImage: AssetImage(
                                                      "assets/images/donut.png"),
                                                  inactiveThumbImage: AssetImage(
                                                      "assets/images/coin.png"))),
                                        )
                                      ]),
                                  _costType == Cost.FREE
                                      ? SizedBox()
                                      : TextFormField(
                                          autovalidate: autoValidate,
                                          validator: (_) =>
                                              _costType == Cost.PAID &&
                                                      _ == null
                                                  ? "Enter fees"
                                                  : null,
                                          keyboardType: TextInputType.number,
                                          controller: _fees,
                                          decoration: InputDecoration(
                                              labelText: "Event Fee"),
                                          textInputAction: TextInputAction.go),
                                  Row(children: <Widget>[
                                    Expanded(
                                        child: TextFormField(
                                            validator: (_) {
                                              if (_.length < 3 &&
                                                  _itemList.length < 1)
                                                return "Food name should be greater than 3";
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                                labelText: "Items"),
                                            controller: _item)),
                                    IconButton(
                                        icon: Icon(Icons.add),
                                        onPressed: () {
                                          if (_formKey.currentState
                                              .validate()) {
                                            _formKey.currentState.save();
                                            setState(() {
                                              _itemList
                                                  .add(_item.text.toString());
                                            });
                                            _item.clear();
                                            _animListState.currentState
                                                .insertItem(0,
                                                    duration: Duration(
                                                        milliseconds: 0));
                                          }
                                        })
                                  ]),
                                  AnimatedList(
                                      key: _animListState,
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      initialItemCount: _itemList.length,
                                      itemBuilder: (context, i, _anim) =>
                                          Row(children: <Widget>[
                                            IconButton(
                                                icon: Icon(Icons.close,
                                                    color: Themes
                                                        .DARK_BROWN_COOKIE),
                                                onPressed: () {
                                                  _animListState.currentState
                                                      .removeItem(
                                                          i,
                                                          (context, animation) => Text(
                                                              _itemList[i],
                                                              style: TextStyle(
                                                                  color: Themes
                                                                      .DARK_BROWN_COOKIE)));
                                                  _itemList.removeAt(i);
                                                }),
                                            Expanded(
                                                child: Text(_itemList[i],
                                                    style: TextStyle(
                                                        color: Themes
                                                            .DARK_BROWN_COOKIE)))
                                          ])),
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          top: 16.0, bottom: 8.0),
                                      child: Text("Event Frequency")),
                                  Align(
                                      alignment: Alignment.center,
                                      child: ToggleButtons(
                                          children: [
                                            Text("Once"),
                                            Text("Daily"),
                                            Text("Random")
                                          ],
                                          selectedColor: Colors.white,
                                          fillColor: Themes.DARK_BROWN_COOKIE,
                                          isSelected: [
                                            _eventFrequency == Frequency.ONCE,
                                            _eventFrequency == Frequency.DAILY,
                                            _eventFrequency == Frequency.RANDOM
                                          ],
                                          onPressed: (_) {
                                            setState(() {
                                              _dates.clear();
                                              _eventFrequency = _ == 0
                                                  ? Frequency.ONCE
                                                  : _ == 1
                                                      ? Frequency.DAILY
                                                      : Frequency.RANDOM;
                                            });
                                          },
                                          borderRadius:
                                              BorderRadius.circular(8.0))),
                                  Align(
                                      alignment: Alignment.center,
                                      child: _eventFrequency == null
                                          ? SizedBox()
                                          : _eventFrequency == Frequency.ONCE
                                              ? FlatButton(
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
                                                                "Select Date",
                                                            cancelText:
                                                                "Cancel");
                                                    setState(() {
                                                      _dates.add(_tempDate);
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
                                                                    bottom:
                                                                        4.0),
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
                                                                    _fromDate
                                                                        .year
                                                                        .toString()))
                                                      ]))
                                              : _eventFrequency ==
                                                      Frequency.DAILY
                                                  ? Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        FlatButton(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    0.0),
                                                            onPressed:
                                                                () async {
                                                              _fromDate = await showDatePicker(
                                                                  context:
                                                                      context,
                                                                  initialDate:
                                                                      _currentDateTime,
                                                                  firstDate:
                                                                      _currentDateTime,
                                                                  lastDate: DateTime(
                                                                      _currentDateTime
                                                                              .year +
                                                                          1,
                                                                      _currentDateTime
                                                                          .month,
                                                                      _currentDateTime
                                                                          .day),
                                                                  confirmText:
                                                                      "Select FROM",
                                                                  cancelText:
                                                                      "Cancel");
                                                              setState(() {
                                                                _fromDate =
                                                                    _fromDate;
                                                              });
                                                            },
                                                            child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: <
                                                                    Widget>[
                                                                  Text(
                                                                      "From Date",
                                                                      style: TextStyle(
                                                                          color:
                                                                              Themes.DARK_BROWN_COOKIE)),
                                                                  Container(
                                                                      color: Colors.grey[
                                                                          200],
                                                                      padding: EdgeInsets.only(
                                                                          left:
                                                                              4.0,
                                                                          right:
                                                                              4.0,
                                                                          top:
                                                                              4.0,
                                                                          bottom:
                                                                              4.0),
                                                                      child: Text(_fromDate ==
                                                                              null
                                                                          ? "DD/MM/YYYY"
                                                                          : _fromDate.day.toString() +
                                                                              "/" +
                                                                              _fromDate.month.toString() +
                                                                              "/" +
                                                                              _fromDate.year.toString()))
                                                                ])),
                                                        SizedBox(width: 16.0),
                                                        FlatButton(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    0.0),
                                                            onPressed:
                                                                () async {
                                                              _toDate = await showDatePicker(
                                                                  context:
                                                                      context,
                                                                  initialDate:
                                                                      _currentDateTime,
                                                                  firstDate:
                                                                      _currentDateTime,
                                                                  lastDate: DateTime(
                                                                      _currentDateTime
                                                                              .year +
                                                                          1,
                                                                      _currentDateTime
                                                                          .month,
                                                                      _currentDateTime
                                                                          .day),
                                                                  confirmText:
                                                                      "Select FROM",
                                                                  cancelText:
                                                                      "Cancel");
                                                              setState(() {
                                                                _toDate =
                                                                    _toDate;
                                                              });
                                                            },
                                                            child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: <
                                                                    Widget>[
                                                                  Text(
                                                                      "To Date",
                                                                      style: TextStyle(
                                                                          color:
                                                                              Themes.DARK_BROWN_COOKIE)),
                                                                  Container(
                                                                      color: Colors.grey[
                                                                          200],
                                                                      padding: EdgeInsets.only(
                                                                          left:
                                                                              4.0,
                                                                          right:
                                                                              4.0,
                                                                          top:
                                                                              4.0,
                                                                          bottom:
                                                                              4.0),
                                                                      child: Text(_toDate ==
                                                                              null
                                                                          ? "DD/MM/YYYY"
                                                                          : _toDate.day.toString() +
                                                                              "/" +
                                                                              _toDate.month.toString() +
                                                                              "/" +
                                                                              _toDate.year.toString()))
                                                                ])),
                                                      ],
                                                    )
                                                  : FlatButton(
                                                      padding:
                                                          EdgeInsets.all(0.0),
                                                      onPressed: () async {
                                                        DateTime _tempDate = await showDatePicker(
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
                                                            cancelText:
                                                                "Cancel");
                                                        setState(() {
                                                          _dates.add(_tempDate);
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
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            4.0,
                                                                        right:
                                                                            4.0,
                                                                        top:
                                                                            4.0,
                                                                        bottom:
                                                                            4.0),
                                                                child: Text(_fromDate ==
                                                                        null
                                                                    ? "DD/MM/YYYY"
                                                                    : _fromDate
                                                                            .day
                                                                            .toString() +
                                                                        "/" +
                                                                        _fromDate
                                                                            .month
                                                                            .toString() +
                                                                        "/" +
                                                                        _fromDate
                                                                            .year
                                                                            .toString()))
                                                          ]))),
                                  _eventFrequency == Frequency.RANDOM &&
                                          _dates != null
                                      ? ListView.builder(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, index) =>
                                              ListTile(
                                                  leading: IconButton(
                                                      icon: Icon(Icons.cancel),
                                                      onPressed: () {
                                                        setState(() {
                                                          _dates
                                                              .removeAt(index);
                                                        });
                                                      }),
                                                  title: Text(formattedDate(
                                                      _dates[index]))),
                                          itemCount: _dates.length,
                                          shrinkWrap: true)
                                      : SizedBox(),
                                  Padding(
                                      padding: const EdgeInsets.only(top: 16.0),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            FlatButton(
                                                padding: EdgeInsets.all(0.0),
                                                onPressed: () async {
                                                  TimeOfDay _tempDate =
                                                      await showTimePicker(
                                                          context: context,
                                                          initialTime:
                                                              TimeOfDay.now(),
                                                          builder: (context,
                                                                  child) =>
                                                              Theme(
                                                                  data:
                                                                      ThemeData(
                                                                    primaryColor:
                                                                        Colors
                                                                            .white,
                                                                    accentColor:
                                                                        Themes
                                                                            .DARK_BROWN_COOKIE,
                                                                    primarySwatch:
                                                                        Colors
                                                                            .brown,
                                                                    fontFamily:
                                                                        Fonts
                                                                            .JAAPOKKI_REGULAR,
                                                                  ),
                                                                  child:
                                                                      child));
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
                                                                      .toString())),
                                                    ])),
                                            FlatButton(
                                                padding: EdgeInsets.all(0.0),
                                                onPressed: () async {
                                                  TimeOfDay _tempDate =
                                                      await showTimePicker(
                                                          context: context,
                                                          initialTime:
                                                              TimeOfDay.now(),
                                                          builder: (context,
                                                                  child) =>
                                                              Theme(
                                                                  data:
                                                                      ThemeData(
                                                                    primaryColor:
                                                                        Colors
                                                                            .white,
                                                                    accentColor:
                                                                        Themes
                                                                            .DARK_BROWN_COOKIE,
                                                                    primarySwatch:
                                                                        Colors
                                                                            .brown,
                                                                    fontFamily:
                                                                        Fonts
                                                                            .JAAPOKKI_REGULAR,
                                                                  ),
                                                                  child:
                                                                      child));
                                                  setState(() {
                                                    _timeOfDayEnd = _tempDate;
                                                  });
                                                },
                                                child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Text("To",
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
                                                          child: Text(_timeOfDayEnd ==
                                                                  null
                                                              ? "End Time"
                                                              : _timeOfDayEnd
                                                                      .hour
                                                                      .toString() +
                                                                  ":" +
                                                                  _timeOfDayEnd
                                                                      .minute
                                                                      .toString())),
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
                                                  if (_image == null)
                                                    errorText +=
                                                        " Select Event Banner.";
                                                  if (_eventFrequency == null)
                                                    errorText +=
                                                        " Select Event Frequency.";
                                                  if (_timeOfDayStart == null)
                                                    errorText +=
                                                        " Select Start Time.";
                                                  if (_timeOfDayEnd == null)
                                                    errorText +=
                                                        " Select End Time.";
                                                  if (_fromDate == null)
                                                    errorText +=
                                                        " Select Date for event";
                                                  setState(() {
                                                    errorText.trim();
                                                  });
                                                  if (errorText == "" &&
                                                      _formKey.currentState
                                                          .validate()) {
                                                    _formKey.currentState
                                                        .save();

                                                    CommonWidget.loading(
                                                        context);
                                                    _model.name =
                                                        _eventName.text;
                                                    _model.eventOrganizer =
                                                        _organizerName.text;
                                                    _model.description =
                                                        _eventDescription.text;
                                                    _model.address =
                                                        _address.text;
                                                    _model.cost =
                                                        _costType == Cost.FREE
                                                            ? "free"
                                                            : "paid";
                                                    _costType == Cost.FREE
                                                        ? _model.fee = ""
                                                        : _model.fee =
                                                            _fees.text;
                                                    _model.items =
                                                        _itemList.join(", ");
                                                    _model.frequency =
                                                        _eventFrequency ==
                                                                Frequency.DAILY
                                                            ? "daily"
                                                            : _eventFrequency ==
                                                                    Frequency
                                                                        .ONCE
                                                                ? "once"
                                                                : "random";
                                                    List<String>
                                                        _tempListDates = [];
                                                    if (_eventFrequency ==
                                                        Frequency.ONCE)
                                                      _tempListDates.add(_dates[
                                                              0]
                                                          .toIso8601String());
                                                    else if (_eventFrequency ==
                                                        Frequency.DAILY) {
                                                      for (int i = 0;
                                                          i <=
                                                              _fromDate
                                                                  .difference(
                                                                      _toDate)
                                                                  .inDays;
                                                          i++) {
                                                        _tempListDates.add(_fromDate
                                                            .add(Duration(
                                                                days: i))
                                                            .toIso8601String());
                                                      }
                                                    } else if (_eventFrequency ==
                                                        Frequency.RANDOM) {
                                                      _dates.forEach((element) {
                                                        _tempListDates.add(element
                                                            .toIso8601String());
                                                      });
                                                    }
                                                    _model.startTime =
                                                        "${_timeOfDayStart.hour < 10 ? ("0${_timeOfDayStart.hour}") : _timeOfDayStart.hour}:${_timeOfDayStart.minute < 10 ? ("0${_timeOfDayStart.minute}") : _timeOfDayStart.minute}:00";
                                                    _model.endTime =
                                                        "${_timeOfDayEnd.hour < 10 ? ("0${_timeOfDayEnd.hour}") : _timeOfDayEnd.hour}:${_timeOfDayEnd.minute < 10 ? ("0${_timeOfDayEnd.minute}") : _timeOfDayEnd.minute}:00";

                                                    _model.postBy = context
                                                        .read<UserProvider>()
                                                        .userLoginResponseModel
                                                        .message
                                                        .firstName;

                                                    _model.userId = context
                                                        .read<UserProvider>()
                                                        .userLoginResponseModel
                                                        .message
                                                        .id;

                                                    //left
                                                    _model.banner = "";

                                                    dynamic response = await API
                                                        .postFoodPointEvent(
                                                            _model);
                                                    Navigator.pop(context);
                                                    Navigator.pop(context);

                                                    response is bool
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
                                                                          onPressed: () => Navigator.pop(
                                                                              context),
                                                                          child: Text(
                                                                              "Close",
                                                                              style: TextStyle(color: Themes.DARK_BROWN_COOKIE)))
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
                                                                          onPressed: () => Navigator.pop(
                                                                              context),
                                                                          child: Text(
                                                                              "Close",
                                                                              style: TextStyle(color: Themes.DARK_BROWN_COOKIE)))
                                                                    ],
                                                                    content: Text(
                                                                        "Event has been created!")));
                                                  }
                                                },
                                                child: Text("Okay",
                                                    style: TextStyle(
                                                        color: Colors.white)))
                                          ]))
                                ]))))));
  }

  String formattedDate(DateTime dateTime) {
    return "${dateTime.day}-${dateTime.month}-${dateTime.year}";
  }
}
