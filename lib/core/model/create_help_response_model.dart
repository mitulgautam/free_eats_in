// To parse this JSON data, do
//
//     final createEventHelpResponseModel = createEventHelpResponseModelFromJson(jsonString);

import 'dart:convert';

CreateEventHelpResponseModel createEventHelpResponseModelFromJson(String str) =>
    CreateEventHelpResponseModel.fromJson(json.decode(str));

String createEventHelpResponseModelToJson(CreateEventHelpResponseModel data) =>
    json.encode(data.toJson());

class CreateEventHelpResponseModel {
  bool success;
  Message message;

  CreateEventHelpResponseModel({
    this.success,
    this.message,
  });

  factory CreateEventHelpResponseModel.fromJson(Map<String, dynamic> json) =>
      CreateEventHelpResponseModel(
        success: json["success"],
        message: Message.fromJson(json["message"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message.toJson(),
      };
}

class Message {
  String image;
  bool isCompleted;
  int completedCount;
  int id;
  String name;
  String address;
  String city;
  String type;
  DateTime date;
  String eventFrom;
  String eventTo;
  String description;
  String postBy;
  int userId;
  DateTime updatedAt;
  DateTime createdAt;

  Message({
    this.image,
    this.isCompleted,
    this.completedCount,
    this.id,
    this.name,
    this.address,
    this.city,
    this.type,
    this.date,
    this.eventFrom,
    this.eventTo,
    this.description,
    this.postBy,
    this.userId,
    this.updatedAt,
    this.createdAt,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        image: json["image"],
        isCompleted: json["is_completed"],
        completedCount: json["completed_count"],
        id: json["id"],
        name: json["name"],
        address: json["address"],
        city: json["city"],
        type: json["type"],
        date: DateTime.parse(json["date"]),
        eventFrom: json["event_from"],
        eventTo: json["event_to"],
        description: json["description"],
        postBy: json["post_by"],
        userId: json["user_id"],
        updatedAt: DateTime.parse(json["updatedAt"]),
        createdAt: DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "image": image,
        "is_completed": isCompleted,
        "completed_count": completedCount,
        "id": id,
        "name": name,
        "address": address,
        "city": city,
        "type": type,
        "date": date.toIso8601String(),
        "event_from": eventFrom,
        "event_to": eventTo,
        "description": description,
        "post_by": postBy,
        "user_id": userId,
        "updatedAt": updatedAt.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
      };
}
