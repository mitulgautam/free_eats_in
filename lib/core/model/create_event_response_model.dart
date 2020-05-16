// To parse this JSON data, do
//
//     final createEventResponseModel = createEventResponseModelFromJson(jsonString);

import 'dart:convert';

CreateEventResponseModel createEventResponseModelFromJson(String str) => CreateEventResponseModel.fromJson(json.decode(str));

String createEventResponseModelToJson(CreateEventResponseModel data) => json.encode(data.toJson());

class CreateEventResponseModel {
  bool success;
  Message message;

  CreateEventResponseModel({
    this.success,
    this.message,
  });

  factory CreateEventResponseModel.fromJson(Map<String, dynamic> json) => CreateEventResponseModel(
    success: json["success"],
    message: Message.fromJson(json["message"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message.toJson(),
  };
}

class Message {
  int rating;
  int id;
  String name;
  String address;
  String place;
  String city;
  String eventType;
  String eventPrice;
  String frequency;
  String eventItem;
  DateTime date;
  DateTime eventFrom;
  DateTime eventTo;
  String image;
  String description;
  String host;
  String postBy;
  int userId;
  DateTime updatedAt;
  DateTime createdAt;

  Message({
    this.rating,
    this.id,
    this.name,
    this.address,
    this.place,
    this.city,
    this.eventType,
    this.eventPrice,
    this.frequency,
    this.eventItem,
    this.date,
    this.eventFrom,
    this.eventTo,
    this.image,
    this.description,
    this.host,
    this.postBy,
    this.userId,
    this.updatedAt,
    this.createdAt,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    rating: json["rating"],
    id: json["id"],
    name: json["name"],
    address: json["address"],
    place: json["place"],
    city: json["city"],
    eventType: json["event_type"],
    eventPrice: json["event_price"],
    frequency: json["frequency"],
    eventItem: json["event_item"],
    date: DateTime.parse(json["date"]),
    eventFrom: DateTime.parse(json["event_from"]),
    eventTo: DateTime.parse(json["event_to"]),
    image: json["image"],
    description: json["description"],
    host: json["host"],
    postBy: json["post_by"],
    userId: json["user_id"],
    updatedAt: DateTime.parse(json["updatedAt"]),
    createdAt: DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "rating": rating,
    "id": id,
    "name": name,
    "address": address,
    "place": place,
    "city": city,
    "event_type": eventType,
    "event_price": eventPrice,
    "frequency": frequency,
    "event_item": eventItem,
    "date": date.toIso8601String(),
    "event_from": eventFrom.toIso8601String(),
    "event_to": eventTo.toIso8601String(),
    "image": image,
    "description": description,
    "host": host,
    "post_by": postBy,
    "user_id": userId,
    "updatedAt": updatedAt.toIso8601String(),
    "createdAt": createdAt.toIso8601String(),
  };
}
