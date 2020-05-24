// To parse this JSON data, do
//
//     final city = cityFromJson(jsonString);

import 'dart:convert';

List<City> cityFromJson(String str) =>
    List<City>.from(json.decode(str).map((x) => City.fromJson(x)));

String cityToJson(List<City> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class City {
  String city;
  States state;
  String district;

  City({
    this.city,
    this.state,
    this.district,
  });

  factory City.fromJson(Map<String, dynamic> json) => City(
        city: json["City"],
        state: stateValues.map[json["State"]],
        district: json["District"],
      );

  Map<String, dynamic> toJson() => {
        "City": city,
        "State": stateValues.reverse[state],
        "District": district,
      };
}

enum States {
  ANDAMAN_NICOBAR_ISLANDS,
  ANDHRA_PRADESH,
  ARUNACHAL_PRADESH,
  ASSAM,
  BIHAR,
  CHANDIGARH,
  CHHATTISGARH,
  DADRA_NAGAR_HAVELI,
  DAMAN_DIU,
  DELHI,
  GOA,
  GUJARAT,
  HARYANA,
  HIMACHAL_PRADESH,
  JAMMU_KASHMIR,
  JHARKHAND,
  KARNATAKA,
  KERALA,
  LAKSHADWEEP,
  MADHYA_PRADESH,
  MAHARASHTRA,
  MANIPUR,
  MEGHALAYA,
  MIZORAM,
  NAGALAND,
  ORISSA,
  PONDICHERRY,
  PUNJAB,
  RAJASTHAN,
  SIKKIM,
  TAMIL_NADU,
  TRIPURA,
  UTTAR_PRADESH,
  UTTARANCHAL,
  WEST_BENGAL
}

final stateValues = EnumValues({
  "Andaman & Nicobar Islands *": States.ANDAMAN_NICOBAR_ISLANDS,
  "Andhra Pradesh": States.ANDHRA_PRADESH,
  "Arunachal Pradesh": States.ARUNACHAL_PRADESH,
  "Assam": States.ASSAM,
  "Bihar": States.BIHAR,
  "Chandigarh *": States.CHANDIGARH,
  "Chhattisgarh": States.CHHATTISGARH,
  "Dadra & Nagar Haveli *": States.DADRA_NAGAR_HAVELI,
  "Daman & Diu *": States.DAMAN_DIU,
  "Delhi *": States.DELHI,
  "Goa": States.GOA,
  "Gujarat": States.GUJARAT,
  "Haryana": States.HARYANA,
  "Himachal Pradesh": States.HIMACHAL_PRADESH,
  "Jammu & Kashmir": States.JAMMU_KASHMIR,
  "Jharkhand": States.JHARKHAND,
  "Karnataka": States.KARNATAKA,
  "Kerala": States.KERALA,
  "Lakshadweep *": States.LAKSHADWEEP,
  "Madhya Pradesh": States.MADHYA_PRADESH,
  "Maharashtra": States.MAHARASHTRA,
  "Manipur": States.MANIPUR,
  "Meghalaya": States.MEGHALAYA,
  "Mizoram": States.MIZORAM,
  "Nagaland": States.NAGALAND,
  "Orissa": States.ORISSA,
  "Pondicherry *": States.PONDICHERRY,
  "Punjab": States.PUNJAB,
  "Rajasthan": States.RAJASTHAN,
  "Sikkim": States.SIKKIM,
  "Tamil Nadu": States.TAMIL_NADU,
  "Tripura": States.TRIPURA,
  "Uttaranchal": States.UTTARANCHAL,
  "Uttar Pradesh": States.UTTAR_PRADESH,
  "West Bengal": States.WEST_BENGAL
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
