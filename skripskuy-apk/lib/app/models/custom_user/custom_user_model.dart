class CustomUser {
  String firebaseId;
  String firebaseToken;
  String urlPhoto;
  String fullName;
  String phoneNumber;
  String email;
  String createdAt;
  String updatedAt;
  int userRole;

  CustomUser(
      {this.firebaseId,
      this.firebaseToken,
      this.urlPhoto,
      this.fullName,
      this.phoneNumber,
      this.email,
      this.createdAt,
      this.updatedAt,
      this.userRole});

  CustomUser.fromJson(Map<String, dynamic> json) {
    firebaseId = json['firebase_id'];
    firebaseToken = json['firebase_token'];
    urlPhoto = json['url_photo'];
    fullName = json['full_name'];
    phoneNumber = json['phone_number'];
    email = json['email'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    userRole = json['user_role'];
  }

  Future<void> fromJson(Map<String, dynamic> json) async {
    firebaseId = json['firebase_id'];
    firebaseToken = json['firebase_token'];
    urlPhoto = json['url_photo'];
    fullName = json['full_name'];
    phoneNumber = json['phone_number'];
    email = json['email'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    userRole = json['user_role'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['firebase_id'] = firebaseId;
    data['firebase_token'] = firebaseToken;
    data['url_photo'] = urlPhoto;
    data['full_name'] = fullName;
    data['phone_number'] = phoneNumber;
    data['email'] = email;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['user_role'] = userRole;
    return data;
  }
}
