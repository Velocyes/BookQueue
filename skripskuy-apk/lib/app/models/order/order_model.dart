class Order {
  int id;
  int service;
  String user;
  int index;
  String date;
  String plateNumber;
  int servicePackage;
  int orderStatus;
  String createdAt;
  String updatedAt;

  Order(
      {this.id,
      this.service,
      this.user,
      this.index,
      this.date,
      this.plateNumber,
      this.servicePackage,
      this.orderStatus,
      this.createdAt,
      this.updatedAt});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    service = json['service'];
    user = json['user'];
    index = json['index'];
    date = json['date'];
    plateNumber = json['plateNumber'];
    servicePackage = json['service_package'];
    orderStatus = json['order_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Future<void> fromJson(Map<String, dynamic> json) async {
    id = json['id'];
    service = json['service'];
    user = json['user'];
    index = json['index'];
    date = json['date'];
    plateNumber = json['plateNumber'];
    servicePackage = json['service_package'];
    orderStatus = json['order_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['service'] = service;
    data['user'] = user;
    data['index'] = index;
    data['date'] = date;
    data['plateNumber'] = plateNumber;
    data['service_package'] = servicePackage;
    data['order_status'] = orderStatus;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
