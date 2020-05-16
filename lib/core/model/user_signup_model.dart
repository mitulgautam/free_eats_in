// To parse this JSON data, do
//
//     final userSignUpModel = userSignUpModelFromJson(jsonString);

import 'dart:convert';

UserSignUpModel userSignUpModelFromJson(String str) => UserSignUpModel.fromJson(json.decode(str));

String userSignUpModelToJson(UserSignUpModel data) => json.encode(data.toJson());

class UserSignUpModel {
  String firstName;
  String lastName;
  String email;
  String phoneNumber;
  String city;
  String pincode;

  UserSignUpModel({
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.city,
    this.pincode,
  });

  factory UserSignUpModel.fromJson(Map<String, dynamic> json) => UserSignUpModel(
    firstName: json["first_name"],
    lastName: json["last_name"],
    email: json["email"],
    phoneNumber: json["phone_number"],
    city: json["city"],
    pincode: json["pincode"],
  );

  Map<String, dynamic> toJson() => {
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "phone_number": phoneNumber,
    "city": city,
    "pincode": pincode,
  };
}
