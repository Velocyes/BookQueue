import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skripskuy_web/app/modules/home/controllers/this_month_income_view_controller.dart';
import 'package:skripskuy_web/app/modules/home/controllers/this_month_order_statistic_view_controller.dart';
import 'package:skripskuy_web/app/modules/home/controllers/today_income_view_controller.dart';
import 'package:skripskuy_web/app/modules/home/controllers/today_order_statistic_view_controller.dart';
import 'package:skripskuy_web/app/modules/home/controllers/today_queue_view_controller.dart';

class HomeController extends GetxController {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  StreamController<bool> processingIndicator = StreamController<bool>.broadcast();

  ThisMonthIncomeViewController thisMonthIncomeViewController;
  ThisMonthOrderStatisticViewController thisMonthOrderStatisticViewController;
  TodayIncomeViewController todayIncomeViewController;
  TodayOrderStatisticViewController todayOrderStatisticViewController;
  TodayQueueViewController todayQueueViewController;

  @override
  void onInit() {
    super.onInit();
    thisMonthIncomeViewController = Get.put(ThisMonthIncomeViewController(processingIndicator.stream));
    thisMonthOrderStatisticViewController = Get.put(ThisMonthOrderStatisticViewController(processingIndicator.stream));
    todayIncomeViewController = Get.put(TodayIncomeViewController(processingIndicator.stream));
    todayOrderStatisticViewController = Get.put(TodayOrderStatisticViewController(processingIndicator.stream));
    todayQueueViewController = Get.put(TodayQueueViewController(processingIndicator.stream));
  }

  Future<void> onRefresh() async {
    processingIndicator.add(true);
  }
}
