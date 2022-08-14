class trend_modelClass {
  late String mallName;
  late String storeName;
  late String description;
  late String photoURL;
  trend_modelClass(
    this.mallName,
    this.storeName,
    this.description,
    this.photoURL,
  );
  trend_modelClass.fromJson(Map<String, dynamic> json) {
    mallName = json['mallName'] ?? "";
    storeName = json['storeName'] ?? "";
    description = json['description'] ?? "";
    photoURL = json['photoURL'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mallName'] = this.mallName;
    data['storeName'] = this.storeName;
    data['description'] = this.description;
    data['photoURL'] = this.photoURL;
    return data;
  }
}
