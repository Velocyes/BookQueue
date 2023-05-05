class Review {
  int id;
  int service;
  String userId;
  String date;
  int rating;
  String description;
  String createdAt;
  String updatedAt;

  Review(
      {this.id,
      this.service,
      this.userId,
      this.date,
      this.rating,
      this.description,
      this.createdAt,
      this.updatedAt});

  Review.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    service = json['service'];
    userId = json['user_id'];
    date = json['date'];
    rating = json['rating'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Future<void> fromJson(Map<String, dynamic> json) async {
    id = json['id'];
    service = json['service'];
    userId = json['user_id'];
    date = json['date'];
    rating = json['rating'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['service'] = service;
    data['user_id'] = userId;
    data['date'] = date;
    data['rating'] = rating;
    data['description'] = description;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
