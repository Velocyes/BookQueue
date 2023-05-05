import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../config/api.dart';
import '../../service/service_model.dart';

class ServiceProvider extends GetConnect {
  String modelName = 'service';

  Future<Service> createService(
      {@required String userId,
      XFile profilePicture,
      @required String name,
      @required String address,
      @required String description,
      @required int vehicleType,
      @required String openHour,
      @required String closeHour}) async {
    FormData formData;
    if (profilePicture != null) {
      formData = new FormData({
        'user': userId,
        "profile_picture":
        await MultipartFile(profilePicture.path, filename: "service.jpg"),
        'name': name,
        'address': address,
        'description': description,
        'vehicle_type': vehicleType,
        'open_hour': openHour,
        'close_hour': closeHour,
      });
    } else {
      formData = new FormData({
        'user': userId,
        'name': name,
        'address': address,
        'description': description,
        'vehicle_type': vehicleType,
        'open_hour': openHour,
        'close_hour': closeHour,
      });
    }
    final response = await post(
        '$defaultBaseUrl/$AppName/api/$modelName/createService/',
        formData,
        contentType: "multipart/form-data");
    if (response.status.hasError) {
      return Future.error(response.status.code);
    } else if (response.body?.length == 0 ?? true) {
      return null;
    }
    return Service.fromJson(response.body);
  }

  Future<Service> updateService(
      {@required int id,
      XFile profilePicture,
      @required String name,
      @required String address,
      @required String description,
      @required int vehicleType,
      @required String openHour,
      @required String closeHour}) async {
    FormData formData;
    if (profilePicture != null) {
      formData = new FormData({
        "profile_picture":
            await MultipartFile(profilePicture.path, filename: "service.jpg"),
        'name': name,
        'address': address,
        'description': description,
        'vehicle_type': vehicleType,
        'open_hour': openHour,
        'close_hour': closeHour,
      });
    } else {
      formData = new FormData({
        'name': name,
        'address': address,
        'description': description,
        'vehicle_type': vehicleType,
        'open_hour': openHour,
        'close_hour': closeHour,
      });
    }
    final response = await patch(
      '$defaultBaseUrl/$AppName/api/$modelName/$id/',
      formData,
      contentType: "multipart/form-data",
    );
    if (response.status.hasError) {
      return Future.error(response.status.code);
    } else if (response.body.length == 0) {
      return null;
    }
    return Service.fromJson(response.body);
  }

  Future<Service> updateServiceStatus({
    @required int serviceId,
    bool isOpen,
  }) async {
    var data = {
      'is_open': isOpen,
    };
    final response = await patch(
        '$defaultBaseUrl/$AppName/api/$modelName/updateServiceStatus/?service_id=$serviceId',
        jsonEncode(data));
    if (response.status.hasError) {
      return Future.error(response.status.code);
    } else if (response.body.length == 0) {
      return null;
    }
    return Service.fromJson(response.body);
  }

  Future<Service> getServiceByUserId({String userId}) async {
    final response = await get(
        '$defaultBaseUrl/$AppName/api/$modelName?user__firebase_id=$userId');
    if (response.status.hasError) {
      return Future.error(response.status.code);
    } else if (response.body.length == 0) {
      return null;
    }
    return Service.fromJson(response.body[0]);
  }
}
