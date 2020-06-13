class ProfileResponseModel {
  bool success;
  Message message;

  ProfileResponseModel({this.success, this.message});

  ProfileResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message =
        json['message'] != null ? new Message.fromJson(json['message']) : null;
  }
}

class Message {
  int id;
  String firstName;
  String email;
  String lastName;
  Null bio;
  String city;
  int isVerified;
  String state;
  String address;
  String phoneNumber;
  String banner;
  List<FoodPointEvents> events;
  List<HelpEvents> helps;
  int eventAttended;
  int eventPosted;

  Message(
      {this.id,
      this.firstName,
      this.email,
      this.lastName,
      this.bio,
      this.city,
      this.isVerified,
      this.state,
      this.address,
      this.phoneNumber,
      this.banner,
      this.events,
      this.helps,
      this.eventAttended,
      this.eventPosted});

  Message.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    email = json['email'];
    lastName = json['last_name'];
    bio = json['bio'];
    city = json['city'];
    isVerified = json['is_verified'];
    state = json['state'];
    address = json['address'];
    phoneNumber = json['phone_number'];
    banner = json['banner'];
    if (json['events'] != null) {
      events = new List<FoodPointEvents>();
      json['events'].forEach((v) {
        events.add(new FoodPointEvents.fromJson(v));
      });
    }
    if (json['helps'] != null) {
      helps = new List<HelpEvents>();
      json['helps'].forEach((v) {
        helps.add(new HelpEvents.fromJson(v));
      });
    }
    eventAttended = json['event_attended'];
    eventPosted = json['event_posted'];
  }
}

class FoodPointEvents {
  int id;
  String name;
  String description;
  String address;
  String place;
  Null rating;
  String city;
  String banner;
  String fee;
  String costType;
  String state;

  FoodPointEvents(
      {this.id,
      this.name,
      this.description,
      this.address,
      this.place,
      this.rating,
      this.city,
      this.banner,
      this.fee,
      this.costType,
      this.state});

  FoodPointEvents.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    address = json['address'];
    place = json['place'];
    rating = json['rating'];
    city = json['city'];
    banner = json['banner'];
    fee = json['fee'];
    costType = json['cost_type'];
    state = json['state'];
  }
}

class HelpEvents {
  int id;
  String address;
  String description;
  String type;
  String name;
  String city;
  int isCompleted;
  int completedCount;
  String postBy;
  String image;
  String state;

  HelpEvents(
      {this.id,
      this.address,
      this.description,
      this.type,
      this.name,
      this.city,
      this.isCompleted,
      this.completedCount,
      this.postBy,
      this.image,
      this.state});

  HelpEvents.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    address = json['address'];
    description = json['description'];
    type = json['type'];
    name = json['name'];
    city = json['city'];
    isCompleted = json['is_completed'];
    completedCount = json['completed_count'];
    postBy = json['post_by'];
    image = json['image'];
    state = json['state'];
  }
}
