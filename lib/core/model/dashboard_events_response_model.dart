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
  Place place;
  int rating;
  City city;
  Banner banner;
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
        place: placeValues.map[json["place"]],
        rating: json["rating"],
        city: cityValues.map[json["city"]],
        banner: Banner.fromJson(json["banner"]),
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
        "place": placeValues.reverse[place],
        "rating": rating,
        "city": cityValues.reverse[city],
        "banner": banner.toJson(),
        "fee": fee,
        "cost_type": costTypeValues.reverse[costType],
        "start_time": startTime,
        "end_time": endTime,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
      };
}

class Banner {
  Type type;
  List<int> data;

  Banner({
    this.type,
    this.data,
  });

  factory Banner.fromJson(Map<String, dynamic> json) => Banner(
        type: typeValues.map[json["type"]],
        data: List<int>.from(json["data"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "type": typeValues.reverse[type],
        "data": List<dynamic>.from(data.map((x) => x)),
      };
}

enum Type { BUFFER }

final typeValues = EnumValues({"Buffer": Type.BUFFER});

enum City { BURARI }

final cityValues = EnumValues({"Burari": City.BURARI});

final costTypeValues = EnumValues({"paid": Cost.PAID, "free": Cost.FREE});

enum Place { EMPTY, BRIDGE_PUCHIYA, ANGUPIDA }

final placeValues = EnumValues({
  "Angupida": Place.ANGUPIDA,
  "Bridge Puchiya": Place.BRIDGE_PUCHIYA,
  "": Place.EMPTY
});

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
