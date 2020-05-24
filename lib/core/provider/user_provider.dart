import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:freeeatsin/core/model/user_login_response_model.dart';
import 'package:freeeatsin/core/services/api.dart';

class UserProvider with ChangeNotifier {
  UserLoginResponseModel _userLoginResponseModel;

  UserLoginResponseModel get userLoginResponseModel => _userLoginResponseModel;

  set userLoginResponseModel(UserLoginResponseModel value) {
    _userLoginResponseModel = value;
    notifyListeners();
  }

  void updateUserModel() async {
    API.userProfile(userLoginResponseModel.message.id).then((response) {
      _userLoginResponseModel.message.email =
          json.decode(response)["message"]["email"];
      _userLoginResponseModel.message.firstName =
          json.decode(response)["message"]["first_name"];
      _userLoginResponseModel.message.lastName =
          json.decode(response)["message"]["last_name"];
      _userLoginResponseModel.message.address =
          json.decode(response)["message"]["address"];
      _userLoginResponseModel.message.eventPosted =
          json.decode(response)["message"]["event_posted"];
      _userLoginResponseModel.message.eventAttended =
          json.decode(response)["message"]["event_attended"];
      notifyListeners();
    });
  }
}
