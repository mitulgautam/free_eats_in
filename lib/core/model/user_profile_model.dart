// To parse this JSON data, do
//
//     final userProfileModel = userProfileModelFromJson(jsonString);

import 'dart:convert';

UserProfileModel userProfileModelFromJson(String str) => UserProfileModel.fromJson(json.decode(str));

String userProfileModelToJson(UserProfileModel data) => json.encode(data.toJson());

class UserProfileModel {
  bool success;
  Message message;

  UserProfileModel({
    this.success,
    this.message,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) => UserProfileModel(
    success: json["success"],
    message: Message.fromJson(json["message"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message.toJson(),
  };
}

class Message {
  String firstName;
  String email;
  String lastName;
  String address;
  String phoneNumber;
  String image;
  int eventAttended;
  int eventPosted;

  Message({
    this.firstName,
    this.email,
    this.lastName,
    this.address,
    this.phoneNumber,
    this.image,
    this.eventAttended,
    this.eventPosted,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    firstName: json["first_name"],
    email: json["email"],
    lastName: json["last_name"],
    address: json["address"],
    phoneNumber: json["phone_number"],
    image: json["image"],
    eventAttended: json["event_attended"],
    eventPosted: json["event_posted"],
  );

  Map<String, dynamic> toJson() => {
    "first_name": firstName,
    "email": email,
    "last_name": lastName,
    "address": address,
    "phone_number": phoneNumber,
    "image": image,
    "event_attended": eventAttended,
    "event_posted": eventPosted,
  };
}
