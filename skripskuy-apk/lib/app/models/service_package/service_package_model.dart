class ServicePackage {
  int id;
  int service;
  String name;
  String type;
  String description;
  int cost;
  String createdAt;
  String updatedAt;

  ServicePackage(
      {this.id,
      this.service,
      this.name,
      this.type,
      this.description,
      this.cost,
      this.createdAt,
      this.updatedAt});

  ServicePackage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    service = json['service'];
    name = json['name'];
    type = json['type'];
    description = json['description'];
    cost = json['cost'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['service'] = service;
    data['name'] = name;
    data['type'] = type;
    data['description'] = description;
    data['cost'] = cost;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
