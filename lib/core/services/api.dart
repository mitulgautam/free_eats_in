import 'dart:convert';

import 'package:freeeatsin/core/model/create_event_response_model.dart';
import 'package:freeeatsin/core/model/create_food_point_event_model.dart';
import 'package:freeeatsin/core/model/dashboard_events_response_model.dart';
import 'package:freeeatsin/core/model/user_login_response_model.dart';
import 'package:freeeatsin/core/model/user_signup_model.dart';
import 'package:freeeatsin/core/model/user_signup_response_model.dart';
import 'package:freeeatsin/resources/strings.dart';
import 'package:http/http.dart' as http;

class API {
  static Future<dynamic> userLogin(String phoneNumber) async {
    final String url = Strings.API_BASE_URL + Strings.API_USER_LOGIN;
    http.Response response = await http.post(url,
        body: json.encode({"phone_number": phoneNumber}).toString(),
        headers: getHeaders());
    return response.statusCode == 200
        ? userLoginResponseModelFromJson(response.body)
        : false;
  }

  static Future<dynamic> userSignUp(UserSignUpModel model) async {
    final String url = Strings.API_BASE_URL + Strings.API_USER_SIGN_UP;
    http.Response response = await http.post(url,
        body: userSignUpModelToJson(model), headers: getHeaders());
    return response.statusCode == 200
        ? userSignUpResponseModelFromJson(response.body)
        : false;
  }

  static Future<dynamic> getDashboardEvents(int userId) async {
    final String url = Strings.API_BASE_URL + Strings.API_DASHBOARD_EVENTS;
    http.Response response = await http.post(url,
        body: json.encode({"user_id": userId}), headers: getHeaders());
    print(response.body);
    return response.statusCode == 200
        ? dashboardEventsResponseModelFromJson(response.body)
        : false;
  }

  static Future<dynamic> postFoodPointEvent(
      CreateFoodPointEventModel model) async {
    final String url = Strings.API_BASE_URL + Strings.API_POST_FOOD_POINT_EVENT;
    http.Response response = await http.post(url,
        body: createEventModelToJson(model), headers: getHeaders());
    print(response.body);
    return response.statusCode == 200
        ? createEventResponseModelFromJson(response.body)
        : false;
  }

  static Map<String, String> getHeaders() {
    return {"Content-Type": "application/json"};
  }
}
