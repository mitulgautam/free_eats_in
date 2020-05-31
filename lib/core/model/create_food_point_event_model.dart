// To parse this JSON data, do
//
//     final createEventModel = createEventModelFromJson(jsonString);

import 'dart:convert';
import 'dart:io';

CreateFoodPointEventModel createEventModelFromJson(String str) =>
    CreateFoodPointEventModel.fromJson(json.decode(str));

String createEventModelToJson(CreateFoodPointEventModel data) =>
    json.encode(data.toJson());

class CreateFoodPointEventModel {
  String name;
  String address;
  String city;
  String place;
  String cost;
  String fee;
  String frequency;
  String items;
  List<String> date;
  String startTime;
  String endTime;
  File banner;
  String description;
  String eventOrganizer;
  String postBy;
  int userId;

  CreateFoodPointEventModel({
    this.name,
    this.address,
    this.city,
    this.place,
    this.cost,
    this.fee,
    this.frequency,
    this.items,
    this.date,
    this.startTime,
    this.endTime,
    this.banner,
    this.description,
    this.eventOrganizer,
    this.postBy,
    this.userId,
  });

  factory CreateFoodPointEventModel.fromJson(Map<String, dynamic> json) =>
      CreateFoodPointEventModel(
        name: json["name"],
        address: json["address"],
        city: json["city"],
        place: json["place"],
        cost: json["cost"],
        fee: json["fee"],
        frequency: json["frequency"],
        items: json["items"],
        date: json["date"],
        startTime: json["start_time"],
        endTime: json["end_time"],
        banner: json["banner"],
        description: json["description"],
        eventOrganizer: json["event_organizer"],
        postBy: json["post_by"],
        userId: json["user_id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "address": address,
        "city": city,
        "place": place,
        "cost": cost,
        "fee": fee,
        "frequency": frequency,
        "items": items,
        "date": date,
        "start_time": startTime,
        "end_time": endTime,
        "banner": banner,
        "description": description,
        "event_organizer": eventOrganizer,
        "post_by": postBy,
        "user_id": userId,
      };
}
