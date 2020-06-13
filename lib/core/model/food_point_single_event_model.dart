import 'package:flutter/material.dart';
import 'package:freeeatsin/resources/strings.dart';

class FoodPointSingleEventModel {
  bool success;
  List<Message> message;

  FoodPointSingleEventModel({this.success, this.message});

  FoodPointSingleEventModel.fromJson(Map<String, dynamic> json) {
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
  String eventName;
  String organizerName;
  String description;
  String address;
  String eventFee;
  String eventType;
  String eventItem;
  Frequency frequency;
  List<DateTime> date;
  TimeOfDay startTime;
  TimeOfDay endTime;
  String banner;
  String state;
  String city;
  String place;

  Message(
      {this.id,
      this.eventName,
      this.organizerName,
      this.description,
      this.address,
      this.eventFee,
      this.eventType,
      this.eventItem,
      this.frequency,
      this.date,
      this.startTime,
      this.endTime,
      this.banner,
      this.place,
      this.state,
      this.city});

  Message.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    eventName = json['event_name'];
    organizerName = json['organizer_name'];
    description = json['description'];
    address = json['address'];
    eventFee = json['event_fee'];
    eventType = json['event_type'];
    eventItem = json['event_item'];
    frequency = json['frequency'] == null
        ? null
        : json['frequency'].toString().toLowerCase() == 'daily'
            ? Frequency.DAILY
            : Frequency.RANDOM;
    startTime = json['start_time'] == null || json['date'] == null
        ? null
        : TimeOfDay.fromDateTime(
            DateTime.parse("0000-00-00 " + json['start_time']));
    endTime = json['end_time'] == null || json['date'] == null
        ? null
        : TimeOfDay.fromDateTime(
            DateTime.parse("0000-00-00 " + json['end_time']));
    banner = json['banner'];
    state = json['state'];
    city = json['city'];
    place = json['place'];

    if (json['date'] != null) {
      date = new List<DateTime>();
      json['date'].forEach((d) {
        date.add(DateTime.parse(d));
      });
    } else {
      date = null;
    }
  }
}
