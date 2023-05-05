import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/auth_controller.dart';
import '../../../models/custom_user/providers/custom_user_provider.dart';
import '../../../routes/app_pages.dart';

class AccountController extends GetxController {
  final authController = Get.find<AuthController>();

  final profileFormKey = GlobalKey<FormState>();
  final passwordFormKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final CustomUserProvider customUserProvider = CustomUserProvider();

  TextEditingController fullNameFieldController;
  TextEditingController phoneNumberFieldController;
  TextEditingController emailFieldController;

  TextEditingController oldPasswordFieldController;
  TextEditingController newPasswordFieldController;
  var passwordVisibility = false.obs;

  @override
  void onInit() async {
    super.onInit();
    await initProfile();
  }

  Future<void> initProfile() async {
    fullNameFieldController =
        TextEditingController(text: authController.user.fullName);
    phoneNumberFieldController =
        TextEditingController(text: authController.user.phoneNumber);
    emailFieldController =
        TextEditingController(text: authController.user.email);
    oldPasswordFieldController = TextEditingController();
    newPasswordFieldController = TextEditingController();
  }

  Future<void> updateProfile() async {
    if (profileFormKey.currentState.validate()) {
      try {
        await customUserProvider
            .updateUser(firebaseId: authController.user.firebaseId, json: {
          'full_name': fullNameFieldController.text,
          'phone_number': phoneNumberFieldController.text,
          'email': emailFieldController.text,
        }).then((userObj) {
          if (userObj != null) {
            authController.user = userObj;
            Get.back();
            Get.snackbar("Sukses", "Kamu berhasil ubah profil",
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
      Get.snackbar("Terdapat kesalahan", "Harap isi semua data dengan benar",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
          borderRadius: 20);
    }
  }

  void changePassword() async {
    if (passwordFormKey.currentState.validate()) {
      try {
        await authController
            .updatePassword(
                oldPassword: oldPasswordFieldController.text,
                newPassword: newPasswordFieldController.text)
            .then((isSuccess) {
          if (isSuccess == true) {
            Get.snackbar("Sukses", "Kamu berhasil ubah password",
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
      Get.snackbar("Terdapat kesalahan", "Harap isi semua data dengan benar",
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void logOut() async {
    await authController.logOut().then((isSuccess) =>
        isSuccess == true ? Get.offAllNamed(Routes.LOGIN) : null);
  }
}
