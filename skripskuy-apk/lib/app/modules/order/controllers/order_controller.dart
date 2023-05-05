import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skripskuy_web/app/modules/order/controllers/history_view_controller.dart';
import 'package:skripskuy_web/app/modules/order/controllers/not_done_view_controller.dart';

import 'cancelled_view_controller.dart';
import 'done_view_controller.dart';
import 'on_progress_view_controller.dart';

class OrderController extends GetxController with StateMixin<bool> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  NotDoneViewController notDoneViewController;
  CancelledViewController cancelledViewController;
  OnProgressViewController onProgressViewController;
  DoneViewController doneViewController;
  HistoryViewController historyViewController;

  Stream undoneViewIndicator;
  Stream onProgressViewIndicator;

  StreamController<String> processingIndicator =
      StreamController<String>.broadcast();

  @override
  void onInit() {
    super.onInit();
    notDoneViewController =
        Get.put(NotDoneViewController(this.processingIndicator.stream));
    cancelledViewController =
        Get.put(CancelledViewController(this.processingIndicator.stream));
    onProgressViewController =
        Get.put(OnProgressViewController(this.processingIndicator.stream));
    doneViewController =
        Get.put(DoneViewController(this.processingIndicator.stream));
    historyViewController =
        Get.put(HistoryViewController());

    undoneViewIndicator = notDoneViewController.processingIndicator.stream;
    onProgressViewIndicator =
        onProgressViewController.processingIndicator.stream;

    undoneViewIndicator.listen((indicator) {
      processingIndicator.add(indicator);
    });
    onProgressViewIndicator.listen((indicator) {
      processingIndicator.add(indicator);
    });
  }

  Future<void> onRefresh() async {
    processingIndicator.add("REFRESH ALL");
  }
}
