import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:skripskuy_web/app/models/service/service_model.dart';

import '../../../controllers/auth_controller.dart';
import '../../../controllers/notification_controller.dart';
import '../../../models/order/providers/order_provider.dart';
import '../../../models/service/providers/service_provider.dart';

class HistoryViewController extends GetxController with StateMixin<bool> {
  final authController = Get.find<AuthController>();
  final ServiceProvider serviceProvider = ServiceProvider();
  final OrderProvider orderProvider = OrderProvider();

  var serviceObj = Service().obs;
  var orderHistoryJsons = new List<dynamic>().obs;

  StreamController<String> processingIndicator =
      StreamController<String>.broadcast();

  var fromDate = DateFormat('yyyy-MM-dd').format(DateTime.now()).obs;
  var toDate = DateFormat('yyyy-MM-dd').format(DateTime.now()).obs;

  Stream updateUINotifier = Get.find<NotificationController>().updateUINotifier.stream;

  @override
  void onInit() {
    super.onInit();
    initOrderHistoryJsons();

    updateUINotifier.listen((_) {
      initOrderHistoryJsons();
    });
  }

  void onRefresh() {
    initOrderHistoryJsons();
  }

  void initOrderHistoryJsons() {
    try {
      change(null, status: RxStatus.loading());
      serviceProvider
          .getServiceByUserId(userId: authController.getCurrentFirebaseId)
          .then((serviceObj) {
        this.serviceObj = serviceObj.obs;
        orderProvider
            .getServiceProviderOrderHistory(
          serviceId: this.serviceObj?.value?.id ?? 0,
          fromDate: this.fromDate.value,
          toDate: this.toDate.value,
        )
            .then((orderHistoryJsons) {
          this.orderHistoryJsons.clear();
          if (orderHistoryJsons != null) {
            orderHistoryJsons.forEach((orderHistoryJson) {
              this.orderHistoryJsons.add(orderHistoryJson);
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
