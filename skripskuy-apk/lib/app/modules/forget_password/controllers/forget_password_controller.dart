import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/auth_controller.dart';
import '../../../routes/app_pages.dart';

class ForgetPasswordController extends GetxController {
  final authController = Get.find<AuthController>();

  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController emailFieldController;

  @override
  void onInit() {
    super.onInit();
    emailFieldController = TextEditingController();
  }

  void resetPassword() async {
    if (formKey.currentState.validate()) {
      await authController
          .resetPassword(
        email: emailFieldController.text,
      )
          .then((isSuccess) {
        isSuccess == true ? Get.offAllNamed(Routes.LOGIN) : null;
      });
    } else {
      Get.snackbar("Terdapat kesalahan", "Harap isi email dengan format yang benar",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
          borderRadius: 20);
    }
  }
}
