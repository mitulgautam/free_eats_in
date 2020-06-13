// To parse this JSON data, do
//
//     final createHelpEventModel = createHelpEventModelFromJson(jsonString);

import 'dart:convert';
import 'dart:io';

CreateHelpEventModel createHelpEventModelFromJson(String str) =>
    CreateHelpEventModel.fromJson(json.decode(str));

String createHelpEventModelToJson(CreateHelpEventModel data) =>
    json.encode(data.toJson());

class CreateHelpEventModel {
  String name;
  String address;
  String city;
  String type;
  DateTime date;
  String startTime;
  String endTime;
  File banner;
  String description;
  int userId;

  CreateHelpEventModel({
    this.name,
    this.address,
    this.city,
    this.type,
    this.date,
    this.startTime,
    this.endTime,
    this.banner,
    this.description,
    this.userId,
  });

  factory CreateHelpEventModel.fromJson(Map<String, dynamic> json) =>
      CreateHelpEventModel(
        name: json["name"],
        address: json["address"],
        city: json["city"],
        type: json["type"],
        date: DateTime.parse(json["date"]),
        startTime: json["start_time"],
        endTime: json["end_time"],
        banner: json["banner"],
        description: json["description"],
        userId: json["user_id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "address": address,
        "city": city,
        "type": type,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "start_time": startTime,
        "end_time": endTime,
        "banner": banner,
        "description": description,
        "user_id": userId,
      };
}
