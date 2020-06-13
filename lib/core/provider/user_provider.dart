import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:freeeatsin/core/model/city_model.dart';
import 'package:freeeatsin/core/model/profile_response_model.dart';
import 'package:freeeatsin/core/model/user_login_response_model.dart';
import 'package:freeeatsin/core/services/api.dart';

class UserProvider with ChangeNotifier {
  UserLoginResponseModel _userLoginResponseModel;
  ProfileResponseModel _profileResponseModel;
  String _city;

  String get city => _city;

  set city(String value) {
    _city = value;
    notifyListeners();
  }

  States _state;

  States get state => _state;

  set state(States value) {
    _state = value;
    notifyListeners();
  }

  ProfileResponseModel get profileResponseModel => _profileResponseModel;

  UserLoginResponseModel get userLoginResponseModel => _userLoginResponseModel;

  set userLoginResponseModel(UserLoginResponseModel value) {
    _userLoginResponseModel = value;
    notifyListeners();
  }

  void updateUserModel() async {
    API.userProfile(userLoginResponseModel.message.id).then((response) {
      _userLoginResponseModel.message.email = response.message.email;
      _userLoginResponseModel.message.firstName = response.message.firstName;
      _userLoginResponseModel.message.lastName = response.message.lastName;
      _userLoginResponseModel.message.address = response.message.address;
      _userLoginResponseModel.message.eventPosted =
          response.message.eventPosted;
      _userLoginResponseModel.message.eventAttended =
          response.message.eventAttended;
      _profileResponseModel = response;
      notifyListeners();
    });
  }
}
