// To parse this JSON data, do
//
//     final userSignUpModel = userSignUpModelFromJson(jsonString);

import 'dart:convert';
import 'dart:typed_data';

UserSignUpModel userSignUpModelFromJson(String str) =>
    UserSignUpModel.fromJson(json.decode(str));

String userSignUpModelToJson(UserSignUpModel data) =>
    json.encode(data.toJson());

class UserSignUpModel {
  String firstName;
  String lastName;
  String email;
  String phoneNumber;
  String city;
  String pincode;
  Uint8List profileImage;

  UserSignUpModel(
      {this.firstName,
      this.lastName,
      this.email,
      this.phoneNumber,
      this.city,
      this.pincode,
      this.profileImage});

  factory UserSignUpModel.fromJson(Map<String, dynamic> json) =>
      UserSignUpModel(
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        city: json["city"],
        pincode: json["pincode"],
        profileImage: json["profile_url"],
      );

  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "phone_number": phoneNumber,
        "city": city,
        "pincode": pincode,
        "profile_url": profileImage
      };
}
