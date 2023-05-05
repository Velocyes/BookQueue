import 'package:get/get.dart';

import '../controllers/order_controller.dart';

// import 'package:skripskuy_web/app/modules/order/controllers/cancelled_view_controller.dart';
// import 'package:skripskuy_web/app/modules/order/controllers/done_view_controller.dart';
// import 'package:skripskuy_web/app/modules/order/controllers/on_progress_view_controller.dart';

class OrderBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<HistoryViewController>(
    //   () => HistoryViewController(),
    // );
    // Get.lazyPut<DoneViewController>(
    //   () => DoneViewController(),
    // );
    // Get.lazyPut<OnProgressViewController>(
    //   () => OnProgressViewController(),
    // );
    // Get.lazyPut<CancelledViewController>(
    //   () => CancelledViewController(),
    // );
    // Get.lazyPut<NotDoneViewController>(
    //   () => NotDoneViewController(),
    // );
    Get.lazyPut<OrderController>(
      () => OrderController(),
    );
  }
}
