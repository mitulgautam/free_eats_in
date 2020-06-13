// To parse this JSON data, do
//
//     final dashboardHelpResponseModel = dashboardHelpResponseModelFromJson(jsonString);

import 'dart:convert';

DashboardHelpResponseModel dashboardHelpResponseModelFromJson(String str) =>
    DashboardHelpResponseModel.fromJson(json.decode(str));

String dashboardHelpResponseModelToJson(DashboardHelpResponseModel data) =>
    json.encode(data.toJson());

class DashboardHelpResponseModel {
  bool success;
  List<HelpCard> message;

  DashboardHelpResponseModel({
    this.success,
    this.message,
  });

  factory DashboardHelpResponseModel.fromJson(Map<String, dynamic> json) =>
      DashboardHelpResponseModel(
        success: json["success"],
        message: List<HelpCard>.from(
            json["message"].map((x) => HelpCard.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": List<dynamic>.from(message.map((x) => x.toJson())),
      };
}

class HelpCard {
  int id;
  String description;
  int userId;
  String name;
  String address;
  String city;
  String banner;
  String type;
  DateTime date;
  dynamic image;
  String postBy;
  String startTime;
  String endTime;

  HelpCard({
    this.id,
    this.description,
    this.userId,
    this.name,
    this.address,
    this.city,
    this.banner,
    this.type,
    this.date,
    this.image,
    this.postBy,
    this.startTime,
    this.endTime,
  });

  factory HelpCard.fromJson(Map<String, dynamic> json) => HelpCard(
        id: json["id"],
        description: json["description"],
        userId: json["user_id"],
        name: json["name"],
        address: json["address"],
        city: json["city"],
        banner: json["banner"] == null ? null : json["banner"],
        type: json["type"],
        date: DateTime.parse(json["date"]),
        image: json["image"],
        postBy: json["post_by"],
        startTime: json["start_time"],
        endTime: json["end_time"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "user_id": userId,
        "name": name,
        "address": address,
        "city": city,
        "banner": banner == null ? null : banner,
        "type": type,
        "date": date.toIso8601String(),
        "image": image,
        "post_by": postBy,
        "start_time": startTime,
        "end_time": endTime,
      };
}
