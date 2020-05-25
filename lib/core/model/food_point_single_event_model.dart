// To parse this JSON data, do
//
//     final foodPointSingleEventModel = foodPointSingleEventModelFromJson(jsonString);

import 'dart:convert';

FoodPointSingleEventModel foodPointSingleEventModelFromJson(String str) => FoodPointSingleEventModel.fromJson(json.decode(str));

String foodPointSingleEventModelToJson(FoodPointSingleEventModel data) => json.encode(data.toJson());

class FoodPointSingleEventModel {
  bool success;
  List<Message> message;

  FoodPointSingleEventModel({
    this.success,
    this.message,
  });

  factory FoodPointSingleEventModel.fromJson(Map<String, dynamic> json) => FoodPointSingleEventModel(
    success: json["success"],
    message: List<Message>.from(json["message"].map((x) => Message.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": List<dynamic>.from(message.map((x) => x.toJson())),
  };
}

class Message {
  String eventName;
  String organizerName;
  String description;
  String address;
  String eventFee;
  String eventType;
  String eventItem;
  String frequency;
  DateTime date;
  String startTime;
  String endTime;
  Banner banner;
  dynamic url;

  Message({
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
    this.url,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    eventName: json["event_name"],
    organizerName: json["organizer_name"],
    description: json["description"],
    address: json["address"],
    eventFee: json["event_fee"],
    eventType: json["event_type"],
    eventItem: json["event_item"],
    frequency: json["frequency"],
    date: DateTime.parse(json["date"]),
    startTime: json["start_time"],
    endTime: json["end_time"],
    banner: Banner.fromJson(json["banner"]),
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "event_name": eventName,
    "organizer_name": organizerName,
    "description": description,
    "address": address,
    "event_fee": eventFee,
    "event_type": eventType,
    "event_item": eventItem,
    "frequency": frequency,
    "date": date.toIso8601String(),
    "start_time": startTime,
    "end_time": endTime,
    "banner": banner.toJson(),
    "url": url,
  };
}

class Banner {
  String type;
  List<int> data;

  Banner({
    this.type,
    this.data,
  });

  factory Banner.fromJson(Map<String, dynamic> json) => Banner(
    type: json["type"],
    data: List<int>.from(json["data"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "data": List<dynamic>.from(data.map((x) => x)),
  };
}
