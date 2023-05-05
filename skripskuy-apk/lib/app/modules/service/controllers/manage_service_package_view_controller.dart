import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skripskuy_web/app/models/service/service_model.dart';

import '../../../controllers/auth_controller.dart';
import '../../../controllers/notification_controller.dart';
import '../../../models/service/providers/service_provider.dart';
import '../../../models/service_package/providers/service_package_provider.dart';
import '../../../models/service_package/service_package_model.dart';

class ManageServicePackageViewController extends GetxController
    with StateMixin<bool> {
  final formKey = GlobalKey<FormState>();

  final ServicePackageProvider servicePackageProvider =
      ServicePackageProvider();
  final ServiceProvider serviceProvider = ServiceProvider();

  final authController = Get.find<AuthController>();

  TextEditingController categoryNameFieldController;
  TextEditingController categoryTypeFieldController;
  TextEditingController categoryDescriptionFieldController;
  TextEditingController categoryCostFieldController;

  var serviceObj = Service().obs;

  StreamController<Rx<ServicePackage>> createdServicePackageObjStreamer =
      StreamController<Rx<ServicePackage>>();

  StreamController<Rx<ServicePackage>> updatedServicePackageObjStreamer =
      StreamController<Rx<ServicePackage>>();

  Stream updateUINotifier =
      Get.find<NotificationController>().updateUINotifier.stream;

  @override
  void onInit() {
    super.onInit();
    categoryNameFieldController = TextEditingController();
    categoryTypeFieldController = TextEditingController();
    categoryDescriptionFieldController = TextEditingController();
    categoryCostFieldController = TextEditingController();

    InitServiceObj();

    updateUINotifier.listen((event) {
      InitServiceObj();
    });
  }

  void InitServiceObj() {
    serviceProvider
        .getServiceByUserId(userId: authController.getCurrentFirebaseId)
        .then((serviceObj) {
      if (serviceObj != null) {
        this.serviceObj = serviceObj.obs;
      }
    });
  }

  Future<void> createServicePackage() async {
    if (formKey.currentState.validate()) {
      try {
        servicePackageProvider
            .createServicePackage(
                serviceId: serviceObj.value.id,
                name: categoryNameFieldController.text,
                type: categoryTypeFieldController.text,
                description: categoryDescriptionFieldController.text,
                cost: int.parse(categoryCostFieldController.text))
            .then((servicePackageObj) async {
          createdServicePackageObjStreamer.add(servicePackageObj.obs);
          Get.back();
          Get.snackbar("Sukses", "Paket servis telah berhasil dibuat",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.white,
              borderRadius: 20);
          await Future.delayed(Duration(seconds: 1));
          clearTextFieldController();
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
          "Terdapat kesalahan", "Mohon untuk mengisi data-data yang diperlukan",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
          borderRadius: 20);
    }
  }

  void clearTextFieldController() {
    categoryNameFieldController.clear();
    categoryTypeFieldController.clear();
    categoryDescriptionFieldController.clear();
    categoryCostFieldController.clear();
  }

  Future<void> updateServicePackage({
    @required int servicePackageId,
  }) async {
    if (formKey.currentState.validate()) {
      try {
        change(null, status: RxStatus.loading());
        await servicePackageProvider
            .updateServicePackage(
                id: servicePackageId,
                name: categoryNameFieldController.text,
                type: categoryTypeFieldController.text,
                description: categoryDescriptionFieldController.text,
                cost: int.parse(categoryCostFieldController.text))
            .then((servicePackageObj) async {
          updatedServicePackageObjStreamer.add(servicePackageObj.obs);
          Get.back();
          Get.snackbar("Sukses", "Paket servis telah berhasil diubah",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.white,
              borderRadius: 20);
          await Future.delayed(Duration(seconds: 1));
          clearTextFieldController();
        }).onError((error, stackTrace) => Future.error(error));
        await change(null, status: RxStatus.success());
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
          "Terdapat kesalahan", "Mohon untuk mengisi data-data yang diperlukan",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
          borderRadius: 20);
    }
  }
}
