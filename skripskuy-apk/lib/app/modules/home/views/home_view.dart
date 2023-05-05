import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../utils/custom_theme.dart';
import '../controllers/home_controller.dart';

class HomeView extends StatelessWidget {
  final homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: homeController.scaffoldKey,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB((20/1.w).w, (20/1.h).h, (20/1.w).w, (20/1.h).h),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(0),
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(0),
                ),
              ),
              child: RefreshIndicator(
                onRefresh: () => homeController.onRefresh(),
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  homeController.todayQueueViewController
                                      .obx((todayOrderQueueJson) {
                                    return TodayQueueView(
                                      currentQueueIndex: todayOrderQueueJson[
                                                  'current_queue_index']
                                              ?.toString() ??
                                          0.toString(),
                                      totalQueue:
                                          todayOrderQueueJson['total_queue']
                                                  ?.toString() ??
                                              0.toString(),
                                    );
                                  }),
                                  homeController
                                      .thisMonthOrderStatisticViewController
                                      .obx((thisMonthOrderStatisticJson) {
                                    return ThisMonthOrderStatisticView(
                                      totalCancelledOrder:
                                          thisMonthOrderStatisticJson[
                                                      'total_cancelled_order']
                                                  ?.toString() ??
                                              0.toString(),
                                      totalOrder: thisMonthOrderStatisticJson[
                                                  'total_order']
                                              ?.toString() ??
                                          0.toString(),
                                    );
                                  }),
                                  homeController.todayIncomeViewController
                                      .obx((todayIncomeJson) {
                                    return TodayIncomeView(
                                      totalIncome:
                                          todayIncomeJson['total_income']
                                                  ?.toString() ??
                                              0.toString(),
                                    );
                                  }),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  homeController
                                      .todayOrderStatisticViewController
                                      .obx((todayOrderStatisticJson) {
                                    return TodayOrderStatisticView(
                                      totalOnProgressOrder:
                                          todayOrderStatisticJson[
                                                      'total_on_progress_order']
                                                  ?.toString() ??
                                              0.toString(),
                                      totalDoneOrder: todayOrderStatisticJson[
                                                  'total_done_order']
                                              ?.toString() ??
                                          0.toString(),
                                      totalCancelledOrder:
                                          todayOrderStatisticJson[
                                                      'total_cancelled_order']
                                                  ?.toString() ??
                                              0.toString(),
                                      totalPaidOrder: todayOrderStatisticJson[
                                                  'total_paid_order']
                                              ?.toString() ??
                                          0.toString(),
                                    );
                                  }),
                                  homeController.thisMonthIncomeViewController
                                      .obx((thisMonthIncomeJson) {
                                    return ThisMonthIncomeView(
                                      totalIncome:
                                          thisMonthIncomeJson['total_income']
                                                  ?.toString() ??
                                              0.toString(),
                                    );
                                  }),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ThisMonthIncomeView extends StatelessWidget {
  ThisMonthIncomeView({Key key, @required this.totalIncome}) : super(key: key);

  String totalIncome;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB((10/1.w).w, (10/1.h).h, (10/1.w).w, (10/1.h).h),
      child: Material(
        color: Colors.transparent,
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB((10/1.w).w, (10/1.h).h, 0, 0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB((10/1.w).w, 0, 0, 0),
                  child: Text(
                    'Pendapatan Bulan Ini',
                    style: CustomTheme.of(context).bodyText1.override(
                          fontFamily: 'Poppins',
                          fontSize: (24/1.sp).sp,
                        ),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    height: (100/1.h).h,
                    decoration: BoxDecoration(
                      color: CustomTheme.of(context).secondaryBackground,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB((10/1.w).w, (10/1.h).h, (10/1.w).w, (10/1.h).h),
                            child: Container(
                              width: (100/1.w).w,
                              height: double.infinity,
                              decoration: BoxDecoration(),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'Total Pendapatan',
                                    style: CustomTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Poppins',
                                          fontSize: (25/1.sp).sp,
                                        ),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Rp. ',
                                        style: CustomTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: 'Poppins',
                                              fontSize: 25,
                                            ),
                                      ),
                                      Text(
                                        totalIncome?.toString() ??
                                            '[Tidak didefinisikan]',
                                        style: CustomTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: 'Poppins',
                                              fontSize: (25/1.sp).sp,
                                            ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TodayOrderStatisticView extends StatelessWidget {
  TodayOrderStatisticView({
    Key key,
    @required this.totalOnProgressOrder,
    @required this.totalDoneOrder,
    @required this.totalCancelledOrder,
    @required this.totalPaidOrder,
  }) : super(key: key);

  String totalOnProgressOrder;
  String totalDoneOrder;
  String totalCancelledOrder;
  String totalPaidOrder;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB((10/1.w).w, (10/1.h).h, (10/1.w).w, (10/1.h).h),
      child: Material(
        color: Colors.transparent,
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.6,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB((10/1.w).w, (10/1.h).h, 0, 0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB((10/1.w).w, 0, 0, 0),
                  child: Text(
                    'Statistik Order Hari Ini',
                    style: CustomTheme.of(context).bodyText1.override(
                          fontFamily: 'Poppins',
                          fontSize: (24/1.sp).sp,
                        ),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    height: (100/1.h).h,
                    decoration: BoxDecoration(
                      color: CustomTheme.of(context).secondaryBackground,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB((10/1.w).w, (10/1.h).h, (10/1.w).w, (10/1.h).h),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.2,
                              height: double.infinity,
                              decoration: BoxDecoration(),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          (10/1.w).w, (10/1.h).h, (10/1.w).w, (10/1.h).h),
                                      child: Container(
                                        width: double.infinity,
                                        height: (100/1.h).h,
                                        decoration: BoxDecoration(),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              'Sedang Dikerjakan',
                                              textAlign: TextAlign.center,
                                              style: CustomTheme.of(context)
                                                  .bodyText1
                                                  .override(
                                                    fontFamily: 'Poppins',
                                                    fontSize: (25/1.sp).sp,
                                                  ),
                                            ),
                                            Text(
                                              totalOnProgressOrder
                                                      ?.toString() ??
                                                  '[Tidak didefinisikan]',
                                              style: CustomTheme.of(context)
                                                  .bodyText1
                                                  .override(
                                                    fontFamily: 'Poppins',
                                                    fontSize: (25/1.sp).sp,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          (10/1.w).w, (10/1.h).h, (10/1.w).w, (10/1.h).h),
                                      child: Container(
                                        width: double.infinity,
                                        height: (100/1.h).h,
                                        decoration: BoxDecoration(),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              'Selesai',
                                              textAlign: TextAlign.center,
                                              style: CustomTheme.of(context)
                                                  .bodyText1
                                                  .override(
                                                    fontFamily: 'Poppins',
                                                    fontSize: (25/1.sp).sp,
                                                  ),
                                            ),
                                            Text(
                                              totalDoneOrder?.toString() ??
                                                  '[Tidak didefinisikan]',
                                              style: CustomTheme.of(context)
                                                  .bodyText1
                                                  .override(
                                                    fontFamily: 'Poppins',
                                                    fontSize: (25/1.sp).sp,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB((10/1.w).w, (10/1.h).h, (10/1.w).w, (10/1.h).h),
                            child: Container(
                              width: (100/1.w).w,
                              height: double.infinity,
                              decoration: BoxDecoration(),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          (10/1.w).w, (10/1.h).h, (10/1.w).w, (10/1.h).h),
                                      child: Container(
                                        width: double.infinity,
                                        height: (100/1.h).h,
                                        decoration: BoxDecoration(),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              'Order Yang Dibatalkan',
                                              textAlign: TextAlign.center,
                                              style: CustomTheme.of(context)
                                                  .bodyText1
                                                  .override(
                                                    fontFamily: 'Poppins',
                                                    fontSize: (25/1.sp).sp,
                                                  ),
                                            ),
                                            Text(
                                              totalCancelledOrder?.toString() ??
                                                  '[Tidak didefinisikan]',
                                              style: CustomTheme.of(context)
                                                  .bodyText1
                                                  .override(
                                                    fontFamily: 'Poppins',
                                                    fontSize: (25/1.sp).sp,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          (10/1.w).w, (10/1.h).h, (10/1.w).w, (10/1.h).h),
                                      child: Container(
                                        width: double.infinity,
                                        height: (100/1.h).h,
                                        decoration: BoxDecoration(),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              'Dibayar',
                                              textAlign: TextAlign.center,
                                              style: CustomTheme.of(context)
                                                  .bodyText1
                                                  .override(
                                                    fontFamily: 'Poppins',
                                                    fontSize: (25/1.sp).sp,
                                                  ),
                                            ),
                                            Text(
                                              totalPaidOrder?.toString() ??
                                                  '[Tidak didefinisikan]',
                                              style: CustomTheme.of(context)
                                                  .bodyText1
                                                  .override(
                                                    fontFamily: 'Poppins',
                                                    fontSize: (25/1.sp).sp,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TodayIncomeView extends StatelessWidget {
  TodayIncomeView({
    Key key,
    @required this.totalIncome,
  }) : super(key: key);

  String totalIncome;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB((10/1.w).w, (10/1.h).h, (10/1.w).w, (10/1.h).h),
      child: Material(
        color: Colors.transparent,
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB((10/1.w).w, (10/1.h).h, 0, 0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB((10/1.w).w, 0, 0, 0),
                  child: Text(
                    'Pendapatan Hari Ini',
                    style: CustomTheme.of(context).bodyText1.override(
                          fontFamily: 'Poppins',
                          fontSize: (24/1.sp).sp,
                        ),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    height: (100/1.h).h,
                    decoration: BoxDecoration(
                      color: CustomTheme.of(context).secondaryBackground,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB((10/1.w).w, (10/1.h).h, (10/1.w).w, (10/1.w).w),
                            child: Container(
                              width: (100/1.w).w,
                              height: double.infinity,
                              decoration: BoxDecoration(),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'Total Pendapatan',
                                    style: CustomTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Poppins',
                                          fontSize: (25/1.sp).sp,
                                        ),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Rp. ',
                                        style: CustomTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: 'Poppins',
                                              fontSize: (25/1.sp).sp,
                                            ),
                                      ),
                                      Text(
                                        totalIncome,
                                        style: CustomTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: 'Poppins',
                                              fontSize: (25/1.sp).sp,
                                            ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ThisMonthOrderStatisticView extends StatelessWidget {
  ThisMonthOrderStatisticView(
      {Key key, @required this.totalCancelledOrder, @required this.totalOrder})
      : super(key: key);

  String totalCancelledOrder;
  String totalOrder;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB((10/1.w).w, (10/1.h).h, (10/1.w).w, (10/1.h).h),
      child: Material(
        color: Colors.transparent,
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB((10/1.w).w, (10/1.h).h, 0, 0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB((10/1.w).w, 0, 0, 0),
                  child: Text(
                    'Statistik Order Bulan Ini',
                    style: CustomTheme.of(context).bodyText1.override(
                          fontFamily: 'Poppins',
                          fontSize: (24/1.sp).sp,
                        ),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: CustomTheme.of(context).secondaryBackground,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB((10/1.w).w, (10/1.h).h, (10/1.w).w, (10/1.h).h),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.2,
                              height: double.infinity,
                              decoration: BoxDecoration(),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'Order Yang Dibatalkan',
                                    textAlign: TextAlign.center,
                                    style: CustomTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Poppins',
                                          fontSize: (25/1.sp).sp,
                                        ),
                                  ),
                                  Text(
                                    totalCancelledOrder?.toString() ??
                                        '[Tidak didefinisikan]',
                                    style: CustomTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Poppins',
                                          fontSize: (25/1.sp).sp,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB((10/1.w).w, (10/1.h).h, (10/1.w).w, (10/1.h).h),
                            child: Container(
                              width: (100/1.w),
                              height: double.infinity,
                              decoration: BoxDecoration(),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'Total Order',
                                    style: CustomTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Poppins',
                                          fontSize: (25/1.sp).sp,
                                        ),
                                  ),
                                  Text(
                                    totalOrder?.toString() ??
                                        '[Tidak didefinisikan]',
                                    style: CustomTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Poppins',
                                          fontSize: (25/1.sp).sp,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TodayQueueView extends StatelessWidget {
  TodayQueueView({
    Key key,
    @required this.currentQueueIndex,
    @required this.totalQueue,
  }) : super(key: key);

  String currentQueueIndex;
  String totalQueue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB((10/1.w).w, (10/1.h).h, (10/1.w).w, (10/1.h).h),
      child: Material(
        color: Colors.transparent,
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB((10/1.w).w, (10/1.h).h, 0, 0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB((10/1.w).w, 0, 0, 0),
                  child: Text(
                    'Antrian Harian',
                    style: CustomTheme.of(context).bodyText1.override(
                          fontFamily: 'Poppins',
                          fontSize: (24/1.sp).sp,
                        ),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    height: (100/1.w).w,
                    decoration: BoxDecoration(
                      color: CustomTheme.of(context).secondaryBackground,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB((10/1.w).w, (10/1.h).h, (10/1.w).w, (10/1.h).h),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.2,
                              height: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'Nomor Antrian',
                                    style: CustomTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Poppins',
                                          fontSize: (25/1.sp).sp,
                                        ),
                                  ),
                                  Text(
                                    currentQueueIndex?.toString() ??
                                        '[Tidak didefinisikan]',
                                    style: CustomTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Poppins',
                                          fontSize: (25/1.sp).sp,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB((10/1.w).w, (10/1.h).h, (10/1.w).w, (10/1.h).h),
                            child: Container(
                              width: (100/1.w).w,
                              height: double.infinity,
                              decoration: BoxDecoration(),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'Total Antrian',
                                    style: CustomTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Poppins',
                                          fontSize: (25/1.sp).sp,
                                        ),
                                  ),
                                  Text(
                                    totalQueue?.toString() ??
                                        '[Tidak didefinisikan]',
                                    style: CustomTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Poppins',
                                          fontSize: (25/1.sp).sp,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
