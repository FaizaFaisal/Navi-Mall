class mall_modelClass {
  late String name;
  late String phone;
  late String website;
  late String instagram;
  late String facebook;
  late String open_hour;
  late String close_hour;
  late String about;
  late String photoURL;

  mall_modelClass(
      this.name,
      this.phone,
      this.website,
      this.instagram,
      this.facebook,
      this.open_hour,
      this.close_hour,
      this.about,
      this.photoURL);

  mall_modelClass.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? "";
    phone = json['phone'] ?? "";
    website = json['website'] ?? "";
    instagram = json['instagram'] ?? "";
    facebook = json['facebook'] ?? "";
    open_hour = json['open_hour'] ?? "";
    close_hour = json['close_hour'] ?? "";
    about = json['about'] ?? "";
    photoURL = json['photoURL'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['website'] = this.website;
    data['instagram'] = this.instagram;
    data['facebook'] = this.facebook;
    data['open_hour'] = this.open_hour;
    data['close_hour'] = this.close_hour;
    data['about'] = this.about;
    data['photoURL'] = this.photoURL;

    return data;
  }
}
