import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../config/api.dart';

class OrderProcessProvider extends GetConnect {
  String modelName = 'order-process';

  Future<bool> createOrderProcess({
    @required int orderId,
    @required String processName
  }) async {
    var data = {
      'order': orderId,
      'name': processName,
    };
    final response = await post(
        '$defaultBaseUrl/$AppName/api/$modelName/createOrderProcess/', jsonEncode(data));
    if (response.status.hasError) {
      return Future.error(response.statusCode);
    } else if (response.body.length == 0) {
      return null;
    }
    return true;
  }
}
