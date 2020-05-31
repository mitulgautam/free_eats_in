// To parse this JSON data, do
//
//     final dashboardEventsResponseModel = dashboardEventsResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:freeeatsin/resources/strings.dart';

DashboardEventsResponseModel dashboardEventsResponseModelFromJson(String str) =>
    DashboardEventsResponseModel.fromJson(json.decode(str));

String dashboardEventsResponseModelToJson(DashboardEventsResponseModel data) =>
    json.encode(data.toJson());

class DashboardEventsResponseModel {
  bool success;
  List<FoodPointCard> message;

  DashboardEventsResponseModel({
    this.success,
    this.message,
  });

  factory DashboardEventsResponseModel.fromJson(Map<String, dynamic> json) =>
      DashboardEventsResponseModel(
        success: json["success"],
        message: List<FoodPointCard>.from(
            json["message"].map((x) => FoodPointCard.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": List<dynamic>.from(message.map((x) => x.toJson())),
      };
}

class FoodPointCard {
  String name;
  int id;
  int userId;
  String address;
  String place;
  int rating;
  String city;
  String banner;
  String fee;
  Cost costType;
  String startTime;
  String endTime;
  DateTime date;

  FoodPointCard({
    this.name,
    this.id,
    this.userId,
    this.address,
    this.place,
    this.rating,
    this.city,
    this.banner,
    this.fee,
    this.costType,
    this.startTime,
    this.endTime,
    this.date,
  });

  factory FoodPointCard.fromJson(Map<String, dynamic> json) => FoodPointCard(
        name: json["name"],
        id: json["id"],
        userId: json["user_id"],
        address: json["address"],
        place: json["place"],
        rating: json["rating"],
        city: json["city"],
        banner: json["banner"] == null ? null : json["banner"],
        fee: json["fee"],
        costType: costTypeValues.map[json["cost_type"]],
        startTime: json["start_time"],
        endTime: json["end_time"],
        date: DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
        "user_id": userId,
        "address": address,
        "place": place,
        "rating": rating,
        "city": city,
        "banner": banner == null ? null : banner,
        "fee": fee,
        "cost_type": costTypeValues.reverse[costType],
        "start_time": startTime,
        "end_time": endTime,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
      };
}

final costTypeValues = EnumValues({"free": Cost.FREE, "paid": Cost.PAID});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
