class OrderDetail {
  int order;
  String header;
  int quantity;
  int cost;
  String createdAt;
  String updatedAt;

  OrderDetail(
      {this.order,
      this.header,
      this.quantity,
      this.cost,
      this.createdAt,
      this.updatedAt});

  OrderDetail.fromJson(Map<String, dynamic> json) {
    order = json['order'];
    header = json['header'];
    quantity = json['quantity'];
    cost = json['cost'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Future<void >fromJson(Map<String, dynamic> json) {
    order = json['order'];
    header = json['header'];
    quantity = json['quantity'];
    cost = json['cost'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['order'] = order;
    data['header'] = header;
    data['quantity'] = quantity;
    data['cost'] = cost;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
