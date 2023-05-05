import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skripskuy_web/app/controllers/notification_controller.dart';
import 'package:skripskuy_web/app/models/order/providers/order_provider.dart';
import 'package:skripskuy_web/app/models/service/providers/service_provider.dart';
import 'package:skripskuy_web/app/models/service/service_model.dart';

import '../../../controllers/auth_controller.dart';

class NotDoneViewController extends GetxController with StateMixin<bool> {
  final authController = Get.find<AuthController>();
  final ServiceProvider serviceProvider = ServiceProvider();
  final OrderProvider orderProvider = OrderProvider();

  final formKey = GlobalKey<FormState>();

  var serviceObj = Service().obs;
  var undoneOrderJsons = new List<dynamic>().obs;

  StreamController<String> processingIndicator =
      StreamController<String>.broadcast();

  Stream updateUINotifier =
      Get.find<NotificationController>().updateUINotifier.stream;

  TextEditingController cancelNotesFieldController;

  Stream orderControllerIndicator;

  NotDoneViewController(this.orderControllerIndicator);

  @override
  void onInit() {
    super.onInit();
    cancelNotesFieldController = TextEditingController();
    updateUINotifier.listen((_) {
      initUndoneOrderList();
    });
    orderControllerIndicator.listen((indicator) {
      if (indicator == 'REFRESH ALL') {
        initUndoneOrderList();
      }
    });
    initUndoneOrderList();
  }

  void initUndoneOrderList() {
    try {
      change(null, status: RxStatus.loading());
      serviceProvider
          .getServiceByUserId(userId: authController.getCurrentFirebaseId)
          .then((serviceObj) {
        this.serviceObj = serviceObj.obs;
        orderProvider
            .getUndoneOrderJson(serviceId: this.serviceObj?.value?.id ?? 0)
            .then((undoneOrderJsons) {
          this.undoneOrderJsons.clear();
          if (undoneOrderJsons != null) {
            undoneOrderJsons.forEach((undoneOrderJson) {
              this.undoneOrderJsons.add(undoneOrderJson);
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

  Future<void> processingOrder(int selectedIndex) async {
    try {
      orderProvider
          .processingOrder(orderId: undoneOrderJsons[selectedIndex]['id'])
          .then((orderObj) async {
        if (orderObj != null) {
          processingIndicator.add("PROCESSING ORDER");
          initUndoneOrderList();
          Get.back();
          Get.snackbar("Sukses",
              "Order telah berhasil diproses",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.white,
              borderRadius: 20);
        }
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

  Future<void> cancelOrder(int selectedIndex) async {
    if (formKey.currentState.validate()) {
      try {
        orderProvider
            .cancelOrder(
                orderId:
                    int.parse(undoneOrderJsons[selectedIndex]['id'].toString()),
                cancelNotes: cancelNotesFieldController.text)
            .then((orderObj) async {
          if (orderObj != null) {
            processingIndicator.add("CANCEL ORDER");
            Get.back();
            this.cancelNotesFieldController.clear();
            initUndoneOrderList();
            Get.snackbar("Sukses",
                "Order telah berhasil dibatalkan",
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.white,
                borderRadius: 20);
          }
        }).onError((error, stackTrace) => Future.error(error));
      } catch (e) {
        print(e);
        Get.snackbar("Terdapat kesalahan",
            "Permintaan tidak dapat di proses (Kesalahan Sistem)",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.white,
            borderRadius: 20);
      }
    } else {
      Get.snackbar(
          "Terdapat kesalahan", "Alasan pembatalan tidak boleh dikosongkan",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
          borderRadius: 20);
    }
  }
}
