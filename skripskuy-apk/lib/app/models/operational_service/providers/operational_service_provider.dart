import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../config/api.dart';
import '../operational_service_model.dart';

class OperationalServiceProvider extends GetConnect {
  String modelName = 'operational-service';

  Future<OperationalService> createOperationalService({
    @required int serviceId,
    @required int day,
    @required bool isOpen,
  }) async {
    var data = {
      "service": serviceId,
      "day": day,
      "is_open": isOpen,
    };
    final response = await post(
        '$defaultBaseUrl/$AppName/api/$modelName/', jsonEncode(data));
    if (response.status.hasError) {
      return Future.error(response.status.code);
    } else if (response.body.length == 0) {
      return null;
    }
    return OperationalService.fromJson(response.body);
  }

  Future<OperationalService> updateOperationalService({
    @required int id,
    @required bool isOpen,
  }) async {
    var data = {
      "is_open": isOpen,
    };
    final response = await patch(
        '$defaultBaseUrl/$AppName/api/$modelName/$id/', jsonEncode(data));
    if (response.status.hasError) {
      return Future.error(response.status.code);
    } else if (response.body.length == 0) {
      return null;
    }
    return OperationalService.fromJson(response.body);
  }

  Future<List<OperationalService>> getOperationalServiceByServiceId({
    @required int serviceId,
  }) async {
    final response = await get(
        '$defaultBaseUrl/$AppName/api/$modelName/?service__id=$serviceId');
    if (response.status.hasError) {
      return Future.error(response.status.code);
    } else if (response.body.length == 0) {
      return null;
    }
    return (json.decode(response.bodyString) as List)
        .map((operationalServiceJson) => OperationalService.fromJson(operationalServiceJson))
        .toList();
  }
}
