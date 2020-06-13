import 'package:flutter/material.dart';

class HelpSingleEventModel {
  bool success;
  List<Message> message;

  HelpSingleEventModel({this.success, this.message});

  HelpSingleEventModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['message'] != null) {
      message = new List<Message>();
      json['message'].forEach((v) {
        message.add(new Message.fromJson(v));
      });
    }
  }
}

class Message {
  int id;
  String name;
  String city;
  String type;
  String description;
  TimeOfDay startTime;
  String place;
  DateTime date;
  String banner;
  String state;
  String address;

  Message(
      {this.id,
      this.name,
      this.city,
      this.type,
      this.description,
      this.startTime,
      this.place,
      this.date,
      this.banner,
      this.state,
      this.address});

  Message.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    city = json['city'];
    type = json['type'];
    description = json['description'];

    startTime = json['start_time'] == null
        ? null
        : TimeOfDay.fromDateTime(
            DateTime.parse("0000-00-00 " + json['start_time']));
    place = json['place'];
    date = json['date'] == null ? null : DateTime.parse(json['date']);
    banner = json['banner'];
    state = json['state'];
    address = json['address'];
  }
}
