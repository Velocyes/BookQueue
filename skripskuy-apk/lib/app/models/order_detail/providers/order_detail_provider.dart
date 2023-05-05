import 'dart:convert';

import 'package:get/get.dart';

import '../../../config/api.dart';
import '../order_detail_model.dart';

class OrderDetailProvider extends GetConnect {
  String modelName = 'order-detail';

  Future<bool> createOrderDetail({
    int orderId,
    int quantity,
    String header,
    int price,
  }) async {
    var data = {
      'order': orderId,
      'header': header,
      'quantity': quantity,
      'cost': price
    };
    final response = await post(
        '$defaultBaseUrl/$AppName/api/$modelName/', jsonEncode(data));
    if (response.status.hasError) {
      return Future.error(response.statusCode);
    } else if (response.body.length == 0) {
      return null;
    }
    return true;
  }

  Future<List<OrderDetail>> getOrderDetailByOrderId({int orderId}) async {
    final response = await get(
        '$defaultBaseUrl/$AppName/api/$modelName/?order__id=$orderId');
    if (response.status.hasError) {
      return Future.error(response.statusCode);
    } else if (response.body.length == 0) {
      return null;
    }
    return (jsonDecode(response.bodyString) as List).map((orderDetailJson) => OrderDetail.fromJson(orderDetailJson)).toList();
  }
}
