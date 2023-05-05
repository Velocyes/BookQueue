import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../config/api.dart';
import '../service_package_model.dart';

class ServicePackageProvider extends GetConnect {
  String modelName = 'service-package';

  Future<ServicePackage> createServicePackage(
      {@required int serviceId,
      @required String name,
      @required String type,
      @required String description,
      @required int cost}) async {
    var data = {
      'service': serviceId,
      'name': name,
      'type': type,
      'description': description,
      'cost': cost,
    };
    final response = await post(
        '$defaultBaseUrl/$AppName/api/$modelName/', jsonEncode(data));
    if (response.status.hasError) {
      return Future.error(response.status.code);
    } else if (response.body.length == 0) {
      return null;
    }
    return ServicePackage.fromJson(response.body);
  }

  Future<ServicePackage> updateServicePackage(
      {@required int id,
      @required String name,
      @required String type,
      @required String description,
      @required int cost}) async {
    var data = {
      'name': name,
      'type': type,
      'description': description,
      'cost': cost,
    };
    final response = await patch(
        '$defaultBaseUrl/$AppName/api/$modelName/$id/', jsonEncode(data));
    if (response.status.hasError) {
      return Future.error(response.status.code);
    } else if (response.body.length == 0) {
      return null;
    }
    return ServicePackage.fromJson(response.body);
  }

  Future<bool> deleteServicePackage(
      {int id}) async {
    final response = await delete(
        '$defaultBaseUrl/$AppName/api/$modelName/$id/');
    if (response.status.hasError) {
      return Future.error(response.status.code);
    }
    return true;
  }

  Future<List<ServicePackage>> getServicePackageByServiceId(
      {int serviceId}) async {
    final response = await get(
        '$defaultBaseUrl/$AppName/api/$modelName?service__id=$serviceId');
    if (response.status.hasError) {
      return Future.error(response.status.code);
    } else if (response.body.length == 0) {
      return null;
    }
    return (jsonDecode(response.bodyString) as List)
        .map((servicePackageJson) => ServicePackage.fromJson(servicePackageJson))
        .toList();
  }
}
