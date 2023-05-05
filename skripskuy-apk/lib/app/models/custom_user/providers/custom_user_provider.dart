import 'dart:convert';

import 'package:get/get.dart';
import 'package:skripskuy_web/app/config/enums.dart';

import '../../../config/api.dart';
import '../custom_user_model.dart';

class CustomUserProvider extends GetConnect {
  String modelName = 'user';

  Future<CustomUser> createUser({
    String firebase_id,
    String firebase_token,
    String fullName,
    String phoneNumber,
    String email,
    String password,
  }) async {
    var data = {
      'firebase_id': firebase_id,
      'firebase_token': firebase_token,
      'user_role': UserRole.SERVICE_PROVIDER.index,
      'full_name': fullName,
      'phone_number': phoneNumber,
      'email': email,
    };
    final response = await post(
        '$defaultBaseUrl/$AppName/api/$modelName/', jsonEncode(data));
    if (response.status.hasError) {
      return Future.error(response.status.code);
    } else if (response.body.length == 0) {
      return null;
    }
    return CustomUser.fromJson(response.body);
  }

  Future<CustomUser> getUser({String firebaseId}) async {
    final response =
        await get('$defaultBaseUrl/$AppName/api/$modelName/$firebaseId/');
    if (response.status.hasError) {
      return Future.error(response.status.code);
    } else if (response.body.length == 0) {
      return null;
    }
    return CustomUser.fromJson(response.body);
  }

  Future<CustomUser> updateUser({
    String firebaseId,
    Map<String, dynamic> json,
  }) async {
    final response = await patch(
        '$defaultBaseUrl/$AppName/api/$modelName/$firebaseId/',
        jsonEncode(json));
    if (response.status.hasError) {
      return Future.error(response.status.code);
    } else if (response.body.length == 0) {
      return null;
    }
    return CustomUser.fromJson(response.body);
  }
}
