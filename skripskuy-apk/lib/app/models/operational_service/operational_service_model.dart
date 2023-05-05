class OperationalService {
  int id;
  int service;
  bool isOpen;
  int day;
  String createdAt;
  String updatedAt;

  OperationalService(
      {this.id,
      this.service,
      this.isOpen,
      this.day,
      this.createdAt,
      this.updatedAt});

  OperationalService.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    service = json['service'];
    isOpen = json['is_open'];
    day = json['day'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Future<void> fromJson(Map<String, dynamic> json) async {
    id = json['id'];
    service = json['service'];
    isOpen = json['is_open'];
    day = json['day'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['service'] = service;
    data['is_open'] = isOpen;
    data['day'] = day;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
