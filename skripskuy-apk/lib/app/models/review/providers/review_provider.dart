import 'dart:convert';

import 'package:get/get.dart';

import '../../../config/api.dart';

class ReviewProvider extends GetConnect {
  String modelName = 'review';

  Future<List<dynamic>> getReviewByServiceId({int serviceId}) async {
    final response = await get(
        '$defaultBaseUrl/$AppName/api/$modelName/getReviewByServiceId/?service_id=$serviceId');
    if (response.status.hasError) {
      return Future.error(response.statusText);
    } else if (response.body.length == 0) {
      return null;
    } else {
      return jsonDecode(response.bodyString);
    }
  }
}
