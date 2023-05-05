import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skripskuy_web/app/modules/service/controllers/review_view_controller.dart';
import 'package:skripskuy_web/app/modules/service/controllers/service_package_view_controller.dart';
import 'package:skripskuy_web/app/modules/service/controllers/service_profile_view_controller.dart';

class ServiceController extends GetxController {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final serviceProfileViewController = Get.put(ServiceProfileViewController());
  final serviceCategoryViewController = Get.put(ServicePackageViewController());
  final reviewViewController = Get.put(ReviewViewController());

  Stream pagePermissionSubscriber;
  var isNew = true.obs;
  var isAllowedSubPage1 = false.obs;
  var isAllowedSubPage2 = false.obs;
  var isAllowedSubPage3 = false.obs;

  @override
  void onInit() {
    super.onInit();
    pagePermissionSubscriber =
        serviceProfileViewController.pagePermissionStreamer.stream;
    pagePermissionSubscriber.listen((isAllowed) {
      isAllowedSubPage1.value = isAllowed;
      isAllowedSubPage2.value = isAllowed;
      isAllowedSubPage3.value = isAllowed;
      isNew.value = !isAllowed;
    });
  }
}
