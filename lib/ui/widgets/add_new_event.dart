import 'package:flutter/material.dart';
import 'package:freeeatsin/resources/strings.dart';
import 'package:freeeatsin/resources/themes.dart';

class AddNewEvent extends StatefulWidget {
  @override
  _AddNewEventState createState() => _AddNewEventState();
}

class _AddNewEventState extends State<AddNewEvent> {
  Cost _costType;
  bool _currentAddress = false;
  Frequency _eventFrequency;
  DateTime _currentDateTime = DateTime.now();
  DateTime _fromDate;
  DateTime _toDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(decoration: InputDecoration(labelText: "Event Name")),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Text("Address"),
                ),
                CheckboxListTile(
                    value: _currentAddress,
                    onChanged: (_) {
                      setState(() {
                        _currentAddress = _;
                      });
                    },
                    title: Text("Use Current Address")),
                _currentAddress ? SizedBox() : TextFormField(decoration: InputDecoration(labelText: "Address")),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Text("Fees Type"),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                        child: RadioListTile(
                            value: Cost.FREE,
                            groupValue: _costType,
                            onChanged: (_) {
                              setState(() {
                                _costType = _;
                              });
                            },
                            title: Text("FREE"))),
                    Expanded(
                        child: RadioListTile(
                            value: Cost.PAID,
                            groupValue: _costType,
                            onChanged: (_) {
                              setState(() {
                                _costType = _;
                              });
                            },
                            title: Text("PAID"))),
                  ],
                ),
                TextFormField(decoration: InputDecoration(labelText: "Items")),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Text("Event Frequency"),
                ),
                Column(
                  children: <Widget>[
                    RadioListTile(
                        value: Frequency.ONCE,
                        groupValue: _eventFrequency,
                        onChanged: (_) {
                          setState(() {
                            _eventFrequency = _;
                          });
                        },
                        title: Text("ONCE")),
                    RadioListTile(
                        value: Frequency.DAILY,
                        groupValue: _eventFrequency,
                        onChanged: (_) {
                          setState(() {
                            _eventFrequency = _;
                          });
                        },
                        title: Text("DAILY")),
                    RadioListTile(
                        value: Frequency.RANDOM,
                        groupValue: _eventFrequency,
                        onChanged: (_) {
                          setState(() {
                            _eventFrequency = _;
                          });
                        },
                        title: Text("RANDOM")),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Text("Event Time"),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        FlatButton(
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
                          child: Text(_fromDate ?? "DD/MM/YYYY"),
                        ),
                        Text("TO"),
                        FlatButton(
                          onPressed: () {},
                          child: Text(_toDate ?? "DD/MM/YYYY"),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
