import 'dart:async';
import 'dart:core';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skripskuy_web/app/config/enums.dart';
import 'package:skripskuy_web/app/models/operational_service/operational_service_model.dart';
import 'package:skripskuy_web/app/models/operational_service/providers/operational_service_provider.dart';
import 'package:skripskuy_web/app/models/service/providers/service_provider.dart';
import 'package:skripskuy_web/app/models/service/service_model.dart';

import '../../../controllers/auth_controller.dart';

class ServiceProfileViewController extends GetxController
    with StateMixin<bool> {
  final formKey = GlobalKey<FormState>();
  final ServiceProvider serviceProvider = ServiceProvider();
  final OperationalServiceProvider operationalServiceProvider =
      OperationalServiceProvider();

  final authController = Get.find<AuthController>();

  var serviceObj = Service(vehicleType: VehicleType.SEMUA.index, openHour: "00:00", closeHour: "00:00").obs;
  var operationalServiceObjs = new List<Rx<OperationalService>>.generate(
      7, (_) => OperationalService(isOpen: false).obs).obs;

  StreamController<bool> pagePermissionStreamer = StreamController<bool>();

  TextEditingController serviceNameFieldController;
  TextEditingController serviceAddressFieldController;
  TextEditingController serviceDescriptionFieldController;

  XFile pickedFile;

  @override
  Future<void> onInit() async {
    super.onInit();
    change(null, status: RxStatus.loading());
    pagePermissionStreamer.add(false);
    serviceNameFieldController = TextEditingController();
    serviceAddressFieldController = TextEditingController();
    serviceDescriptionFieldController = TextEditingController();
    await initServiceProfile();
  }

  void pickImage({ImageSource imageSource}) async {
    pickedFile = await ImagePicker().pickImage(source: imageSource);
    if (pickedFile != null) {
      await update();
    }
    Get.back();
  }

  Future<void> initServiceProfile() async {
    try {
      serviceProvider
          .getServiceByUserId(userId: authController.getCurrentFirebaseId)
          .then((serviceObj) {
        if (serviceObj != null) {
          this.serviceObj = serviceObj.obs;
          serviceNameFieldController.text = this.serviceObj.value.name;
          serviceAddressFieldController.text = this.serviceObj.value.address;
          serviceDescriptionFieldController.text =
              this.serviceObj.value.description;
          this.serviceObj.update((serviceObj) {
            serviceObj.openHour = serviceObj.openHour.substring(0, 5);
            serviceObj.closeHour = serviceObj.closeHour.substring(0, 5);
          });
          operationalServiceProvider
              .getOperationalServiceByServiceId(serviceId: serviceObj.id)
              .then((operationalServiceObjs) {
            if (operationalServiceObjs != null) {
              operationalServiceObjs
                  .asMap()
                  .forEach((index, operationalServiceObj) {
                this.operationalServiceObjs[index] = operationalServiceObj.obs;
              });
            }
          }).onError((error, stackTrace) => Future.error(error));
          pagePermissionStreamer.add(true);
        }
        change(true, status: RxStatus.success());
      }).onError((error, stackTrace) => Future.error(error));
    } catch (e) {
      Get.snackbar("Terdapat kesalahan",
          "Permintaan tidak dapat di proses (Kesalahan Sistem)",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
          borderRadius: 20);
    }
  }

  Future<void> createService() async {
    if (formKey.currentState.validate()) {
      try {
        await serviceProvider
            .createService(
          userId: FirebaseAuth.instance.currentUser.uid,
          profilePicture: pickedFile,
          name: serviceNameFieldController.text,
          address: serviceAddressFieldController.text,
          description: serviceDescriptionFieldController.text,
          vehicleType: serviceObj.value.vehicleType,
          openHour: serviceObj.value.openHour,
          closeHour: serviceObj.value.closeHour,
        )
            .then((serviceObj) async {
              if (serviceObj != null) {
                this.serviceObj = serviceObj.obs;

                await operationalServiceObjs
                    .asMap()
                    .forEach((index, operationaServiceObj) async {
                  await operationalServiceProvider
                      .createOperationalService(
                      serviceId: this.serviceObj.value.id,
                      day: index,
                      isOpen: operationaServiceObj.value.isOpen)
                      .then((operationaServiceObj) => this
                      .operationalServiceObjs[index] = operationaServiceObj.obs)
                      .onError((error, stackTrace) => Future.error(error));
                });
                await change(true, status: RxStatus.success());
                pagePermissionStreamer.add(true);

                Get.snackbar('Sukses', 'Servis berhasil dibuat',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.white,
                    borderRadius: 20);
              }
        }).onError((error, stackTrace) {
          return Future.error(error);
        });
      } catch (e) {
        Get.snackbar("Terdapat kesalahan",
            "Permintaan tidak dapat di proses (Kesalahan Sistem)",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.white,
            borderRadius: 20);
      }
    } else {
      Get.snackbar("Terdapat kesalahan", "Harap isi semua data dengan benar",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
          borderRadius: 20);
    }
  }

  Future<void> updateService() async {
    if (formKey.currentState.validate()) {
      try {
        await serviceProvider
            .updateService(
          id: this.serviceObj.value.id,
          profilePicture: pickedFile,
          name: serviceNameFieldController.text,
          address: serviceAddressFieldController.text,
          description: serviceDescriptionFieldController.text,
          vehicleType: serviceObj.value.vehicleType,
          openHour: serviceObj.value.openHour,
          closeHour: serviceObj.value.closeHour,
        )
            .then((serviceObj) async {
          this.serviceObj = serviceObj.obs;

          await operationalServiceObjs
              .asMap()
              .forEach((index, operationalServiceObj) async {
            await operationalServiceProvider
                .updateOperationalService(
                    id: operationalServiceObj.value.id,
                    isOpen: operationalServiceObj.value.isOpen)
                .then((operationalServiceObj) => this
                    .operationalServiceObjs[index] = operationalServiceObj.obs)
                .onError((error, stackTrace) => Future.error(error));
          });
          await change(true, status: RxStatus.success());
          Get.snackbar('Sukses', 'Profil servis berhasil diubah',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.white,
              borderRadius: 20);
        }).onError((error, stackTrace) {
          return Future.error(error);
        });
      } catch (e) {
        Get.snackbar("Terdapat kesalahan",
            "Permintaan tidak dapat di proses (Kesalahan Sistem)",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.white,
            borderRadius: 20);
      }
    } else {
      Get.snackbar("Terdapat kesalahan", "Harap isi semua data dengan benar",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
          borderRadius: 20);
    }
  }
}
