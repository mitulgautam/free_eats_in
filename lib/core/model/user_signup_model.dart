// To parse this JSON data, do
//
//     final userSignUpModel = userSignUpModelFromJson(jsonString);

import 'dart:convert';
import 'dart:io';

class UserSignUpModel {
  String firstName;
  String lastName;
  String email;
  String phoneNumber;
  String city;
  String pincode;
  File profileImage;

  UserSignUpModel(
      {this.firstName,
      this.lastName,
      this.email,
      this.phoneNumber,
      this.city,
      this.pincode,
      this.profileImage});
}
