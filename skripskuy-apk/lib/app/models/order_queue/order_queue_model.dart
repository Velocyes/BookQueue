class OrderQueue {
  int service;
  String date;
  int index;
  String createdAt;
  String updatedAt;

  OrderQueue(
      {this.service, this.date, this.index, this.createdAt, this.updatedAt});

  OrderQueue.fromJson(Map<String, dynamic> json) {
    service = json['service'];
    date = json['date'];
    index = json['index'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Future<void> fromJson(Map<String, dynamic> json) async {
    service = json['service'];
    date = json['date'];
    index = json['index'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['service'] = service;
    data['date'] = date;
    data['index'] = index;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
