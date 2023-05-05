import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skripskuy_web/app/models/order_process/providers/order_process_provider.dart';
import 'package:skripskuy_web/app/models/service/service_model.dart';

import '../../../controllers/auth_controller.dart';
import '../../../models/order/providers/order_provider.dart';
import '../../../models/service/providers/service_provider.dart';

class OnProgressViewController extends GetxController with StateMixin<bool> {
  final formKey = GlobalKey<FormState>();

  final authController = Get.find<AuthController>();
  final ServiceProvider serviceProvider = ServiceProvider();
  final OrderProvider orderProvider = OrderProvider();
  final OrderProcessProvider orderProcessProvider = OrderProcessProvider();

  var serviceObj = Service().obs;
  var onProgressOrderJsons = new List<dynamic>().obs;

  StreamController<String> processingIndicator =
      StreamController<String>.broadcast();

  Stream orderControllerIndicator;

  TextEditingController nextProcessFieldController;

  OnProgressViewController(this.orderControllerIndicator);

  @override
  void onInit() {
    super.onInit();
    nextProcessFieldController = TextEditingController();

    initOnProgressOrderList();

    orderControllerIndicator.listen((indicator) {
      if (indicator == 'PROCESSING ORDER' || indicator == "REFRESH ALL") {
        initOnProgressOrderList();
      }
    });
  }

  void initOnProgressOrderList() {
    try {
      change(null, status: RxStatus.loading());
      serviceProvider
          .getServiceByUserId(userId: authController.getCurrentFirebaseId)
          .then((serviceObj) {
        this.serviceObj = serviceObj.obs;
        orderProvider
            .getOnProgressOrderJson(serviceId: this.serviceObj?.value?.id ?? 0)
            .then((onProgressOrderJsons) {
          this.onProgressOrderJsons.clear();
          if (onProgressOrderJsons != null) {
            onProgressOrderJsons.forEach((onProgressOrderJson) {
              this.onProgressOrderJsons.add(onProgressOrderJson);
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

  Future<void> addOrderProcess(int selectedIndex) async {
    if (formKey.currentState.validate()) {
      try {
        orderProcessProvider
            .createOrderProcess(
          orderId: int.parse(
            onProgressOrderJsons[selectedIndex]['id'].toString(),
          ),
          processName: nextProcessFieldController.text,
        )
            .then((isSuccess) {
          if (isSuccess == true) {
            initOnProgressOrderList();
            Get.back();
            this.nextProcessFieldController.clear();
            Get.snackbar("Sukses",
                "Proses order telah berhasil ditambahkan",
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
      Get.snackbar("Terdapat kesalahan", "Proses tidak boleh kosong",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
          borderRadius: 20);
    }
  }

  Future<void> finishingOrder(int selectedIndex) async {
    try {
      orderProvider
          .finishingOrder(
        orderId:
            int.parse(onProgressOrderJsons[selectedIndex]['id'].toString()),
      )
          .then((orderObj) {
        if (orderObj != null) {
          processingIndicator.add("FINISHING ORDER");
          initOnProgressOrderList();
          Get.back();
          Get.snackbar("Sukses",
              "Order telah berhasil diselesaikan",
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
}
