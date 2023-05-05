import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:skripskuy_web/app/modules/service/views/service_view.dart';

import '../../../utils/custom_theme.dart';
import '../../account/views/account_view.dart';
import '../../home/views/home_view.dart';
import '../../order/views/order_view.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends StatelessWidget {
  final dashboardController = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: dashboardController.obx((_) {
          return Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                flex: 5,
                child: HeaderPage(
                  controller: dashboardController,
                ),
              ),
              Expanded(
                flex: 25,
                child: IndexedStack(
                  index: dashboardController.getTabIndex,
                  children: [
                    HomeView(),
                    OrderView(),
                    ServiceView(),
                    AccountView(),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
          elevation: 20,
          type: BottomNavigationBarType.fixed,
          onTap: dashboardController.setTabIndex,
          currentIndex: dashboardController.getTabIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Awal',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.event_note_rounded),
              label: 'Order',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home_repair_service_rounded),
              label: 'Serivce',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Akun',
            ),
          ],
        );
      }),
    );
  }
}

class HeaderPage extends StatelessWidget {
  HeaderPage({Key key, @required controller}) : super(key: key) {
    this.controller = controller;
  }

  DashboardController controller;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            flex: 7,
            child: Container(
              width: (100 / 1.w).w,
              height: (100 / 1.h).h,
              decoration: BoxDecoration(),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'BookQueue',
                    style: CustomTheme.of(context).bodyText1.override(
                          fontFamily: 'Poppins',
                          fontSize: (42 / 1.sp).sp,
                        ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(
                  0, (10 / 1.h).h, 0, (10 / 1.h).h),
              child: Material(
                color: Colors.transparent,
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(0),
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(0),
                  ),
                ),
                child: Container(
                  width: (450 / 1.w).w,
                  height: (100 / 1.h).h,
                  decoration: BoxDecoration(
                    color: CustomTheme.of(context).primaryBackground,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(0),
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(0),
                    ),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB((10 / 1.w).w, 0, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            width: (100 / 1.w).w,
                            height: (100 / 1.h).h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(30),
                                bottomRight: Radius.circular(0),
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(0),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'Order',
                                  style: CustomTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Poppins',
                                        fontSize: (18 / 1.sp).sp,
                                      ),
                                ),
                                Obx(() {
                                  return SwitchListTile(
                                    value:
                                        controller.serviceObj?.value?.isOpen ??
                                            false,
                                    onChanged: (isOpen) => controller
                                        .updateServiceStatus(isOpen: isOpen),
                                    title: Text(
                                      controller.serviceObj?.value?.isOpen ==
                                              true
                                          ? 'Buka'
                                          : 'Tutup' ?? '',
                                      textAlign: TextAlign.start,
                                      style: CustomTheme.of(context)
                                          .title3
                                          .override(
                                            fontFamily: 'Poppins',
                                            fontSize: (16 / 1.sp).sp,
                                          ),
                                    ),
                                    tileColor: Color(0xFFF5F5F5),
                                    dense: true,
                                    controlAffinity:
                                        ListTileControlAffinity.trailing,
                                  );
                                }),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: (5 / 1.w).w,
                          height: (80 / 1.h).h,
                          decoration: BoxDecoration(
                            color: CustomTheme.of(context).primaryText,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Container(
                            width: (100 / 1.w).w,
                            height: (100 / 1.h).h,
                            decoration: BoxDecoration(),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  width: (100 / 1.w).w,
                                  height: (100 / 1.h).w,
                                  decoration: BoxDecoration(),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        (10 / 1.w).w,
                                        (10 / 1.h).h,
                                        (10 / 1.w).w,
                                        (10 / 1.h).h),
                                    child: Container(
                                      width: (120 / 1.w).w,
                                      height: (120 / 1.h).h,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      // child: Image.network(
                                      //   'https://picsum.photos/seed/236/600',
                                      // ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        controller.authController?.user?.fullName
                                                ?.toString() ??
                                            '[Tidak didefinisikan]',
                                        style:
                                            CustomTheme.of(context).bodyText1,
                                      ),
                                      Text(
                                        controller.authController?.user?.email
                                                ?.toString() ??
                                            '[Tidak didefinisikan]',
                                        style:
                                            CustomTheme.of(context).bodyText1,
                                      ),
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
