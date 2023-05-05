import 'package:get/get.dart';

// import 'package:skripskuy_web/app/modules/home/controllers/this_month_income_view_controller.dart';
// import 'package:skripskuy_web/app/modules/home/controllers/this_month_order_statistic_view_controller.dart';
// import 'package:skripskuy_web/app/modules/home/controllers/today_income_view_controller.dart';
// import 'package:skripskuy_web/app/modules/home/controllers/today_order_statistic_view_controller.dart';
// import 'package:skripskuy_web/app/modules/home/controllers/today_queue_view_controller.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<ThisMonthIncomeViewController>(
    //   () => ThisMonthIncomeViewController(),
    // );
    // Get.lazyPut<TodayOrderStatisticViewController>(
    //   () => TodayOrderStatisticViewController(),
    // );
    // Get.lazyPut<TodayIncomeViewController>(
    //   () => TodayIncomeViewController(),
    // );
    // Get.lazyPut<ThisMonthOrderStatisticViewController>(
    //   () => ThisMonthOrderStatisticViewController(),
    // );
    // Get.lazyPut<TodayQueueViewController>(
    //   () => TodayQueueViewController(),
    // );
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
  }
}
