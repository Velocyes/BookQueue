class OrderProcess {
  int service;
  String name;
  String createdAt;
  String updatedAt;

  OrderProcess({this.service, this.name, this.createdAt, this.updatedAt});

  OrderProcess.fromJson(Map<String, dynamic> json) {
    service = json['service'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Future<void> fromJson(Map<String, dynamic> json) async {
    service = json['service'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['service'] = service;
    data['name'] = name;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
