import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skripskuy_web/app/models/service/service_model.dart';

import '../../../controllers/auth_controller.dart';
import '../../../controllers/notification_controller.dart';
import '../../../models/order/providers/order_provider.dart';
import '../../../models/service/providers/service_provider.dart';

class DoneViewController extends GetxController with StateMixin<bool> {
  final authController = Get.find<AuthController>();
  final ServiceProvider serviceProvider = ServiceProvider();
  final OrderProvider orderProvider = OrderProvider();

  var serviceObj = Service().obs;
  var doneOrderJsons = new List<dynamic>().obs;

  StreamController<String> processingIndicator =
      StreamController<String>.broadcast();

  Stream orderControllerIndicator;

  DoneViewController(this.orderControllerIndicator);

  Stream updateUINotifier =
      Get.find<NotificationController>().updateUINotifier.stream;

  @override
  void onInit() {
    super.onInit();
    initDoneOrderList();

    orderControllerIndicator.listen((indicator) {
      if (indicator == 'FINISHING ORDER' || indicator == "REFRESH ALL") {
        initDoneOrderList();
      }
    });
    updateUINotifier.listen((event) {
      initDoneOrderList();
    });
  }

  void initDoneOrderList() {
    try {
      change(null, status: RxStatus.loading());
      serviceProvider
          .getServiceByUserId(userId: authController.getCurrentFirebaseId)
          .then((serviceObj) {
        this.serviceObj = serviceObj.obs;
        orderProvider
            .getDoneOrderJson(serviceId: this.serviceObj?.value?.id ?? 0)
            .then((doneOrderJsons) {
          this.doneOrderJsons.clear();
          if (doneOrderJsons != null) {
            doneOrderJsons.forEach((doneOrderJson) {
              this.doneOrderJsons.add(doneOrderJson);
            });
          }
          change(null, status: RxStatus.success());
        }, onError: (error) => Future.error(error));
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
