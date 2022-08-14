import 'package:cloud_firestore/cloud_firestore.dart';

class service_modelClass {
  late String store_name;
  late String phone;
  late String category;
  late String section;
  late String open_hour;
  late String close_hour;
  late String about;
  late String photoURL;
  late GeoPoint location;

  service_modelClass(
    this.store_name,
    this.phone,
    this.category,
    this.section,
    this.open_hour,
    this.close_hour,
    this.about,
    this.photoURL,
    this.location,
  );
  service_modelClass.fromJson(Map<String, dynamic> json) {
    store_name = json['store_name'] ?? "";
    phone = json['phone'] ?? "";
    category = json['category'] ?? "";
    section = json['section'] ?? "";
    location = json['location'] ?? "";
    open_hour = json['open_hour'] ?? "";
    close_hour = json['close_hour'] ?? "";
    about = json['about'] ?? "";
    photoURL = json['photoURL'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['store_name'] = this.store_name;
    data['phone'] = this.phone;
    data['category'] = this.category;
    data['section'] = this.section;
    data['location'] = this.location;
    data['open_hour'] = this.open_hour;
    data['close_hour'] = this.close_hour;
    data['about'] = this.about;
    data['photoURL'] = this.photoURL;

    return data;
  }
}
