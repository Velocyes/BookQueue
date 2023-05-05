import 'package:get/get.dart';

import 'package:skripskuy_web/app/modules/service/controllers/review_view_controller.dart';
import 'package:skripskuy_web/app/modules/service/controllers/manage_service_package_view_controller.dart';
import 'package:skripskuy_web/app/modules/service/controllers/service_package_view_controller.dart';
import 'package:skripskuy_web/app/modules/service/controllers/service_profile_view_controller.dart';

import '../controllers/service_controller.dart';

class ServiceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReviewViewController>(
      () => ReviewViewController(),
    );
    Get.lazyPut<ManageServicePackageViewController>(
      () => ManageServicePackageViewController(),
    );
    Get.lazyPut<ServicePackageViewController>(
      () => ServicePackageViewController(),
    );
    Get.lazyPut<ServiceProfileViewController>(
      () => ServiceProfileViewController(),
    );
    Get.lazyPut<ServiceController>(
      () => ServiceController(),
    );
  }
}
