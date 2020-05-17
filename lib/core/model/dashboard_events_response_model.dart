// To parse this JSON data, do
//
//     final dashboardEventsResponseModel = dashboardEventsResponseModelFromJson(jsonString);

import 'dart:convert';

DashboardEventsResponseModel dashboardEventsResponseModelFromJson(String str) => DashboardEventsResponseModel.fromJson(json.decode(str));

String dashboardEventsResponseModelToJson(DashboardEventsResponseModel data) => json.encode(data.toJson());

class DashboardEventsResponseModel {
  bool success;
  List<FoodPointCard> message;

  DashboardEventsResponseModel({
    this.success,
    this.message,
  });

  factory DashboardEventsResponseModel.fromJson(Map<String, dynamic> json) => DashboardEventsResponseModel(
    success: json["success"],
    message: List<FoodPointCard>.from(json["message"].map((x) => FoodPointCard.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": List<dynamic>.from(message.map((x) => x.toJson())),
  };
}

class FoodPointCard {
  String name;
  String address;
  String place;
  int rating;
  String city;
  Banner banner;
  String fee;
  String costType;
  String startTime;
  String endTime;

  FoodPointCard({
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
    name: json["name"],
    address: json["address"],
    place: json["place"],
    rating: json["rating"],
    city: json["city"],
    banner: Banner.fromJson(json["banner"]),
    fee: json["fee"],
    costType: json["cost_type"],
    startTime: json["start_time"],
    endTime: json["end_time"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "address": address,
    "place": place,
    "rating": rating,
    "city": city,
    "banner": banner.toJson(),
    "fee": fee,
    "cost_type": costType,
    "start_time": startTime,
    "end_time": endTime,
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
