import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../controllers/auth_controller.dart';
import '../../../routes/app_pages.dart';

class LoginController extends GetxController {
  final authController = Get.find<AuthController>();

  GetStorage storage;

  TextEditingController emailFieldController;
  TextEditingController passwordFieldController;
  var passwordVisibility = false.obs;
  var isRememberMe = false.obs;

  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void onInit() {
    super.onInit();
    emailFieldController = TextEditingController();
    passwordFieldController = TextEditingController();

    storage = GetStorage();
    if (storage.read('isRememberMe') != null) {
      isRememberMe.value = storage.read('isRememberMe');
    }
    if (storage.read('email') != null && storage.read('password') != null) {
      emailFieldController.text = storage.read('email');
      passwordFieldController.text = storage.read('password');
    }
  }

  void login() async {
    await authController.login(
      email: emailFieldController.text,
      password: passwordFieldController.text,
    ).then((isSuccess){
      if (isSuccess) {
        if (!isRememberMe.value) {
          if(storage.read('email') != null && storage.read('password') != null){
            storage.remove('email');
            storage.remove('password');
          }
        } else if (isRememberMe.value) {
          storage.write('email', emailFieldController.text);
          storage.write('password', passwordFieldController.text);
        }
        storage.write('isRememberMe', isRememberMe.value);
        Get.offAllNamed(Routes.DASHBOARD);
      }
    });
  }
}
