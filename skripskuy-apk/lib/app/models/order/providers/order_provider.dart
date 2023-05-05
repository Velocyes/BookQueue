import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/api.dart';
import '../../../config/enums.dart';
import '../order_model.dart';

class OrderProvider extends GetConnect {
  String modelName = 'order';

  Future<bool> createOrder({
    int serviceId,
    String firebase_id,
    String plateNumber,
    int service_package_id,
  }) async {
    var data = {
      'user': firebase_id,
      'service': serviceId,
      'order_status': OrderStatus.BELUM_DIKERJAKAN.index,
      'plate_number': plateNumber,
      'service_package': service_package_id
    };
    final response = await post(
        '$defaultBaseUrl/$AppName/api/$modelName/createOrder/',
        jsonEncode(data));
    if (response.status.hasError) {
      if (response.statusCode == 403) {
        if (response.body == "EXISTED ORDER") {
          Get.snackbar("Terdapat kesalahan",
              "Kamu memiliki antrian yang belum diselesaikan",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.white,
              borderRadius: 20);
        } else if (response.body == "ALREADY ORDERED") {
          Get.snackbar("Terdapat kesalahan",
              "Kamu telah memesan service ini pada hari ini",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.white,
              borderRadius: 20);
        }
      }
      return Future.error(response.statusCode);
    } else if (response.body.length == 0) {
      return null;
    }
    return true;
  }

  Future<bool> orderChecking({
    int serviceId,
    String firebase_id,
  }) async {
    final response = await get(
        '$defaultBaseUrl/$AppName/api/$modelName/orderChecking/?user_id=$firebase_id&service_id=$serviceId');
    if (response.status.hasError) {
      if (response.statusCode == 403) {
        if (response.body == "EXISTED ORDER") {
          Get.snackbar("Terdapat kesalahan",
              "Kamu memiliki antrian yang belum diselesaikan",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.white,
              borderRadius: 20);
        } else if (response.body == "ALREADY ORDERED") {
          Get.snackbar("Terdapat kesalahan",
              "Kamu telah memesan service ini pada hari ini",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.white,
              borderRadius: 20);
        }
      }
      return Future.error(response.statusCode);
    } else if (response.body.length == 0) {
      return null;
    }
    return true;
  }

  Future<Map<String, dynamic>> getUserQueueJson({String userId}) async {
    final response = await get(
        '$defaultBaseUrl/$AppName/api/$modelName/getUserQueueJson/?user_id=$userId');
    if (response.status.hasError) {
      return Future.error(response.status.code);
    } else if (response.body.length == 0) {
      return null;
    }
    return jsonDecode(response.bodyString)[0];
  }

  Future<List<dynamic>> getUndoneOrderJson({int serviceId}) async {
    final response = await get(
        '$defaultBaseUrl/$AppName/api/$modelName/getUndoneOrderJson/?service_id=$serviceId');
    if (response.status.hasError) {
      return Future.error(response.status.code);
    } else if (response.body.length == 0) {
      return null;
    }
    return jsonDecode(response.bodyString);
  }

  Future<List<dynamic>> getCancelledOrderJson({int serviceId}) async {
    final response = await get(
        '$defaultBaseUrl/$AppName/api/$modelName/getCancelledOrderJson/?service_id=$serviceId');
    if (response.status.hasError) {
      return Future.error(response.status.code);
    } else if (response.body.length == 0) {
      return null;
    }
    return jsonDecode(response.bodyString);
  }

  Future<List<dynamic>> getOnProgressOrderJson({int serviceId}) async {
    final response = await get(
        '$defaultBaseUrl/$AppName/api/$modelName/getOnProgressOrderJson/?service_id=$serviceId');
    if (response.status.hasError) {
      return Future.error(response.status.code);
    } else if (response.body.length == 0) {
      return null;
    }
    return jsonDecode(response.bodyString);
  }

  Future<List<dynamic>> getDoneOrderJson({int serviceId}) async {
    final response = await get(
        '$defaultBaseUrl/$AppName/api/$modelName/getDoneOrderJson/?service_id=$serviceId');
    if (response.status.hasError) {
      return Future.error(response.status.code);
    } else if (response.body.length == 0) {
      return null;
    }
    return jsonDecode(response.bodyString);
  }

  Future<Map<String, dynamic>> getOrderHistoryJson({int orderId}) async {
    final response = await get(
        '$defaultBaseUrl/$AppName/api/$modelName/getOrderHistoryJson/?order_id=$orderId');
    if (response.status.hasError) {
      return Future.error(response.status.code);
    } else if (response.body.length == 0) {
      return null;
    }
    return jsonDecode(response.bodyString)[0];
  }

  Future<List<dynamic>> getServiceProviderOrderHistory(
      {int serviceId, String fromDate, String toDate}) async {
    final response = await get(
        '$defaultBaseUrl/$AppName/api/$modelName/getServiceProviderOrderHistory/?service_id=$serviceId&from_date=$fromDate&to_date=$toDate');
    if (response.status.hasError) {
      return Future.error(response.status.code);
    } else if (response.body.length == 0) {
      return null;
    }
    return jsonDecode(response.bodyString);
  }

  Future<Map<String, dynamic>> getTodayOrderQueueJson({int serviceId}) async {
    final response = await get(
        '$defaultBaseUrl/$AppName/api/$modelName/getTodayOrderQueueJson/?service_id=$serviceId');
    if (response.status.hasError) {
      return Future.error(response.status.code);
    } else if (response.body.length == 0) {
      return null;
    }
    return jsonDecode(response.bodyString)[0];
  }

  Future<Map<String, dynamic>> getThisMonthOrderStatisticJson(
      {int serviceId}) async {
    final response = await get(
        '$defaultBaseUrl/$AppName/api/$modelName/getThisMonthOrderStatisticJson/?service_id=$serviceId');
    if (response.status.hasError) {
      return Future.error(response.status.code);
    } else if (response.body.length == 0) {
      return null;
    }
    return jsonDecode(response.bodyString)[0];
  }

  Future<Map<String, dynamic>> getTodayIncomeJson({int serviceId}) async {
    final response = await get(
        '$defaultBaseUrl/$AppName/api/$modelName/getTodayIncomeJson/?service_id=$serviceId');
    if (response.status.hasError) {
      return Future.error(response.status.code);
    } else if (response.body.length == 0) {
      return null;
    }
    return jsonDecode(response.bodyString)[0];
  }

  Future<Map<String, dynamic>> getTodayOrderStatisticJson(
      {int serviceId}) async {
    final response = await get(
        '$defaultBaseUrl/$AppName/api/$modelName/getTodayOrderStatisticJson/?service_id=$serviceId');
    if (response.status.hasError) {
      return Future.error(response.status.code);
    } else if (response.body.length == 0) {
      return null;
    }
    return jsonDecode(response.bodyString)[0];
  }

  Future<Map<String, dynamic>> getThisMonthIncomeJson({int serviceId}) async {
    final response = await get(
        '$defaultBaseUrl/$AppName/api/$modelName/getThisMonthIncomeJson/?service_id=$serviceId');
    if (response.status.hasError) {
      return Future.error(response.status.code);
    } else if (response.body.length == 0) {
      return null;
    }
    return jsonDecode(response.bodyString)[0];
  }

  Future<Order> processingOrder({int orderId}) async {
    var data = {
      'order_status': OrderStatus.SEDANG_DIKERJAKAN.index,
    };
    final response = await patch(
        '$defaultBaseUrl/$AppName/api/$modelName/processingOrder/?order_id=$orderId',
        jsonEncode(data));
    if (response.status.hasError) {
      return Future.error(response.status.code);
    } else if (response.body.length == 0) {
      return null;
    }
    return Order.fromJson(jsonDecode(response.bodyString));
  }

  Future<Order> cancelOrder({int orderId, String cancelNotes}) async {
    var data = {
      'notes': cancelNotes,
      'order_status': OrderStatus.DIBATALKAN.index,
    };
    final response = await patch(
        '$defaultBaseUrl/$AppName/api/$modelName/cancelOrder/?order_id=$orderId',
        jsonEncode(data));
    if (response.status.hasError) {
      return Future.error(response.status.code);
    } else if (response.body.length == 0) {
      return null;
    }
    return Order.fromJson(jsonDecode(response.bodyString));
  }

  Future<Order> finishingOrder({int orderId}) async {
    var data = {
      'order_status': OrderStatus.SELESAI.index,
    };
    final response = await patch(
        '$defaultBaseUrl/$AppName/api/$modelName/finishingOrder/?order_id=$orderId',
        jsonEncode(data));
    if (response.status.hasError) {
      return Future.error(response.status.code);
    } else if (response.body.length == 0) {
      return null;
    }
    return Order.fromJson(jsonDecode(response.bodyString));
  }

  Future<Order> paidOrder({int orderId}) async {
    var data = {
      'order_status': OrderStatus.DIBAYAR.index,
    };
    final response = await patch(
        '$defaultBaseUrl/$AppName/api/$modelName/paidOrder/?order_id=$orderId',
        jsonEncode(data));
    if (response.status.hasError) {
      return Future.error(response.status.code);
    } else if (response.body.length == 0) {
      return null;
    }
    return Order.fromJson(jsonDecode(response.bodyString));
  }
}
