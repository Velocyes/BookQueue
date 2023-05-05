import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:skripskuy_web/app/modules/order/controllers/not_done_view_controller.dart';

import '../../../config/enums.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/custom_button.dart';
import '../../../utils/custom_theme.dart';
import '../controllers/on_progress_view_controller.dart';
import '../controllers/order_controller.dart';

class OrderView extends StatelessWidget {
  final orderController = Get.put(OrderController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: orderController.scaffoldKey,
      backgroundColor: CustomTheme.of(context).secondaryBackground,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: DefaultTabController(
                  length: 2,
                  initialIndex: 0,
                  child: Column(
                    children: [
                      TabBar(
                        labelColor: CustomTheme.of(context).primaryColor,
                        labelStyle: CustomTheme.of(context).bodyText1,
                        indicatorColor: CustomTheme.of(context).secondaryColor,
                        tabs: [
                          Tab(
                            text: 'Ringkasan',
                          ),
                          Tab(
                            text: 'Riwayat',
                          ),
                        ],
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            OverviewTabBar(),
                            HistoryTabBar(),
                          ],
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
    );
  }
}

class HistoryTabBar extends StatelessWidget {
  HistoryTabBar({
    Key key,
  }) : super(key: key);

  final historyViewController =
      Get.find<OrderController>().historyViewController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB((20/1.w).w, (20/1.h).h, (20/1.w).w, (20/1.h).h),
      child: Container(
        width: (100/1.w).w,
        height: (100/1.h).h,
        decoration: BoxDecoration(
          color: CustomTheme.of(context).primaryBackground,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB((10/1.w).w, (10/1.h).h, (10/1.w).w, (10/1.h).h),
          child: RefreshIndicator(
            onRefresh: () async => historyViewController.onRefresh(),
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB((10/1.w).w, (10/1.h).h, (10/1.w).w, (10/1.h).h),
                        child: Text(
                          'Riwayat Order',
                          style: CustomTheme.of(context).bodyText1.override(
                                fontFamily: 'Poppins',
                                fontSize: (30/1.sp).sp,
                              ),
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            width: (120/1.w).w,
                            height: (35/1.h).h,
                            decoration: BoxDecoration(
                              color:
                                  CustomTheme.of(context).secondaryBackground,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Obx(() {
                              return Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(
                                    Icons.calendar_today,
                                    color: Colors.black,
                                    size: (24/1.sp).sp,
                                  ),
                                  GestureDetector(
                                    onTap: () async => await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2099),
                                    ).then((date) {
                                      String stringDate =
                                          DateFormat('yyyy-MM-dd').format(date);
                                      if (!DateFormat("yyyy-MM-dd")
                                          .parse(stringDate)
                                          .isAfter(DateFormat("yyyy-MM-dd")
                                              .parse(historyViewController
                                                  .toDate.value))) {
                                        historyViewController.fromDate.value =
                                            DateFormat('yyyy-MM-dd')
                                                .format(date);
                                        historyViewController
                                            .initOrderHistoryJsons();
                                      } else {
                                        Get.snackbar("Terdapat kesalahan",
                                            "Jangkauan hari yang diberikan salah",
                                            snackPosition:
                                                SnackPosition.BOTTOM,
                                            backgroundColor: Colors.white,
                                            borderRadius: 20);
                                      }
                                    }),
                                    child: Text(
                                      historyViewController.fromDate.value,
                                      style: CustomTheme.of(context).bodyText1,
                                    ),
                                  ),
                                ],
                              );
                            }),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB((10/1.w).w, 0, (10/1.w).w, 0),
                            child: Text(
                              'To',
                              style: CustomTheme.of(context).bodyText1.override(
                                    fontFamily: 'Poppins',
                                    fontSize: (18/1.sp).sp,
                                  ),
                            ),
                          ),
                          Container(
                            width: (120/1.w).w,
                            height: (35/1.h).h,
                            decoration: BoxDecoration(
                              color:
                                  CustomTheme.of(context).secondaryBackground,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Obx(() {
                              return Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(
                                    Icons.calendar_today,
                                    color: Colors.black,
                                    size: (24/1.sp).sp,
                                  ),
                                  GestureDetector(
                                    onTap: () async => await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2099),
                                    ).then((date) {
                                      String stringDate =
                                          DateFormat('yyyy-MM-dd').format(date);
                                      if (!DateFormat("yyyy-MM-dd")
                                          .parse(stringDate)
                                          .isBefore(DateFormat("yyyy-MM-dd")
                                              .parse(historyViewController
                                                  .fromDate.value))) {
                                        historyViewController.toDate.value =
                                            DateFormat('yyyy-MM-dd')
                                                .format(date);
                                        historyViewController
                                            .initOrderHistoryJsons();
                                      } else {
                                        Get.snackbar("Terdapat kesalahan",
                                            "Jangkauan hari yang diberikan salah",
                                            snackPosition:
                                                SnackPosition.BOTTOM,
                                            backgroundColor: Colors.white,
                                            borderRadius: 20);
                                      }
                                    }),
                                    child: Text(
                                      historyViewController.toDate.value,
                                      style: CustomTheme.of(context).bodyText1,
                                    ),
                                  ),
                                ],
                              );
                            }),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    height: (50/1.h).h,
                    decoration: BoxDecoration(
                      color: Color(0xFF9E9E9E),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(0),
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB((10/1.w).w, 0, (10/1.w).w, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Order ID',
                                  style: CustomTheme.of(context).bodyText1,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Customer Name',
                                  style: CustomTheme.of(context).bodyText1,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Service Name',
                                  style: CustomTheme.of(context).bodyText1,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Pembayaran',
                                  style: CustomTheme.of(context).bodyText1,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Total',
                                  style: CustomTheme.of(context).bodyText1,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Status',
                                  style: CustomTheme.of(context).bodyText1,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Aksi',
                                  style: CustomTheme.of(context).bodyText1,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.63,
                    decoration: BoxDecoration(
                      color: Color(0xFFEEEEEE),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                        topLeft: Radius.circular(0),
                        topRight: Radius.circular(0),
                      ),
                    ),
                    child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, (5/1.h).h, 0, 0),
                        child: historyViewController.obx((_) {
                          return ListView.builder(
                              padding: EdgeInsets.zero,
                              primary: false,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: historyViewController
                                  .orderHistoryJsons.length,
                              itemBuilder: (BuildContext context, int index) {
                                return HistorySubList(
                                  orderId: historyViewController
                                      .orderHistoryJsons[index]['id'],
                                  customerName: historyViewController
                                          .orderHistoryJsons[index]
                                      ['user_full_name'],
                                  servicePackageName: historyViewController
                                          .orderHistoryJsons[index]
                                      ['service_package_name'],
                                  totalCost: historyViewController
                                      .orderHistoryJsons[index]['total_cost'],
                                  status: historyViewController
                                      .orderHistoryJsons[index]['order_status'],
                                );
                              });
                        })),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HistorySubList extends StatelessWidget {
  HistorySubList(
      {Key key,
      @required this.orderId,
      @required this.customerName,
      @required this.servicePackageName,
      @required this.totalCost,
      @required this.status})
      : super(key: key);

  int orderId;
  String customerName;
  String servicePackageName;
  int totalCost;
  int status;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB((10/1.w).w, (5/1.h).h, (10/1.w).w, (5/1.h).h),
      child: Container(
        width: (100/1.w).w,
        height: (40/1.h).h,
        decoration: BoxDecoration(
          color: CustomTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB((10/1.w).w, 0, (10/1.w).w, 0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      orderId?.toString() ?? '[Tidak didefinisikan]',
                      style: CustomTheme.of(context).bodyText1,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      customerName?.toString() ?? '[Tidak didefinisikan]',
                      style: CustomTheme.of(context).bodyText1,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      servicePackageName?.toString() ?? '',
                      style: CustomTheme.of(context).bodyText1,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Cash',
                      style: CustomTheme.of(context).bodyText1,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      totalCost?.toString() ?? '[Tidak didefinisikan]',
                      style: CustomTheme.of(context).bodyText1,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      OrderStatus.values[status].name?.toString() ??
                          '[Tidak didefinisikan]',
                      style: CustomTheme.of(context).bodyText1,
                    ),
                  ],
                ),
              ),
              if (status == OrderStatus.DIBAYAR.index)
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () => Get.toNamed(Routes.ADD_SERVICE_DETAIL, arguments: orderId),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Detail',
                          style: CustomTheme.of(context).bodyText1.override(
                            fontFamily: 'Poppins',
                            color: CustomTheme.of(context).primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              else
                Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(),
                      ],
                    )),
            ],
          ),
        ),
      ),
    );
  }
}

class OverviewTabBar extends StatelessWidget {
  OverviewTabBar({
    Key key,
  }) : super(key: key);

  final orderController = Get.find<OrderController>();

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => orderController.onRefresh(),
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                NotDoneView(),
                CancelledView(),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                OnProgressView(),
                DoneView(),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [],
            ),
          ],
        ),
      ),
    );
  }
}

class DoneView extends StatelessWidget {
  DoneView({
    Key key,
  }) : super(key: key);

  final doneViewController = Get.find<OrderController>().doneViewController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.57,
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB((30/1.w).w, (30/1.h).h, (30/1.w).w, (30/1.h).h),
          child: Material(
            color: Colors.transparent,
            elevation: 20,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            child: Container(
              width: (100/1.w).w,
              height: MediaQuery.of(context).size.height * 0.5,
              decoration: BoxDecoration(
                color: Color(0xFF00FF00),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB((20/1.w).w, (20/1.h).h, (20/1.w).w, (20/1.h).h),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Selesai',
                        style: CustomTheme.of(context).bodyText1.override(
                              fontFamily: 'Poppins',
                              color: CustomTheme.of(context).primaryBackground,
                              fontSize: (25/1.sp).sp,
                            ),
                      ),
                      doneViewController.obx((_) {
                        return ListView.builder(
                            padding: EdgeInsets.zero,
                            primary: false,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: doneViewController.doneOrderJsons.length,
                            itemBuilder: (BuildContext context, int index) {
                              return DoneSubView(
                                index: index,
                                queueNumber: doneViewController
                                    .doneOrderJsons[index]['index']
                                    .toString(),
                                plateNumber: doneViewController
                                    .doneOrderJsons[index]['plate_number'],
                                userName: doneViewController
                                    .doneOrderJsons[index]['user_full_name'],
                                servicePackageName: doneViewController
                                    .doneOrderJsons[index]['service_name'],
                              );
                            });
                      }),
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

class DoneSubView extends StatelessWidget {
  DoneSubView({
    Key key,
    @required this.index,
    @required this.queueNumber,
    @required this.plateNumber,
    @required this.userName,
    @required this.servicePackageName,
  }) : super(key: key);

  final doneViewController = Get.find<OrderController>().doneViewController;

  int index;
  String queueNumber;
  String plateNumber;
  String userName;
  String servicePackageName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, (5/1.w).w, 0, (5/1.w).w),
      child: Material(
        color: Colors.transparent,
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          width: double.infinity,
          height: (100/1.h).h,
          decoration: BoxDecoration(
            color: CustomTheme.of(context).primaryBackground,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                flex: 4,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB((10/1.w).w, 0, (10/1.w).w, 0),
                      child: Text(
                        'Nomor Antrian',
                        style: CustomTheme.of(context).bodyText1.override(
                              fontFamily: 'Poppins',
                              fontSize: (18/1.sp).sp,
                            ),
                      ),
                    ),
                    Text(
                      queueNumber?.toString() ?? '[Tidak didefinisikan]',
                      style: CustomTheme.of(context).bodyText1.override(
                            fontFamily: 'Poppins',
                            fontSize: (16/1.sp).sp,
                          ),
                    ),
                    Text(
                      'Belum Dibayar',
                      style: CustomTheme.of(context).bodyText1,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 5,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      plateNumber?.toString() ?? '[Tidak didefinisikan]',
                      style: CustomTheme.of(context).bodyText1,
                    ),
                    Text(
                      userName?.toString() ?? '[Tidak didefinisikan]',
                      style: CustomTheme.of(context).bodyText1,
                    ),
                    Text(
                      servicePackageName?.toString() ?? '',
                      style: CustomTheme.of(context).bodyText1,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB((5/1.w).w, 0, (5/1.w).w, 0),
                      child: CustomButton(
                        tag: 'paidBtn$index',
                        onPressed: () => Get.toNamed(Routes.ADD_SERVICE_DETAIL,
                            arguments: doneViewController.doneOrderJsons[index]
                                ['id']),
                        text: 'Dibayar',
                        options: CustomButtonOptions(
                          width: (130/1.w).w,
                          height: (40/1.h).h,
                          color: Color(0xFF00FF00),
                          textStyle: CustomTheme.of(context).subtitle2.override(
                                fontFamily: 'Poppins',
                                color: CustomTheme.of(context).primaryText,
                              ),
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: (1/1.w).w,
                          ),
                          borderRadius: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OnProgressView extends StatelessWidget {
  OnProgressView({
    Key key,
  }) : super(key: key);

  final onProgressViewController =
      Get.find<OrderController>().onProgressViewController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.57,
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB((30/1.w).w, (30/1.h).h, (30/1.w).w, (30/1.h).h),
          child: Material(
            color: Colors.transparent,
            elevation: 20,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            child: Container(
              width: (100/1.w).w,
              height: MediaQuery.of(context).size.height * 0.5,
              decoration: BoxDecoration(
                color: CustomTheme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB((20/1.w).w, (20/1.h).h, (20/1.w).w, (20/1.h).h),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sedang Dikerjakan',
                        style: CustomTheme.of(context).bodyText1.override(
                              fontFamily: 'Poppins',
                              color: CustomTheme.of(context).primaryBackground,
                              fontSize: (25/1.sp).sp,
                            ),
                      ),
                      onProgressViewController.obx((_) {
                        return ListView.builder(
                            padding: EdgeInsets.zero,
                            primary: false,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: onProgressViewController
                                .onProgressOrderJsons.length,
                            itemBuilder: (BuildContext context, int index) {
                              return OnProgressSubView(
                                index: index,
                                queueNumber: onProgressViewController
                                    .onProgressOrderJsons[index]['index']
                                    .toString(),
                                plateNumber: onProgressViewController
                                        .onProgressOrderJsons[index]
                                    ['plate_number'],
                                userName: onProgressViewController
                                        .onProgressOrderJsons[index]
                                    ['user_full_name'],
                                servicePackageName: onProgressViewController
                                        .onProgressOrderJsons[index]
                                    ['service_name'],
                                cancelNotes: onProgressViewController
                                    .onProgressOrderJsons[index]['notes'],
                                lastAction: onProgressViewController
                                    .onProgressOrderJsons[index]['last_action'],
                              );
                            });
                      }),
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

class OnProgressSubView extends StatelessWidget {
  OnProgressSubView(
      {Key key,
      @required this.index,
      @required this.queueNumber,
      @required this.plateNumber,
      @required this.userName,
      @required this.servicePackageName,
      @required this.cancelNotes,
      @required this.lastAction})
      : super(key: key);

  final onProgressViewController =
      Get.find<OrderController>().onProgressViewController;

  int index;
  String queueNumber;
  String plateNumber;
  String userName;
  String servicePackageName;
  String cancelNotes;
  String lastAction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, (5/1.h).h, 0, (5/1.h).h),
      child: Material(
        color: Colors.transparent,
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: CustomTheme.of(context).primaryBackground,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                flex: 4,
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB((10/1.w).w, 0, 0, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB((10/1.w).w, 0, (10/1.w).w, 0),
                        child: Text(
                          'Nomor Antrian',
                          style: CustomTheme.of(context).bodyText1.override(
                                fontFamily: 'Poppins',
                                fontSize: (18/1.sp).sp,
                              ),
                        ),
                      ),
                      Text(
                        queueNumber?.toString() ?? '[Tidak didefinisikan]',
                        style: CustomTheme.of(context).bodyText1.override(
                              fontFamily: 'Poppins',
                              fontSize: (16/1.sp).sp,
                            ),
                      ),
                      Text(
                        'Proses saat ini :',
                        textAlign: TextAlign.center,
                        style: CustomTheme.of(context).bodyText1.override(
                              fontFamily: 'Poppins',
                              fontSize: (12/1.sp).sp,
                            ),
                      ),
                      Text(
                        lastAction?.toString() ?? '',
                        textAlign: TextAlign.center,
                        style: CustomTheme.of(context).bodyText1.override(
                              fontFamily: 'Poppins',
                              fontSize: (12/1.sp).sp,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      plateNumber?.toString() ?? '[Tidak didefinisikan]',
                      style: CustomTheme.of(context).bodyText1,
                    ),
                    Text(
                      userName?.toString() ?? '[Tidak didefinisikan]',
                      style: CustomTheme.of(context).bodyText1,
                    ),
                    Text(
                      servicePackageName?.toString() ?? '',
                      style: CustomTheme.of(context).bodyText1,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB((5/1.w).w, (5/1.h).h, (5/1.w).w, (5/1.h).h),
                      child: CustomButton(
                        tag: 'doneBtn$index',
                        onPressed: () => Get.dialog(
                          AlertDialog(
                            title: const Text('Konfirmasi penyelesaian order'),
                            actions: [
                              TextButton(
                                child: const Text("Tidak"),
                                onPressed: () => Get.back(),
                              ),
                              TextButton(
                                child: const Text("Ya"),
                                onPressed: () => onProgressViewController
                                    .finishingOrder(index),
                              ),
                            ],
                          ),
                        ),
                        text: 'Selesai',
                        options: CustomButtonOptions(
                          width: (130/1.w).w,
                          height: (40/1.h).h,
                          color: Color(0xFF00FF00),
                          textStyle: CustomTheme.of(context).subtitle2.override(
                                fontFamily: 'Poppins',
                                color: CustomTheme.of(context).primaryText,
                              ),
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: (1/1.w).w,
                          ),
                          borderRadius: 12,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB((5/1.w).w, (5/1.h).h, (5/1.w).w, (5/1.h).h),
                      child: CustomButton(
                        tag: 'addProcessBtn$index',
                        onPressed: () {
                          Get.dialog(
                            AlertDialog(
                              scrollable: true,
                              title: const Text(
                                'Tambahkan proses baru',
                              ),
                              titleTextStyle:
                                  CustomTheme.of(context).bodyText1.override(
                                        fontFamily: 'Poppins',
                                        fontSize: (18/1.sp).sp,
                                      ),
                              content: AddProcessView(
                                selectedIndex: index,
                              ),
                            ),
                          );
                        },
                        text: '+ Proses',
                        options: CustomButtonOptions(
                          width: (130/1.w).w,
                          height: (40/1.h).h,
                          color: CustomTheme.of(context).tertiaryColor,
                          textStyle: CustomTheme.of(context).subtitle2.override(
                                fontFamily: 'Poppins',
                                color: CustomTheme.of(context).primaryText,
                              ),
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: (1/1.w).w,
                          ),
                          borderRadius: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CancelledView extends StatelessWidget {
  CancelledView({
    Key key,
  }) : super(key: key);

  final cancelledViewController =
      Get.find<OrderController>().cancelledViewController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.57,
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB((30/1.w).w, (30/1.h).h, (30/1.w).w, (30/1.h).h),
          child: Material(
            color: Colors.transparent,
            elevation: 20,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            child: Container(
              width: (100/1.w).w,
              height: MediaQuery.of(context).size.height * 0.5,
              decoration: BoxDecoration(
                color: CustomTheme.of(context).alternate,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB((20/1.w).w, (20/1.h).h, (20/1.w).w, (20/1.h).h),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Dibatalkan',
                        style: CustomTheme.of(context).bodyText1.override(
                              fontFamily: 'Poppins',
                              color: CustomTheme.of(context).primaryBackground,
                              fontSize: (25/1.sp).sp,
                            ),
                      ),
                      cancelledViewController.obx((_) {
                        return ListView.builder(
                            padding: EdgeInsets.zero,
                            primary: false,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: cancelledViewController
                                .cancelledOrderJsons.length,
                            itemBuilder: (BuildContext context, int index) {
                              return CancelledSubView(
                                index: index,
                                queueNumber: cancelledViewController
                                    .cancelledOrderJsons[index]['index']
                                    .toString(),
                                plateNumber: cancelledViewController
                                    .cancelledOrderJsons[index]['plate_number'],
                                userName: cancelledViewController
                                        .cancelledOrderJsons[index]
                                    ['user_full_name'],
                                servicePackageName: cancelledViewController
                                    .cancelledOrderJsons[index]['service_name'],
                                cancelNotes: cancelledViewController
                                    .cancelledOrderJsons[index]['notes'],
                              );
                            });
                      }),
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

class CancelledSubView extends StatelessWidget {
  CancelledSubView(
      {Key key,
      @required this.index,
      @required this.queueNumber,
      @required this.plateNumber,
      @required this.userName,
      @required this.servicePackageName,
      @required this.cancelNotes})
      : super(key: key);

  final cancelledViewController =
      Get.find<OrderController>().cancelledViewController;

  int index;
  String queueNumber;
  String plateNumber;
  String userName;
  String servicePackageName;
  String cancelNotes;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, (5/1.w).w, 0, (5/1.w).w),
      child: Material(
        color: Colors.transparent,
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          width: double.infinity,
          height: (100/1.h).h,
          decoration: BoxDecoration(
            color: CustomTheme.of(context).primaryBackground,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB((10/1.w).w, 0, (10/1.w).w, 0),
                      child: Text(
                        'Nomor Antrian',
                        textAlign: TextAlign.center,
                        style: CustomTheme.of(context).bodyText1.override(
                              fontFamily: 'Poppins',
                              fontSize: (18/1.sp).sp,
                            ),
                      ),
                    ),
                    Text(
                      queueNumber?.toString() ?? '[Tidak didefinisikan]',
                      style: CustomTheme.of(context).bodyText1.override(
                            fontFamily: 'Poppins',
                            fontSize: (16/1.sp).sp,
                          ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 5,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      plateNumber?.toString() ?? '[Tidak didefinisikan]',
                      style: CustomTheme.of(context).bodyText1,
                    ),
                    Text(
                      userName?.toString() ?? '[Tidak didefinisikan]',
                      style: CustomTheme.of(context).bodyText1,
                    ),
                    Text(
                      servicePackageName?.toString() ?? '',
                      style: CustomTheme.of(context).bodyText1,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 4,
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, (5/1.h).h, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10/1.w, 0, 10/1.w, 0),
                        child: Text(
                          'Alasan',
                          style: CustomTheme.of(context).bodyText1.override(
                                fontFamily: 'Poppins',
                                fontSize: (18/1.sp).sp,
                              ),
                        ),
                      ),
                      Text(
                        cancelNotes?.toString() ?? '[Tidak didefinisikan]',
                        textAlign: TextAlign.center,
                        style: CustomTheme.of(context).bodyText1.override(
                              fontFamily: 'Poppins',
                              fontSize: (12/1.sp).sp,
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
    );
  }
}

class NotDoneView extends StatelessWidget {
  NotDoneView({
    Key key,
  }) : super(key: key);

  final notDoneViewController =
      Get.find<OrderController>().notDoneViewController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.57,
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB((30/1.w).w, (30/1.h).h, (30/1.w).w, (30/1.h).h),
          child: Material(
            color: Colors.transparent,
            elevation: 20,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            child: Container(
              width: (100/1.w).w,
              height: MediaQuery.of(context).size.height * 0.5,
              decoration: BoxDecoration(
                color: CustomTheme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB((20/1.w).w, (20/1.h).h, (20/1.w).w, (20/1.h).h),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Belum Dikerjakan',
                        style: CustomTheme.of(context).bodyText1.override(
                              fontFamily: 'Poppins',
                              color: CustomTheme.of(context).primaryBackground,
                              fontSize: (25/1.sp).sp,
                            ),
                      ),
                      notDoneViewController.obx((_) {
                        return ListView.builder(
                            padding: EdgeInsets.zero,
                            primary: false,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount:
                                notDoneViewController.undoneOrderJsons.length,
                            itemBuilder: (BuildContext context, int index) {
                              return NotDoneSubView(
                                index: index,
                                queueNumber: notDoneViewController
                                    .undoneOrderJsons[index]['index']
                                    .toString(),
                                plateNumber: notDoneViewController
                                    .undoneOrderJsons[index]['plate_number'],
                                userName: notDoneViewController
                                    .undoneOrderJsons[index]['user_full_name'],
                                servicePackageName: notDoneViewController
                                    .undoneOrderJsons[index]['service_name'],
                              );
                            });
                      }),
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

class NotDoneSubView extends StatelessWidget {
  NotDoneSubView({
    Key key,
    @required this.index,
    @required this.queueNumber,
    @required this.plateNumber,
    @required this.userName,
    @required this.servicePackageName,
  }) : super(key: key);

  final notDoneViewController =
      Get.find<OrderController>().notDoneViewController;

  int index;
  String queueNumber;
  String plateNumber;
  String userName;
  String servicePackageName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, (5/1.w).w, 0, (5/1.w).w),
      child: Material(
        color: Colors.transparent,
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          width: double.infinity,
          height: (100/1.h).h,
          decoration: BoxDecoration(
            color: CustomTheme.of(context).primaryBackground,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                flex: 4,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB((10/1.w).w, 0, (10/1.w).w, 0),
                      child: Text(
                        'Nomor Antrian',
                        style: CustomTheme.of(context).bodyText1.override(
                              fontFamily: 'Poppins',
                              fontSize: (18/1.sp).sp,
                            ),
                      ),
                    ),
                    Text(
                      queueNumber?.toString() ?? '[Tidak didefinisikan]',
                      style: CustomTheme.of(context).bodyText1.override(
                            fontFamily: 'Poppins',
                            fontSize: (16/1.sp).sp,
                          ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 5,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      plateNumber?.toString() ?? '[Tidak didefinisikan]',
                      style: CustomTheme.of(context).bodyText1,
                    ),
                    Text(
                      userName?.toString() ?? '[Tidak didefinisikan]',
                      style: CustomTheme.of(context).bodyText1,
                    ),
                    Text(
                      servicePackageName?.toString() ?? '',
                      style: CustomTheme.of(context).bodyText1,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    (index == 0)
                        ? Padding(
                            padding: EdgeInsetsDirectional.fromSTEB((5/1.w).w, 0, (5/1.w).w, 0),
                            child: CustomButton(
                              tag: 'processOrderBtn$index',
                              onPressed: () => Get.dialog(
                                AlertDialog(
                                  title:
                                      const Text('Konfirmasi penerimaan order'),
                                  actions: [
                                    TextButton(
                                      child: const Text("Tidak"),
                                      onPressed: () => Get.back(),
                                    ),
                                    TextButton(
                                      child: const Text("Ya"),
                                      onPressed: () => notDoneViewController
                                          .processingOrder(index),
                                    ),
                                  ],
                                ),
                              ),
                              text: 'Kerjakan',
                              options: CustomButtonOptions(
                                width: (130/1.w).w,
                                height: (40/1.h).h,
                                color: Color(0xFF00FF00),
                                textStyle: CustomTheme.of(context)
                                    .subtitle2
                                    .override(
                                      fontFamily: 'Poppins',
                                      color:
                                          CustomTheme.of(context).primaryText,
                                    ),
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: (1/1.w).w,
                                ),
                                borderRadius: 12,
                              ),
                            ),
                          )
                        : Container(),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB((5/1.w).w, 0, (5/1.w).w, 0),
                      child: CustomButton(
                        tag: 'cancelOrderBtn$index',
                        onPressed: () {
                          Get.dialog(
                            AlertDialog(
                              scrollable: true,
                              title: const Text(
                                'Alasan Cancel',
                              ),
                              titleTextStyle:
                                  CustomTheme.of(context).bodyText1.override(
                                        fontFamily: 'Poppins',
                                        fontSize: (18/1.sp).sp,
                                      ),
                              content: CancelOrderView(
                                selectedIndex: index,
                              ),
                            ),
                          );
                        },
                        text: 'Batalkan',
                        options: CustomButtonOptions(
                          width: (130/1.w).w,
                          height: (40/1.h).h,
                          color: CustomTheme.of(context).alternate,
                          textStyle: CustomTheme.of(context).subtitle2.override(
                                fontFamily: 'Poppins',
                                color: CustomTheme.of(context).primaryText,
                              ),
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: (1/1.w).w,
                          ),
                          borderRadius: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CancelOrderView extends StatelessWidget {
  CancelOrderView({
    Key key,
    @required this.selectedIndex,
  }) : super(key: key) {
    notDoneViewController = Get.find<OrderController>().notDoneViewController;
  }

  int selectedIndex;
  NotDoneViewController notDoneViewController;

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.30,
        decoration: BoxDecoration(),
        child: Form(
          key: notDoneViewController.formKey,
          autovalidateMode: AutovalidateMode.always,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, (10/1.h).h, 0, (10/1.h).h),
                child: TextFormField(
                  controller: notDoneViewController.cancelNotesFieldController,
                  obscureText: false,
                  decoration: InputDecoration(
                    hintText: 'Masukan alasan pembatalan disini',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: CustomTheme.of(context).primaryText,
                        width: (2/1.w).w,
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(4.0),
                        topRight: Radius.circular(4.0),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: CustomTheme.of(context).primaryText,
                        width: (2/1.w).w,
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(4.0),
                        topRight: Radius.circular(4.0),
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: CustomTheme.of(context).alternate,
                        width: (2/1.w).w,
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(4.0),
                        topRight: Radius.circular(4.0),
                      ),
                    ),
                    contentPadding:
                        EdgeInsetsDirectional.fromSTEB((10/1.w).w, (10/1.h).h, (10/1.w).w, (10/1.h).h),
                  ),
                  style: CustomTheme.of(context).bodyText1.override(
                        fontFamily: 'Poppins',
                        fontSize: (14/1.sp).sp,
                        fontWeight: FontWeight.w600,
                      ),
                  keyboardType: TextInputType.name,
                  maxLines: 3,
                  validator: (val) {
                    if (val.isEmpty) {
                      return "Alasan pembatalan harus diisi";
                    }
                    return null;
                  },
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, (5/1.h).h, 0, 0),
                    child: CustomButton(
                      tag: 'submitCancellationOrder',
                      onPressed: () =>
                          notDoneViewController.cancelOrder(selectedIndex),
                      text: 'Kirim',
                      options: CustomButtonOptions(
                        width: (130/1.w).w,
                        height: (40/1.h).h,
                        color: CustomTheme.of(context).primaryText,
                        textStyle: CustomTheme.of(context).subtitle2.override(
                              fontFamily: 'Poppins',
                              color: Colors.white,
                              fontSize: (14/1.sp).sp,
                            ),
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: (1/1.w).w,
                        ),
                        borderRadius: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AddProcessView extends StatelessWidget {
  AddProcessView({
    Key key,
    @required this.selectedIndex,
  }) : super(key: key) {
    onProgressViewController =
        Get.find<OrderController>().onProgressViewController;
  }

  int selectedIndex;
  OnProgressViewController onProgressViewController;

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.30,
        decoration: BoxDecoration(),
        child: Form(
          key: onProgressViewController.formKey,
          autovalidateMode: AutovalidateMode.always,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, (10/1.h).h, 0, (10/1.h).h),
                child: TextFormField(
                  controller:
                      onProgressViewController.nextProcessFieldController,
                  obscureText: false,
                  decoration: InputDecoration(
                    hintText: 'Masukan proses selanjutnya disini',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: CustomTheme.of(context).primaryText,
                        width: (2/1.w).w,
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(4.0),
                        topRight: Radius.circular(4.0),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: CustomTheme.of(context).primaryText,
                        width: (2/1.w).w,
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(4.0),
                        topRight: Radius.circular(4.0),
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: CustomTheme.of(context).alternate,
                        width: (2/1.w).w,
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(4.0),
                        topRight: Radius.circular(4.0),
                      ),
                    ),
                    contentPadding:
                        EdgeInsetsDirectional.fromSTEB((10/1.w).w, (10/1.h).h, (10/1.w).w, (10/1.h).h),
                  ),
                  style: CustomTheme.of(context).bodyText1.override(
                        fontFamily: 'Poppins',
                        fontSize: (14/1.sp).sp,
                        fontWeight: FontWeight.w600,
                      ),
                  keyboardType: TextInputType.name,
                  maxLines: 3,
                  validator: (val) {
                    if (val.isEmpty) {
                      return "Proses selanjutnya tidak boleh kosong";
                    }
                    return null;
                  },
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, (5/1.h).h, 0, 0),
                    child: CustomButton(
                      tag: 'submitNewProcessBtn',
                      onPressed: () => onProgressViewController
                          .addOrderProcess(selectedIndex),
                      text: 'Tambah',
                      options: CustomButtonOptions(
                        width: (130/1.w).w,
                        height: (40/1.h).h,
                        color: CustomTheme.of(context).primaryText,
                        textStyle: CustomTheme.of(context).subtitle2.override(
                              fontFamily: 'Poppins',
                              color: Colors.white,
                              fontSize: (14/1.sp).sp,
                            ),
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: (1/1.w).w,
                        ),
                        borderRadius: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
