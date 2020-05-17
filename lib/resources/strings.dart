class Strings {
  static const String HOMEPAGE = '/homepage';
  static const String ADD_EVENT = '/add-event';
  static const String EVENT_DETAILS = '/event-details';
  static const String PROFILE = '/profile';
  static const String SPLASH = '/splash';
  static const String LOGIN = '/login';
  static const String SIGN_UP = '/signup';

  //shared_preferences_keys
  static const String LOGIN_NUMBER = "login_number";
  static const String LOGIN_FIREBASE_UID = "firebase_uid";

  //API calling links
  static const String API_BASE_URL = "http://35.184.81.193:3000/";
  static const String API_USER_LOGIN = "user/login";
  static const String API_USER_SIGN_UP = "user/signup";
  static const String API_USER_PROFILE = "user/profile";
  static const String API_DASHBOARD_EVENTS = "events/users";
  static const String API_POST_FOOD_POINT_EVENT= "events";
}

enum Cost { FREE, PAID }
enum Frequency { ONCE, DAILY, RANDOM }
