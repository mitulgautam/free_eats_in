// To parse this JSON data, do
//
//     final userLoginResponseModel = userLoginResponseModelFromJson(jsonString);

import 'dart:convert';

UserLoginResponseModel userLoginResponseModelFromJson(String str) =>
    UserLoginResponseModel.fromJson(json.decode(str));

String userLoginResponseModelToJson(UserLoginResponseModel data) =>
    json.encode(data.toJson());

class UserLoginResponseModel {
  bool success;
  Message message;

  UserLoginResponseModel({
    this.success,
    this.message,
  });

  factory UserLoginResponseModel.fromJson(Map<String, dynamic> json) =>
      UserLoginResponseModel(
        success: json["success"],
        message: Message.fromJson(json["message"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message.toJson(),
      };
}

class Message {
  int id;
  String firstName;
  String email;
  String phoneNumber;
  String city;
  String address;
  String image;
  String pincode;
  bool isActive;
  bool isVerified;
  String alternatePhoneNo;
  String lastName;
  int eventPosted;
  int eventAttended;
  DateTime createdDate;
  DateTime createdAt;
  DateTime updatedAt;

  Message(
      {this.id,
      this.firstName,
      this.email,
      this.phoneNumber,
      this.city,
      this.address,
      this.image,
      this.pincode,
      this.isActive,
      this.isVerified,
      this.alternatePhoneNo,
      this.lastName,
      this.createdDate,
      this.createdAt,
      this.updatedAt,
      this.eventAttended,
      this.eventPosted});

  factory Message.fromJson(Map<String, dynamic> json) => Message(
      id: json["id"] ?? "",
      firstName: json["first_name"] ?? "",
      email: json["email"] ?? "",
      phoneNumber: json["phone_number"] ?? "",
      city: json["city"] ?? "",
      address: json["address"] ?? "",
      image: json["image"] ?? "",
      pincode: json["pincode"] ?? "",
      isActive: json["is_active"] ?? "",
      isVerified: json["is_verified"] ?? "",
      alternatePhoneNo: json["alternate_phone_no"] ?? "",
      lastName: json["last_name"] ?? "",
      createdDate: DateTime.parse(json["created_date"]),
      createdAt: DateTime.parse(json["createdAt"]),
      updatedAt: DateTime.parse(json["updatedAt"]),
      eventAttended: 0,
      eventPosted: 0);

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "email": email,
        "phone_number": phoneNumber,
        "city": city,
        "address": address,
        "image": image,
        "pincode": pincode,
        "is_active": isActive,
        "is_verified": isVerified,
        "alternate_phone_no": alternatePhoneNo,
        "last_name": lastName,
        "created_date": createdDate.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
