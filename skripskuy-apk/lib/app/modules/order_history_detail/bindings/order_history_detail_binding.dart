import 'package:get/get.dart';

import '../controllers/order_history_detail_controller.dart';

class OrderHistoryDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderHistoryDetailController>(
      () => OrderHistoryDetailController(),
    );
  }
}
