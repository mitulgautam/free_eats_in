import 'dart:convert';

import 'package:freeeatsin/resources/strings.dart';

DashboardEventsResponseModel dashboardEventsResponseModelFromJson(String str) =>
    DashboardEventsResponseModel.fromJson(json.decode(str));

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
}

class FoodPointCard {
  int id;
  String name;
  String address;
  String place;
  int rating;
  String city;
  String banner;
  String fee;
  Cost costType;
  String startTime;
  String endTime;

  FoodPointCard({
    this.id,
    this.name,
    this.address,
    this.place,
    this.rating,
    this.city,
    this.banner,
    this.fee,
    this.costType,
    this.startTime,
    this.endTime,
  });

  factory FoodPointCard.fromJson(Map<String, dynamic> json) => FoodPointCard(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        place: json["place"],
        rating: json["rating"],
        city: json["city"],
        banner: json["banner"],
        fee: json["fee"],
        costType: json["cost_type"] == null ||
                json["cost_type"] == "free" ||
                json["cost_type"] == ""
            ? Cost.FREE
            : Cost.PAID,
        startTime: json["start_time"],
        endTime: json["end_time"],
      );
}
