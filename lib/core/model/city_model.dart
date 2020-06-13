class StateAndCity {
  List<States> state;

  StateAndCity({this.state});

  StateAndCity.fromJson(Map<String, dynamic> json) {
    if (json['states'] != null) {
      state = new List<States>();
      json['states'].forEach((v) {
        state.add(new States.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.state != null) {
      data['states'] = this.state.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class States {
  String name;
  List<String> cities;

  States({this.name, this.cities});

  States.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    cities = json['cities'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['cities'] = this.cities;
    return data;
  }
}
