import 'package:flutter/cupertino.dart';
import 'package:freeeatsin/core/model/user_login_response_model.dart';

class UserProvider with ChangeNotifier {
  UserLoginResponseModel _userLoginResponseModel;

  UserLoginResponseModel get userLoginResponseModel => _userLoginResponseModel;

  set userLoginResponseModel(UserLoginResponseModel value) {
    _userLoginResponseModel = value;
    notifyListeners();
  }
}
