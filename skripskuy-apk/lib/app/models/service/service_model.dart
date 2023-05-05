class Service {
  int id;
  String user;
  String profilePicture;
  String name;
  String address;
  int vehicleType;
  String description;
  bool isOpen;
  String openHour;
  String closeHour;
  String createdAt;
  String updatedAt;

  Service(
      {this.id,
      this.user,
      this.profilePicture,
      this.name,
      this.address,
      this.vehicleType,
      this.description,
      this.isOpen,
      this.openHour,
      this.closeHour,
      this.createdAt,
      this.updatedAt});

  Service.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'];
    profilePicture = json['profile_picture'];
    name = json['name'];
    address = json['address'];
    vehicleType = json['vehicle_type'];
    description = json['description'];
    isOpen = json['is_open'];
    openHour = json['open_hour'];
    closeHour = json['close_hour'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Future<void> fromJson(Map<String, dynamic> json) async {
    id = json['id'];
    user = json['user'];
    profilePicture = json['profile_picture'];
    name = json['name'];
    address = json['address'];
    vehicleType = json['vehicle_type'];
    description = json['description'];
    isOpen = json['is_open'];
    openHour = json['open_hour'];
    closeHour = json['close_hour'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['user'] = user;
    data['profile_picture'] = profilePicture;
    data['name'] = name;
    data['address'] = address;
    data['vehicle_type'] = vehicleType;
    data['description'] = description;
    data['is_open'] = isOpen;
    data['open_hour'] = openHour;
    data['close_hour'] = closeHour;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
