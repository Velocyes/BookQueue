import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/auth_controller.dart';
import '../../../routes/app_pages.dart';

class RegisterController extends GetxController {
  final authController = Get.find<AuthController>();

  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController fullNameFieldController;
  TextEditingController phoneNumberFieldController;
  TextEditingController emailFieldController;
  TextEditingController passwordFieldController;
  TextEditingController confirmationPasswordFieldController;
  var passwordVisibility = false.obs;

  @override
  void onInit() {
    super.onInit();
    fullNameFieldController = TextEditingController();
    phoneNumberFieldController = TextEditingController();
    emailFieldController = TextEditingController();
    passwordFieldController = TextEditingController();
    confirmationPasswordFieldController = TextEditingController();
  }

  void register() async {
    if (formKey.currentState.validate()) {
      await authController
          .register(
        fullName: fullNameFieldController.text,
        phoneNumber: phoneNumberFieldController.text,
        email: emailFieldController.text,
        password: passwordFieldController.text,
      )
          .then((isSuccess) {
        isSuccess == true ? Get.offAllNamed(Routes.DASHBOARD) : null;
      });
    } else {
      Get.snackbar("Terdapat kesalahan", "Harap isi semua data dengan benar",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
          borderRadius: 20);
    }

  }
}
