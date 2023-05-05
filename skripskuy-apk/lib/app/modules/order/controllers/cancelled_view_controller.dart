import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skripskuy_web/app/models/service/service_model.dart';

import '../../../controllers/auth_controller.dart';
import '../../../models/order/providers/order_provider.dart';
import '../../../models/service/providers/service_provider.dart';

class CancelledViewController extends GetxController with StateMixin<bool> {
  final authController = Get.find<AuthController>();
  final ServiceProvider serviceProvider = ServiceProvider();
  final OrderProvider orderProvider = OrderProvider();

  var serviceObj = Service().obs;
  var cancelledOrderJsons = new List<dynamic>().obs;

  StreamController<String> processingIndicator = StreamController<String>();

  Stream orderControllerIndicator;

  CancelledViewController(this.orderControllerIndicator);

  @override
  void onInit() {
    super.onInit();
    initCancelledOrderList();

    orderControllerIndicator.listen((indicator) {
      if (indicator == 'CANCEL ORDER' || indicator == "REFRESH ALL") {
        initCancelledOrderList();
      }
    });
  }

  void initCancelledOrderList() {
    try {
      change(null, status: RxStatus.loading());
      serviceProvider
          .getServiceByUserId(userId: authController.getCurrentFirebaseId)
          .then((serviceObj) {
        this.serviceObj = serviceObj.obs;
        orderProvider
            .getCancelledOrderJson(serviceId: this.serviceObj?.value?.id ?? 0)
            .then((cancelledOrderJsons) {
          this.cancelledOrderJsons.clear();
          if (cancelledOrderJsons != null) {
            cancelledOrderJsons.forEach((cancelledOrderJson) {
              this.cancelledOrderJsons.add(cancelledOrderJson);
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
