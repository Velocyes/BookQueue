import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skripskuy_web/app/models/review/providers/review_provider.dart';
import 'package:skripskuy_web/app/models/service/service_model.dart';

import '../../../controllers/auth_controller.dart';
import '../../../controllers/notification_controller.dart';
import '../../../models/service/providers/service_provider.dart';

class ReviewViewController extends GetxController
    with StateMixin<List<dynamic>> {
  final authController = Get.find<AuthController>();
  final ServiceProvider serviceProvider = ServiceProvider();
  final ReviewProvider reviewProvider = ReviewProvider();

  var serviceObj = Service().obs;

  Stream updateUINotifier =
      Get.find<NotificationController>().updateUINotifier.stream;

  @override
  void onInit() {
    super.onInit();
    updateUINotifier.listen((_) {
      initReview();
    });
    initReview();
  }

  Future<void> onRefresh() async {
    initReview();
  }

  void initReview() async {
    try {
      change(null, status: RxStatus.loading());
      serviceProvider
          .getServiceByUserId(userId: authController.getCurrentFirebaseId)
          .then((serviceObj) {
        this.serviceObj = serviceObj.obs;
        reviewProvider
            .getReviewByServiceId(serviceId: this.serviceObj?.value?.id ?? 0)
            .then((reviewJsons) {
          if (reviewJsons != null) {
            change(reviewJsons, status: RxStatus.success());
          } else {
            change(null, status: RxStatus.success());
          }
        });
      });
    } catch (e) {
      print(e);
      Get.snackbar("Terdapat kesalahan",
          "Permintaan tidak dapat di proses (Kesalahan Sistem)",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
          borderRadius: 20);
    }
  }
}
