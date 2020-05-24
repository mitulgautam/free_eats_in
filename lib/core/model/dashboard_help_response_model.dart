// To parse this JSON data, do
//
//     final dashboardHelpResponseModel = dashboardHelpResponseModelFromJson(jsonString);

import 'dart:convert';

DashboardHelpResponseModel dashboardHelpResponseModelFromJson(String str) => DashboardHelpResponseModel.fromJson(json.decode(str));

String dashboardHelpResponseModelToJson(DashboardHelpResponseModel data) => json.encode(data.toJson());

class DashboardHelpResponseModel {
  bool success;
  List<Message> message;

  DashboardHelpResponseModel({
    this.success,
    this.message,
  });

  factory DashboardHelpResponseModel.fromJson(Map<String, dynamic> json) => DashboardHelpResponseModel(
    success: json["success"],
    message: List<Message>.from(json["message"].map((x) => Message.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": List<dynamic>.from(message.map((x) => x.toJson())),
  };
}

class Message {
  int id;
  String name;
  String address;
  String city;
  Banner banner;
  String type;
  DateTime date;
  String startTime;
  String endTime;

  Message({
    this.id,
    this.name,
    this.address,
    this.city,
    this.banner,
    this.type,
    this.date,
    this.startTime,
    this.endTime,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    id: json["id"],
    name: json["name"],
    address: json["address"],
    city: json["city"],
    banner: Banner.fromJson(json["banner"]),
    type: json["type"],
    date: DateTime.parse(json["date"]),
    startTime: json["start_time"],
    endTime: json["end_time"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "address": address,
    "city": city,
    "banner": banner.toJson(),
    "type": type,
    "date": date.toIso8601String(),
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
