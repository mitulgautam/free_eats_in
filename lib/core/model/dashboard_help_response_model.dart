// To parse this JSON data, do
//
//     final dashboardHelpResponseModel = dashboardHelpResponseModelFromJson(jsonString);

import 'dart:convert';

DashboardHelpResponseModel dashboardHelpResponseModelFromJson(String str) => DashboardHelpResponseModel.fromJson(json.decode(str));

String dashboardHelpResponseModelToJson(DashboardHelpResponseModel data) => json.encode(data.toJson());

class DashboardHelpResponseModel {
  bool success;
  List<HelpCard> message;

  DashboardHelpResponseModel({
    this.success,
    this.message,
  });

  factory DashboardHelpResponseModel.fromJson(Map<String, dynamic> json) => DashboardHelpResponseModel(
    success: json["success"],
    message: List<HelpCard>.from(json["message"].map((x) => HelpCard.fromJson(x))),
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
  Banner banner;
  String type;
  DateTime date;
  Banner image;
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
    banner: Banner.fromJson(json["banner"]),
    type: json["type"],
    date: DateTime.parse(json["date"]),
    image: Banner.fromJson(json["image"]),
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
    "banner": banner.toJson(),
    "type": type,
    "date": date.toIso8601String(),
    "image": image.toJson(),
    "post_by": postBy,
    "start_time": startTime,
    "end_time": endTime,
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

final typeValues = EnumValues({
  "Buffer": Type.BUFFER
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
