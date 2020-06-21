// To parse this JSON data, do
//
//     final userSignUpModel = userSignUpModelFromJson(jsonString);

import 'dart:io';

class UserSignUpModel {
  String firstName;
  String lastName;
  String email;
  String phoneNumber;
  String city;
  String state;
  String pincode;
  File profileImage;
  String bio;

  UserSignUpModel(
      {this.firstName,
      this.lastName,
      this.email,
      this.phoneNumber,
      this.state,
      this.city,
      this.pincode,
      this.bio,
      this.profileImage});
}
