// To parse this JSON data, do
//
//     final userSignUpResponseModel = userSignUpResponseModelFromJson(jsonString);

import 'dart:convert';

UserSignUpResponseModel userSignUpResponseModelFromJson(String str) => UserSignUpResponseModel.fromJson(json.decode(str));

String userSignUpResponseModelToJson(UserSignUpResponseModel data) => json.encode(data.toJson());

class UserSignUpResponseModel {
  bool success;
  Message message;

  UserSignUpResponseModel({
    this.success,
    this.message,
  });

  factory UserSignUpResponseModel.fromJson(Map<String, dynamic> json) => UserSignUpResponseModel(
    success: json["success"],
    message: Message.fromJson(json["message"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message.toJson(),
  };
}

class Message {
  bool isVerified;
  DateTime createdDate;
  int id;
  String firstName;
  String lastName;
  String email;
  String phoneNumber;
  bool isActive;
  String city;
  String pincode;
  DateTime updatedAt;
  DateTime createdAt;

  Message({
    this.isVerified,
    this.createdDate,
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.isActive,
    this.city,
    this.pincode,
    this.updatedAt,
    this.createdAt,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    isVerified: json["is_verified"],
    createdDate: DateTime.parse(json["created_date"]),
    id: json["id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    email: json["email"],
    phoneNumber: json["phone_number"],
    isActive: json["is_active"],
    city: json["city"],
    pincode: json["pincode"],
    updatedAt: DateTime.parse(json["updatedAt"]),
    createdAt: DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "is_verified": isVerified,
    "created_date": createdDate.toIso8601String(),
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "phone_number": phoneNumber,
    "is_active": isActive,
    "city": city,
    "pincode": pincode,
    "updatedAt": updatedAt.toIso8601String(),
    "createdAt": createdAt.toIso8601String(),
  };
}
