import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skripskuy_web/app/controllers/auth_controller.dart';
import 'package:skripskuy_web/app/models/service/service_model.dart';
import 'package:skripskuy_web/app/models/service_package/providers/service_package_provider.dart';

import '../../../models/service/providers/service_provider.dart';
import '../../../models/service_package/service_package_model.dart';
import 'manage_service_package_view_controller.dart';

class ServicePackageViewController extends GetxController
    with StateMixin<bool> {
  final ServicePackageProvider servicePackageProvider =
      ServicePackageProvider();
  final ServiceProvider serviceProvider = ServiceProvider();

  final authController = Get.find<AuthController>();
  final manageServicePackageViewController =
      Get.put(ManageServicePackageViewController());

  var serviceObj = Service().obs;
  var servicePackageObjs = new List<Rx<ServicePackage>>().obs;

  Stream createdServicePackageObjSubscriber;
  Stream updatedServicePackageObjSubscriber;

  @override
  Future<void> onInit() async {
    super.onInit();
    try {
      createdServicePackageObjSubscriber = manageServicePackageViewController
          .createdServicePackageObjStreamer.stream;
      updatedServicePackageObjSubscriber = manageServicePackageViewController
          .updatedServicePackageObjStreamer.stream;

      createdServicePackageObjSubscriber.listen((servicePackageObjObs) {
        change(null, status: RxStatus.loading());
        this.servicePackageObjs.add(servicePackageObjObs);
        change(true, status: RxStatus.success());
      });
      updatedServicePackageObjSubscriber.listen((servicePackageObjObs) {
        change(null, status: RxStatus.loading());
        servicePackageObjs.asMap().forEach((index, servicePackageObj) {
          if (servicePackageObj.value.id == servicePackageObjObs.value.id) {
            servicePackageObjs[index] = servicePackageObjObs;
          }
          change(true, status: RxStatus.success());
        });
      });
      await initServicePackage();
    } catch (e) {
      print(e);
      Get.snackbar("Terdapat kesalahan",
          "Permintaan tidak dapat di proses (Kesalahan Sistem)",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
          borderRadius: 20);
    }
  }

  Future<void> initServicePackage() async {
    try {
      change(null, status: RxStatus.loading());
      await serviceProvider
          .getServiceByUserId(userId: authController.getCurrentFirebaseId)
          .then((serviceObj) {
        if (serviceObj != null) {
          this.serviceObj = serviceObj.obs;
          servicePackageProvider
              .getServicePackageByServiceId(serviceId: this.serviceObj.value.id)
              .then((servicePackageObjs) {
            if (servicePackageObjs != null) {
              if (this.servicePackageObjs.isEmpty == false){
                this.servicePackageObjs.clear();
              }
              servicePackageObjs.forEach((servicePackageObj) {
                this.servicePackageObjs.add(servicePackageObj.obs);
              });
            }
          }).onError((error, stackTrace) => Future.error(error));
          change(true, status: RxStatus.success());
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

  Future<void> deleteServicePackage({int servicePackageId}) async {
    var deletedIndex = -1;
    try {
      change(null, status: RxStatus.loading());
      await servicePackageProvider
          .deleteServicePackage(id: servicePackageId)
          .then((isSuccess) {
        servicePackageObjs.asMap().forEach((index, servicePackageObj) {
          if (servicePackageObj.value.id == servicePackageId) {
            deletedIndex = index;
          }
        });
        if (deletedIndex != -1) {
          servicePackageObjs.removeAt(deletedIndex);
        }
        Get.back();
        Get.snackbar("Sukses", "Paket servis telah berhasil dihapus",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.white,
            borderRadius: 20);
      }).onError((error, stackTrace) => Future.error(error));
      change(true, status: RxStatus.success());
    } catch (e) {
      print(e);
      Get.snackbar("Terdapat kesalahan",
          "Permintaan tidak dapat di proses (Kesalahan Sistem)",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
          borderRadius: 20);
      change(true, status: RxStatus.success());
    }
  }
}
