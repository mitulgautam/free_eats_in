import 'dart:convert';
import 'dart:io';

import 'package:freeeatsin/core/model/create_event_response_model.dart';
import 'package:freeeatsin/core/model/create_food_point_event_model.dart';
import 'package:freeeatsin/core/model/create_help_event_model.dart';
import 'package:freeeatsin/core/model/dashboard_events_response_model.dart';
import 'package:freeeatsin/core/model/dashboard_help_response_model.dart';
import 'package:freeeatsin/core/model/food_point_single_event_model.dart';
import 'package:freeeatsin/core/model/user_login_response_model.dart';
import 'package:freeeatsin/core/model/user_signup_model.dart';
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

  static Future<bool> userSignUp(UserSignUpModel model) async {
    try {
      final String url = Strings.API_BASE_URL + Strings.API_USER_SIGN_UP;
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields["first_name"] = model.firstName;
      request.fields["last_name"] = model.lastName;
      request.fields["email"] = model.email;
      request.fields["phone_number"] = model.phoneNumber;
      request.fields["city"] = model.city;
      request.fields["pincode"] = model.pincode;
      request.files.add(await http.MultipartFile.fromPath(
          'profile_url', model.profileImage.path));
      request.headers[HttpHeaders.contentTypeHeader] = 'multipart/form-data';
      var response = await request.send();
      print(response.statusCode);
      print(await response.stream.bytesToString());
      return response.statusCode == 200 ? true : false;
    } catch (e) {
      print(e);
    }
    return false;
  }

  static Future<String> userProfile(int userId) async {
    final String url = Strings.API_BASE_URL + Strings.API_USER_PROFILE;
    http.Response response = await http.post(url,
        body: json.encode({"user_id": userId}).toString(),
        headers: getHeaders());
    return response.body;
  }

  static Future<dynamic> getDashboardEvents(int userId) async {
    final String url =
        Strings.API_BASE_URL + Strings.API_DASHBOARD_FOOD_POINT_EVENTS;
    http.Response response = await http.post(url,
        body: json.encode({"user_id": userId}), headers: getHeaders());
    try {
      dashboardEventsResponseModelFromJson(response.body);
    } catch (e) {
      print(e);
    }
    return response.statusCode == 200
        ? dashboardEventsResponseModelFromJson(response.body)
        : false;
  }

  static Future<dynamic> getDashboardHelps(int userId) async {
    final String url = Strings.API_BASE_URL + Strings.API_DASHBOARD_HELP_EVENTS;
    http.Response response = await http.post(url,
        body: json.encode({"user_id": userId}), headers: getHeaders());
    print(userId);
    print(response.statusCode);
    return response.statusCode == 200
        ? dashboardHelpResponseModelFromJson(response.body)
        : false;
  }

  static Future<dynamic> postFoodPointEvent(
      CreateFoodPointEventModel model) async {
    try {
      final String url =
          Strings.API_BASE_URL + Strings.API_POST_FOOD_POINT_EVENT;
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields['description'] = model.description;
      request.fields['address'] = model.address;
      request.fields['frequency'] = model.frequency;
      request.fields['start_time'] = model.startTime;
      request.fields['date'] = jsonEncode(model.date);
      request.fields['user_id'] = model.userId.toString();
      request.fields['post_by'] = model.postBy;
      request.fields['name'] = model.name;
      request.fields['city'] = model.city;
      request.fields['place'] = model.place;
      request.fields['end_time'] = model.endTime;
      request.fields['items'] = model.items;
      request.fields['fee'] = model.fee;
      request.fields['cost'] = model.cost;
      request.fields['event_organizer'] = model.eventOrganizer;
      request.files
          .add(await http.MultipartFile.fromPath('banner', model.banner.path));
      request.headers[HttpHeaders.contentTypeHeader] = 'multipart/form-data';
      var response = await request.send();
      return response.statusCode == 201 ? true : false;
    } catch (e) {
      print(e);
    }
    return false;
  }

  static Future<dynamic> postHelpEvent(CreateHelpEventModel model) async {
    try {
      final String url =
          Strings.API_BASE_URL + Strings.API_POST_HELP_POST_EVENT;
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields['name'] = model.name;
      request.fields['address'] = model.address;
      request.fields['start_time'] = model.startTime;
      request.fields['date'] = model.date.toIso8601String();
      request.fields['user_id'] = model.userId.toString();
      request.fields['city'] = model.city;
      request.fields['type'] = model.type;
      request.fields['description'] = model.description;
      request.files
          .add(await http.MultipartFile.fromPath('banner', model.banner.path));
      request.headers[HttpHeaders.contentTypeHeader] = 'multipart/form-data';
      var response = await request.send();
      return response.statusCode == 200 ? true : false;
    } catch (e) {
      print(e);
    }
    return false;
  }

  static Future<dynamic> getSingleFoodPointEvent(int eventId) async {
    final String url = Strings.API_BASE_URL + Strings.API_POST_FOOD_POINT_EVENT;
    http.Response response =
        await http.get(url + "/$eventId", headers: getHeaders());
    return response.statusCode == 200
        ? foodPointSingleEventModelFromJson(response.body)
        : false;
  }

  static Future<bool> attendFoodPointEvent(int eventId, int userId) async {
    final String url =
        Strings.API_BASE_URL + Strings.API_ATTEND_FOOD_POINT_EVENT;
    http.Response response = await http.post(url + "/$eventId",
        headers: getHeaders(), body: json.encode({"user_id": userId}));
    return response.statusCode == 200 ? true : false;
  }

  static Future<bool> attendFoodHelpEvent(int eventId, int userId) async {
    final String url = Strings.API_BASE_URL + Strings.API_ATTEND_FOOD_HELP;
    http.Response response = await http.post(url + "/$eventId",
        headers: getHeaders(), body: json.encode({"user_id": userId}));
    return response.statusCode == 200 ? true : false;
  }

  static Map<String, String> getHeaders() {
    return {"Content-Type": "application/json"};
  }
}
