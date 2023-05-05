import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skripskuy_web/app/models/service/providers/service_provider.dart';
import 'package:skripskuy_web/app/models/service/service_model.dart';

import '../../../controllers/auth_controller.dart';
import '../../../controllers/notification_controller.dart';

class DashboardController extends GetxController with StateMixin<bool> {
  final authController = Get.find<AuthController>();

  final ServiceProvider serviceProvider = ServiceProvider();

  var serviceObj = Service().obs;

  var tabIndex = 0.obs;

  int get getTabIndex => this.tabIndex.value;

  Stream updateUINotifier =
      Get.find<NotificationController>().updateUINotifier.stream;

  void setTabIndex(int index) {
    tabIndex.value = index;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    updateUINotifier.listen((_) {
      InitServiceObj();
    });
    InitServiceObj();
  }

  void InitServiceObj() {
    try {
      change(null, status: RxStatus.loading());
      serviceProvider
          .getServiceByUserId(userId: authController.getCurrentFirebaseId)
          .then((serviceObj) {
        this.serviceObj = serviceObj.obs;
        change(true, status: RxStatus.success());
      }).onError((error, stackTrace) => Future.error(error));
    } catch (e) {
      print(e);
      Get.snackbar("Terdapat kesalahan",
          "Permintaan tidak dapat di proses (Kesalahan Sistem)",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
          borderRadius: 20);
    }
  }

  Future<void> updateServiceStatus({bool isOpen}) async {
    try {
      await serviceProvider
          .updateServiceStatus(
              serviceId: this.serviceObj?.value?.id ?? 0, isOpen: isOpen)
          .then((serviceObj) {
        if (serviceObj != null) {
          this.serviceObj.update((thisServiceObj) {
            thisServiceObj.isOpen = serviceObj.isOpen;
          });
        } else {
          Get.snackbar("Terdapat kesalahan", "Kamu belum memiliki servis",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.white,
              borderRadius: 20);
        }
      }, onError: (error) => Future.error(error));
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
