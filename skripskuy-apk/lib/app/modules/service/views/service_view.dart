import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:skripskuy_web/app/config/enums.dart';
import 'package:skripskuy_web/app/modules/service/controllers/service_profile_view_controller.dart';

import '../../../utils/custom_button.dart';
import '../../../utils/custom_theme.dart';
import '../controllers/service_controller.dart';

class ServiceView extends StatelessWidget {
  final serviceController = Get.put(ServiceController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: serviceController.scaffoldKey,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: DefaultTabController(
            length: 3,
            initialIndex: 0,
            child: Column(
              children: [
                TabBar(
                  labelColor: CustomTheme.of(context).primaryColor,
                  labelStyle: CustomTheme.of(context).bodyText1,
                  indicatorColor: CustomTheme.of(context).secondaryColor,
                  tabs: [
                    Tab(
                      text: 'Profil Servis',
                    ),
                    Tab(
                      text: 'Paket Servis',
                    ),
                    Tab(
                      text: 'Ulasan',
                    ),
                  ],
                ),
                Expanded(
                  child: Obx(() {
                    return TabBarView(
                      children: [
                        (serviceController.isAllowedSubPage1.value == true)
                            ? ServiceProfileView(
                                serviceController: serviceController,
                              )
                            : NoServiceView(
                                serviceController: serviceController,
                              ),
                        (serviceController.isAllowedSubPage2.value == true)
                            ? ServiceCategoryView(
                                serviceController: serviceController,
                              )
                            : NoServiceView(
                                serviceController: serviceController,
                              ),
                        (serviceController.isAllowedSubPage3.value == true)
                            ? ReviewView(
                                serviceController: serviceController,
                              )
                            : NoServiceView(
                                serviceController: serviceController,
                              ),
                      ],
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ReviewView extends StatelessWidget {
  ReviewView({Key key, @required this.serviceController}) : super(key: key);

  ServiceController serviceController;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsetsDirectional.fromSTEB(
            (20 / 1.w).w, (20 / 1.h).h, (20 / 1.w).w, (20 / 1.h).h),
        child: Container(
          width: (100 / 1.w).w,
          height: (100 / 1.h).h,
          decoration: BoxDecoration(
            color: CustomTheme.of(context).primaryBackground,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(
                (10 / 1.w).w, (10 / 1.h).h, (10 / 1.w).w, (10 / 1.h).h),
            child: RefreshIndicator(
              onRefresh: () =>
                  serviceController.reviewViewController.onRefresh(),
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
                          padding: EdgeInsetsDirectional.fromSTEB((10 / 1.w).w,
                              (10 / 1.h).h, (10 / 1.w).w, (10 / 1.h).h),
                          child: Text(
                            'Ulasan Servis',
                            style: CustomTheme.of(context).bodyText1.override(
                                  fontFamily: 'Poppins',
                                  fontSize: (30 / 1.sp).sp,
                                ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0, (5 / 1.h).h, 0, 0),
                      child: serviceController.reviewViewController
                          .obx((reviewJsons) {
                        return Container(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.75,
                          decoration: BoxDecoration(),
                          child: ListView.builder(
                              padding: EdgeInsets.zero,
                              primary: false,
                              scrollDirection: Axis.vertical,
                              itemCount: reviewJsons?.length ?? 0,
                              itemBuilder: (BuildContext context, int index) {
                                return ReviewSubListView(
                                  serviceName: reviewJsons[index]
                                      ['service_name'],
                                  plateNumber: reviewJsons[index]
                                      ['plate_number'],
                                  userName: reviewJsons[index]
                                      ['user_full_name'],
                                  reviewDescription: reviewJsons[index]
                                      ['description'],
                                  rating:
                                      reviewJsons[index]['rating'].toDouble(),
                                  date: reviewJsons[index]['date'],
                                );
                              }),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}

class ReviewSubListView extends StatelessWidget {
  ReviewSubListView({
    Key key,
    @required this.serviceName,
    @required this.plateNumber,
    @required this.userName,
    @required this.reviewDescription,
    @required this.rating,
    @required this.date,
  }) : super(key: key);

  String serviceName;
  String plateNumber;
  String userName;
  String reviewDescription;
  double rating;
  String date;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(
          (10 / 1.w).w, (5 / 1.h).h, (10 / 1.w).w, (5 / 1.h).h),
      child: IntrinsicHeight(
        child: Container(
          width: (100 / 1.w).w,
          decoration: BoxDecoration(
            color: CustomTheme.of(context).secondaryBackground,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                flex: 50,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      serviceName?.toString() ?? '[Tidak didefinisikan]',
                      style: CustomTheme.of(context).bodyText1.override(
                            fontFamily: 'Poppins',
                            fontSize: (24 / 1.sp).sp,
                          ),
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      plateNumber,
                      style: CustomTheme.of(context).bodyText1.override(
                            fontFamily: 'Poppins',
                            fontSize: (18 / 1.sp).sp,
                          ),
                    ),
                    Text(
                      userName?.toString() ?? '[Tidak didefinisikan]',
                      style: CustomTheme.of(context).bodyText1.override(
                            fontFamily: 'Poppins',
                            fontSize: (18 / 1.sp).sp,
                          ),
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            0, (20 / 1.h).h, 0, (20 / 1.h).h),
                        child: Container(
                          width: (1 / 1.w).w,
                          height: (100 / 1.h).h,
                          decoration: BoxDecoration(
                            color: CustomTheme.of(context).primaryText,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 70,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      reviewDescription?.toString() ?? '[Tidak didefinisikan]',
                      style: CustomTheme.of(context).bodyText1.override(
                            fontFamily: 'Poppins',
                            fontSize: (24 / 1.sp).sp,
                          ),
                      maxLines: 10,
                      overflow: TextOverflow.ellipsis,
                    ),
                    RatingBarIndicator(
                      itemBuilder: (context, index) => Icon(
                        Icons.star_rounded,
                        color: Color(0xFFFFA130),
                      ),
                      direction: Axis.horizontal,
                      rating: rating?.toDouble() ?? 0.0,
                      unratedColor: Color(0xFF95A1AC),
                      itemCount: 5,
                      itemSize: 15.38.sp,
                    ),
                    Text(
                      date?.toString() ?? '[Tidak didefinisikan]',
                      style: CustomTheme.of(context).bodyText1.override(
                            fontFamily: 'Poppins',
                            fontSize: (18 / 1.sp).sp,
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

class NoServiceView extends StatelessWidget {
  NoServiceView({Key key, @required this.serviceController}) : super(key: key);

  ServiceController serviceController = Get.find<ServiceController>();

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, (20 / 1.h).h, 0, 0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.25,
                  height: MediaQuery.of(context).size.height * 0.32,
                  decoration: BoxDecoration(),
                  child: Lottie.asset(
                    'assets/lotties/incorrect.json',
                    fit: BoxFit.cover,
                    animate: true,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(
                    0, (100 / 1.h).h, 0, (50 / 1.h).h),
                child: Text(
                  'Kamu belum memiliki servis',
                  style: CustomTheme.of(context).bodyText1.override(
                        fontFamily: 'Poppins',
                        fontSize: 35,
                      ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, (20 / 1.h).h),
                child: CustomButton(
                  tag: 'serviceRegistrationBtn',
                  onPressed: () => serviceController.isAllowedSubPage1.toggle(),
                  text: 'Daftar',
                  options: CustomButtonOptions(
                    width: (200 / 1.w).w,
                    height: (60 / 1.h).h,
                    color: CustomTheme.of(context).primaryText,
                    textStyle: CustomTheme.of(context).subtitle2.override(
                          fontFamily: 'Poppins',
                          color: Colors.white,
                          fontSize: (32 / 1.sp).sp,
                        ),
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: (1 / 1.w).w,
                    ),
                    borderRadius: 12,
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

class ServiceCategoryView extends StatelessWidget {
  ServiceCategoryView({Key key, @required this.serviceController})
      : super(key: key);

  ServiceController serviceController = Get.find<ServiceController>();

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () =>
          serviceController.serviceCategoryViewController.initServicePackage(),
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            serviceController.serviceCategoryViewController.obx((_) {
              return RefreshIndicator(
                onRefresh: () => serviceController.serviceCategoryViewController
                    .initServicePackage(),
                child: ListView.builder(
                    padding: EdgeInsets.zero,
                    primary: false,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: serviceController.serviceCategoryViewController
                        .servicePackageObjs.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ServiceCategorySubView(
                        index: index.obs,
                      );
                    }),
              );
            }),
            AddServiceCategoryBtn(),
          ],
        ),
      ),
    );
  }
}

class AddServiceCategoryBtn extends StatelessWidget {
  AddServiceCategoryBtn({
    Key key,
  }) : super(key: key);

  ServiceController serviceController = Get.find<ServiceController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(
          (20 / 1.w).w, (20 / 1.h).h, (20 / 1.w).w, (20 / 1.h).h),
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.1,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: CustomButton(
                tag: 'addServiceCategoryBtn1',
                onPressed: () {
                  Get.dialog(
                    AlertDialog(
                      scrollable: true,
                      title: const Text(
                        'Tambahkan Kategori Servis Baru',
                      ),
                      titleTextStyle:
                          CustomTheme.of(context).bodyText1.override(
                                fontFamily: 'Poppins',
                                fontSize: (18 / 1.sp).sp,
                              ),
                      content: ManageServiceCategoryView(
                        isAdding: true,
                      ),
                    ),
                  );
                },
                text: '+ Add Service',
                options: CustomButtonOptions(
                  width: double.infinity,
                  height: double.infinity,
                  color: Color(0xFF00FF00),
                  textStyle: CustomTheme.of(context).subtitle2.override(
                        fontFamily: 'Poppins',
                        color: CustomTheme.of(context).primaryText,
                        fontSize: (28 / 1.sp).sp,
                      ),
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: (1 / 1.w).w,
                  ),
                  borderRadius: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ServiceCategorySubView extends StatelessWidget {
  ServiceCategorySubView({Key key, @required this.index}) : super(key: key);

  ServiceController serviceController = Get.find<ServiceController>();
  var index = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(
          (20 / 1.w).w, (20 / 1.h).h, (20 / 1.w).w, (20 / 1.h).h),
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.25,
        decoration: BoxDecoration(
          color: Color(0xFFEEEEEE),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'Nama Servis',
                                style:
                                    CustomTheme.of(context).bodyText1.override(
                                          fontFamily: 'Poppins',
                                          fontSize: (18 / 1.sp).sp,
                                        ),
                              ),
                              Text(
                                serviceController
                                        .serviceCategoryViewController
                                        .servicePackageObjs[index.value]
                                        .value
                                        .name
                                        ?.toString() ??
                                    '[Tidak didefinisikan]',
                                style: CustomTheme.of(context).bodyText1,
                                maxLines: 5,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'Deskripsi Servis',
                                style:
                                    CustomTheme.of(context).bodyText1.override(
                                          fontFamily: 'Poppins',
                                          fontSize: (18 / 1.sp).sp,
                                        ),
                                maxLines: 10,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Text(
                                          serviceController
                                                  .serviceCategoryViewController
                                                  .servicePackageObjs[
                                                      index.value]
                                                  .value
                                                  .description
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
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'Tipe',
                                style:
                                    CustomTheme.of(context).bodyText1.override(
                                          fontFamily: 'Poppins',
                                          fontSize: (18 / 1.sp).sp,
                                        ),
                                maxLines: 5,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                serviceController
                                        .serviceCategoryViewController
                                        .servicePackageObjs[index.value]
                                        .value
                                        .type
                                        ?.toString() ??
                                    '[Tidak didefinisikan]',
                                style: CustomTheme.of(context).bodyText1,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'Harga',
                                style:
                                    CustomTheme.of(context).bodyText1.override(
                                          fontFamily: 'Poppins',
                                          fontSize: (18 / 1.sp).sp,
                                        ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Rp. ',
                                    style: CustomTheme.of(context).bodyText1,
                                  ),
                                  Text(
                                    NumberFormat.currency(locale: 'ID')
                                            .format(serviceController
                                                .serviceCategoryViewController
                                                .servicePackageObjs[index.value]
                                                .value
                                                .cost)
                                            ?.toString() ??
                                        '[Tidak didefinisikan]'
                                            .replaceAll('IDR', ''),
                                    style: CustomTheme.of(context).bodyText1,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                (20 / 1.w).w,
                                (20 / 1.h).h,
                                (20 / 1.w).w,
                                (20 / 1.h).h),
                            child: Container(
                              width: (100 / 1.w).w,
                              height: (100 / 1.h).h,
                              decoration: BoxDecoration(
                                color: Color(0xFFEEEEEE),
                              ),
                              child: CustomButton(
                                tag: 'updateServiceCategory' +
                                        serviceController
                                            .serviceCategoryViewController
                                            .servicePackageObjs[index.value]
                                            .value
                                            .name
                                            ?.toString() ??
                                    '[Tidak didefinisikan]',
                                onPressed: () {
                                  Get.dialog(
                                    AlertDialog(
                                      scrollable: true,
                                      title: const Text(
                                        'Perbaharui Kategori Servis',
                                      ),
                                      titleTextStyle: CustomTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Poppins',
                                            fontSize: (18 / 1.sp).sp,
                                          ),
                                      content: ManageServiceCategoryView(
                                        isAdding: false,
                                        index: index,
                                      ),
                                    ),
                                  );
                                },
                                text: 'Ubah',
                                options: CustomButtonOptions(
                                  width: (130 / 1.w).w,
                                  height: (40 / 1.h).h,
                                  color: CustomTheme.of(context).tertiaryColor,
                                  textStyle: CustomTheme.of(context)
                                      .subtitle2
                                      .override(
                                        fontFamily: 'Poppins',
                                        color:
                                            CustomTheme.of(context).primaryText,
                                      ),
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: (1 / 1.w).w,
                                  ),
                                  borderRadius: 12,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      (20 / 1.w).w,
                                      (20 / 1.h).h,
                                      (20 / 1.w).w,
                                      (20 / 1.h).h),
                                  child: Container(
                                    width: (100 / 1.w).w,
                                    height: (100 / 1.h).h,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFEEEEEE),
                                    ),
                                    child: CustomButton(
                                      tag: 'deleteServiceCategory' +
                                          serviceController
                                              .serviceCategoryViewController
                                              .servicePackageObjs[index.value]
                                              .value
                                              .name,
                                      onPressed: () => Get.dialog(
                                        AlertDialog(
                                          title: const Text(
                                              'Konfirmasi penghapusan paket servis'),
                                          actions: [
                                            TextButton(
                                              child: const Text("Tidak"),
                                              onPressed: () => Get.back(),
                                            ),
                                            TextButton(
                                              child: const Text("Ya"),
                                              onPressed: () => serviceController
                                                  .serviceCategoryViewController
                                                  .deleteServicePackage(
                                                      servicePackageId:
                                                          serviceController
                                                              .serviceCategoryViewController
                                                              .servicePackageObjs[
                                                                  index.value]
                                                              .value
                                                              .id),
                                            ),
                                          ],
                                        ),
                                      ),
                                      text: 'Hapus',
                                      options: CustomButtonOptions(
                                        width: (130 / 1.w).w,
                                        height: (40 / 1.h).h,
                                        color:
                                            CustomTheme.of(context).alternate,
                                        textStyle: CustomTheme.of(context)
                                            .subtitle2
                                            .override(
                                              fontFamily: 'Poppins',
                                              color: CustomTheme.of(context)
                                                  .primaryText,
                                            ),
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                          width: (1 / 1.w).w,
                                        ),
                                        borderRadius: 12,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ManageServiceCategoryView extends StatelessWidget {
  ManageServiceCategoryView({Key key, @required this.isAdding, this.index})
      : super(key: key) {
    serviceController = Get.find<ServiceController>();
    if (this.isAdding == false) {
      serviceController
              .serviceCategoryViewController
              .manageServicePackageViewController
              .categoryNameFieldController
              .text =
          serviceController.serviceCategoryViewController
              .servicePackageObjs[index.value].value.name;
      serviceController
              .serviceCategoryViewController
              .manageServicePackageViewController
              .categoryTypeFieldController
              .text =
          serviceController.serviceCategoryViewController
              .servicePackageObjs[index.value].value.type;
      serviceController
              .serviceCategoryViewController
              .manageServicePackageViewController
              .categoryDescriptionFieldController
              .text =
          serviceController.serviceCategoryViewController
              .servicePackageObjs[index.value].value.description;
      serviceController
              .serviceCategoryViewController
              .manageServicePackageViewController
              .categoryCostFieldController
              .text =
          serviceController.serviceCategoryViewController
              .servicePackageObjs[index.value].value.cost
              .toString();
    }
  }

  final bool isAdding;
  ServiceController serviceController;
  var index = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(),
      child: Form(
        key: serviceController.serviceCategoryViewController
            .manageServicePackageViewController.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(
                  0, (10 / 1.h).h, 0, (10 / 1.h).h),
              child: TextFormField(
                controller: serviceController
                    .serviceCategoryViewController
                    .manageServicePackageViewController
                    .categoryNameFieldController,
                obscureText: false,
                decoration: InputDecoration(
                  labelText: 'Nama Servis',
                  hintText: 'Masukan nama servis anda disini',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: CustomTheme.of(context).primaryText,
                      width: (2 / 1.w).w,
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(4.0),
                      topRight: Radius.circular(4.0),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: CustomTheme.of(context).primaryText,
                      width: (2 / 1.w).w,
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(4.0),
                      topRight: Radius.circular(4.0),
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: CustomTheme.of(context).alternate,
                      width: (2 / 1.w).w,
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(4.0),
                      topRight: Radius.circular(4.0),
                    ),
                  ),
                  contentPadding: EdgeInsetsDirectional.fromSTEB(
                      (10 / 1.w).w, (5 / 1.h).h, 0, (5 / 1.h).h),
                ),
                style: CustomTheme.of(context).bodyText1.override(
                      fontFamily: 'Poppins',
                      fontSize: (14 / 1.sp).sp,
                      fontWeight: FontWeight.w600,
                    ),
                keyboardType: TextInputType.name,
                validator: (val) {
                  if (val.isEmpty) {
                    return "Nama servis harus diisi";
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(
                  0, (10 / 1.h).h, 0, (10 / 1.h).h),
              child: TextFormField(
                controller: serviceController
                    .serviceCategoryViewController
                    .manageServicePackageViewController
                    .categoryTypeFieldController,
                obscureText: false,
                decoration: InputDecoration(
                  labelText: 'Tipe Servis',
                  hintText: 'Masukan tipe servis anda disini',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: CustomTheme.of(context).primaryText,
                      width: (2 / 1.w).w,
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(4.0),
                      topRight: Radius.circular(4.0),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: CustomTheme.of(context).primaryText,
                      width: (2 / 1.w).w,
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(4.0),
                      topRight: Radius.circular(4.0),
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: CustomTheme.of(context).alternate,
                      width: (2 / 1.w).w,
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(4.0),
                      topRight: Radius.circular(4.0),
                    ),
                  ),
                  contentPadding: EdgeInsetsDirectional.fromSTEB(
                      (10 / 1.w).w, (5 / 1.h).h, 0, (5 / 1.h).h),
                ),
                style: CustomTheme.of(context).bodyText1.override(
                      fontFamily: 'Poppins',
                      fontSize: (14 / 1.sp).sp,
                      fontWeight: FontWeight.w600,
                    ),
                keyboardType: TextInputType.text,
                validator: (val) {
                  if (val.isEmpty) {
                    return "Tipe servis harus diisi";
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(
                  0, (10 / 1.h).h, 0, (10 / 1.h).h),
              child: TextFormField(
                controller: serviceController
                    .serviceCategoryViewController
                    .manageServicePackageViewController
                    .categoryDescriptionFieldController,
                obscureText: false,
                decoration: InputDecoration(
                  labelText: 'Deskripsi Service',
                  hintText: 'Masukan deskripsi service mu disini',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: CustomTheme.of(context).primaryText,
                      width: (2 / 1.w).w,
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(4.0),
                      topRight: Radius.circular(4.0),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: CustomTheme.of(context).primaryText,
                      width: (2 / 1.w).w,
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(4.0),
                      topRight: Radius.circular(4.0),
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: CustomTheme.of(context).alternate,
                      width: (0.5.w),
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(4.0),
                      topRight: Radius.circular(4.0),
                    ),
                  ),
                  contentPadding: EdgeInsetsDirectional.fromSTEB(
                      (10 / 1.w).w, (5 / 1.h).h, 0, (5 / 1.h).h),
                ),
                keyboardType: TextInputType.text,
                style: CustomTheme.of(context).bodyText1.override(
                      fontFamily: 'Poppins',
                      fontSize: (16 / 1.sp).sp,
                    ),
                maxLines: 7,
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(
                  0, (10 / 1.h).h, 0, (10 / 1.h).h),
              child: TextFormField(
                controller: serviceController
                    .serviceCategoryViewController
                    .manageServicePackageViewController
                    .categoryCostFieldController,
                obscureText: false,
                decoration: InputDecoration(
                  labelText: 'Masukan harga servis',
                  hintText: 'Masukan harga servis anda disini',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: CustomTheme.of(context).primaryText,
                      width: (2 / 1.w).w,
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(4.0),
                      topRight: Radius.circular(4.0),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: CustomTheme.of(context).primaryText,
                      width: (2 / 1.w).w,
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(4.0),
                      topRight: Radius.circular(4.0),
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: CustomTheme.of(context).alternate,
                      width: (2 / 1.w).w,
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(4.0),
                      topRight: Radius.circular(4.0),
                    ),
                  ),
                  contentPadding: EdgeInsetsDirectional.fromSTEB(
                      (10 / 1.w).w, (5 / 1.h).h, 0, (5 / 1.h).h),
                ),
                keyboardType: TextInputType.number,
                style: CustomTheme.of(context).bodyText1.override(
                      fontFamily: 'Poppins',
                      fontSize: (16 / 1.sp).sp,
                      fontWeight: FontWeight.w600,
                    ),
                validator: (val) {
                  if (val.isEmpty) {
                    return "Harga servis harus diisi";
                  } else if (!val.isNumericOnly) {
                    return "Harap isi harga servis dengan angka saja";
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
                  padding: EdgeInsetsDirectional.fromSTEB(0, (5 / 1.w).w, 0, 0),
                  child: CustomButton(
                    tag: this.isAdding
                        ? 'addServiceCategoryBtn2'
                        : 'updateServiceCategoryBtn',
                    onPressed: this.isAdding
                        ? () => serviceController.serviceCategoryViewController
                            .manageServicePackageViewController
                            .createServicePackage()
                        : () => serviceController.serviceCategoryViewController
                            .manageServicePackageViewController
                            .updateServicePackage(
                                servicePackageId: serviceController
                                    .serviceCategoryViewController
                                    .servicePackageObjs[index.value]
                                    .value
                                    .id),
                    text: this.isAdding ? 'Tambahkan' : 'Perbaharui',
                    options: CustomButtonOptions(
                      width: (130 / 1.w).w,
                      height: (40 / 1.h).h,
                      color: CustomTheme.of(context).primaryText,
                      textStyle: CustomTheme.of(context).subtitle2.override(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            fontSize: (14 / 1.sp).sp,
                          ),
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: (1 / 1.w).w,
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
    );
  }
}

class ServiceProfileView extends StatelessWidget {
  const ServiceProfileView({
    Key key,
    @required this.serviceController,
  }) : super(key: key);

  final ServiceController serviceController;

  @override
  Widget build(BuildContext context) {
    return serviceController.serviceProfileViewController
        .obx((serviceProfileViewController) {
      return Container(
        width: (100 / 1.w).w,
        decoration: BoxDecoration(),
        child: RefreshIndicator(
          onRefresh: () => serviceController.serviceProfileViewController
              .initServiceProfile(),
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(
                      (20 / 1.w).w,
                      (20 / 1.h).h,
                      (20 / 1.w).w,
                      (20 / 1.h).h,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GetBuilder<ServiceProfileViewController>(
                            // specify type as Controller
                            init:
                                serviceController.serviceProfileViewController,
                            // intialize with the Controller
                            builder: (controller) {
                              if (controller.pickedFile != null) {
                                return ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image(
                                        image: Image.file(
                                      File(controller.pickedFile.path),
                                      fit: BoxFit.cover,
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.5,
                                    ).image));
                              } else {
                                if (controller
                                            .serviceObj.value.profilePicture !=
                                        null &&
                                    controller
                                            .serviceObj.value.profilePicture !=
                                        '') {
                                  return CachedNetworkImage(
                                    imageUrl: controller
                                        .serviceObj.value.profilePicture
                                        ?.toString(),
                                    fit: BoxFit.cover,
                                    imageBuilder: (context, imageProvider) =>
                                        ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Image(
                                              image: imageProvider,
                                              fit: BoxFit.cover,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.9,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.5,
                                            )),
                                    placeholder: (context, url) => ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Center(
                                          child: CircularProgressIndicator(
                                        backgroundColor: Colors.white,
                                      )),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  );
                                } else {
                                  return ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.5,
                                    ),
                                  );
                                }
                              }
                            }),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0, (10 / 1.h).h, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomButton(
                                tag: 'changeProfilePictureBtn',
                                onPressed: () => Get.bottomSheet(
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(16.0),
                                          topRight: Radius.circular(16.0)),
                                    ),
                                    child: Wrap(
                                      alignment: WrapAlignment.end,
                                      crossAxisAlignment:
                                          WrapCrossAlignment.end,
                                      children: [
                                        ListTile(
                                          leading: Icon(Icons.camera),
                                          title: Text('Camera'),
                                          onTap: () async {
                                            serviceController
                                                .serviceProfileViewController
                                                .pickImage(
                                                    imageSource:
                                                        ImageSource.camera);
                                          },
                                        ),
                                        ListTile(
                                          leading: Icon(Icons.image),
                                          title: Text('Gallery'),
                                          onTap: () async {
                                            serviceController
                                                .serviceProfileViewController
                                                .pickImage(
                                                    imageSource:
                                                        ImageSource.gallery);
                                            ;
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                text: 'Ubah Foto',
                                options: CustomButtonOptions(
                                  width: (130 / 1.w).w,
                                  height: (40 / 1.h).h,
                                  color: CustomTheme.of(context).primaryText,
                                  textStyle: CustomTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Poppins',
                                        color: CustomTheme.of(context)
                                            .primaryBackground,
                                        fontSize: (16 / 1.sp).sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                  elevation: 1,
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: (1 / 1.w).w,
                                  ),
                                  borderRadius: 8,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.75,
                  decoration: BoxDecoration(
                    color: CustomTheme.of(context).primaryBackground,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ServiceInformationView(
                          serviceController: serviceController),
                      Expanded(
                        child: IntrinsicHeight(
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                OperationalTimeView(
                                  serviceController: serviceController,
                                ),
                                VehicleServiceTypeView(
                                  serviceController: serviceController,
                                ),
                              ],
                            ),
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
    });
  }
}

class VehicleServiceTypeView extends StatelessWidget {
  const VehicleServiceTypeView({Key key, @required this.serviceController})
      : super(key: key);

  final ServiceController serviceController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(
          (25 / 1.w).w, 0, (25 / 1.w).w, (25 / 1.h).h),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: CustomTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.circular(20),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(
                    (20 / 1.w).w, (20 / 1.h).h, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      'Tipe Kendaraan',
                      style: CustomTheme.of(context).bodyText1.override(
                            fontFamily: 'Poppins',
                            fontSize: (24 / 1.sp).sp,
                          ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(
                    (20 / 1.w).w, (10 / 1.h).h, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      'Tipe service kendaraan yang disediakan',
                      style: CustomTheme.of(context).bodyText1.override(
                            fontFamily: 'Poppins',
                            color: Color(0xFF9E9E9E),
                            fontSize: (16 / 1.sp).sp,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(
                    0, (4 / 1.h).h, (1 / 1.w).w, 0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Obx(() {
                    return Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB((8 / 1.w).w,
                              (8 / 1.h).h, (8 / 1.w).w, (8 / 1.h).h),
                          child: Material(
                            color: Colors.transparent,
                            elevation: serviceController
                                        .serviceProfileViewController
                                        .serviceObj
                                        .value
                                        .vehicleType !=
                                    VehicleType.SEMUA.index
                                ? 8
                                : 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: GestureDetector(
                              onTap: () => serviceController
                                  .serviceProfileViewController.serviceObj
                                  .update((serviceObj) {
                                serviceObj.vehicleType =
                                    VehicleType.SEMUA.index;
                              }),
                              child: Container(
                                width: (100 / 1.w).w,
                                height: (100 / 1.h).h,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: (48 / 1.w).w,
                                      height: (48 / 1.h).h,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFF1F4F8),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.all_inclusive,
                                        color: Color(0xFF95A1AC),
                                        size: (32 / 1.sp).sp,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, (8 / 1.h).h, 0, 0),
                                      child: Text(
                                        'Semua',
                                        style: CustomTheme.of(context)
                                            .bodyText2
                                            .override(
                                              fontFamily: 'Poppins',
                                              color: CustomTheme.of(context)
                                                  .primaryText,
                                              fontSize: (14 / 1.sp).sp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB((8 / 1.w).w,
                              (8 / 1.h).h, (8 / 1.w).w, (8 / 1.h).h),
                          child: Material(
                            color: Colors.transparent,
                            elevation: serviceController
                                        .serviceProfileViewController
                                        .serviceObj
                                        .value
                                        .vehicleType !=
                                    VehicleType.MOTOR.index
                                ? 8
                                : 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: GestureDetector(
                              onTap: () => serviceController
                                  .serviceProfileViewController.serviceObj
                                  .update((serviceObj) {
                                serviceObj.vehicleType =
                                    VehicleType.MOTOR.index;
                              }),
                              child: Container(
                                width: (100 / 1.w).w,
                                height: (100 / 1.h).h,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: (48 / 1.w).w,
                                      height: (48 / 1.h).h,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFF1F4F8),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.motorcycle_outlined,
                                        color: Color(0xFF95A1AC),
                                        size: (32 / 1.sp).sp,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, (8 / 1.h).h, 0, 0),
                                      child: Text(
                                        'Motor',
                                        style: CustomTheme.of(context)
                                            .bodyText2
                                            .override(
                                              fontFamily: 'Poppins',
                                              color: CustomTheme.of(context)
                                                  .primaryText,
                                              fontSize: (14 / 1.sp).sp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB((8 / 1.w).w,
                              (8 / 1.h).h, (8 / 1.w).w, (8 / 1.h).h),
                          child: Material(
                            color: Colors.transparent,
                            elevation: serviceController
                                        .serviceProfileViewController
                                        .serviceObj
                                        .value
                                        .vehicleType !=
                                    VehicleType.MOBIL.index
                                ? 8
                                : 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: GestureDetector(
                              onTap: () => serviceController
                                  .serviceProfileViewController.serviceObj
                                  .update((serviceObj) {
                                serviceObj.vehicleType =
                                    VehicleType.MOBIL.index;
                              }),
                              child: Container(
                                width: (100 / 1.w).w,
                                height: (100 / 1.h).h,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: (48 / 1.w).w,
                                      height: (48 / 1.h).h,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFF1F4F8),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.directions_car,
                                        color: Color(0xFF95A1AC),
                                        size: (32 / 1.sp).sp,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, (8 / 1.h).h, 0, 0),
                                      child: Text(
                                        'Mobil',
                                        style: CustomTheme.of(context)
                                            .bodyText2
                                            .override(
                                              fontFamily: 'Poppins',
                                              color: CustomTheme.of(context)
                                                  .primaryText,
                                              fontSize: (14 / 1.sp).sp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
                ),
              ),
              Obx(() {
                return Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(
                      (20 / 1.w).w, (10 / 1.h).h, (20 / 1.w).w, (20 / 1.h).h),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: (serviceController.isNew.value)
                              ? () => serviceController
                                  .serviceProfileViewController
                                  .createService()
                              : () => serviceController
                                  .serviceProfileViewController
                                  .updateService(),
                          child: IntrinsicHeight(
                            child: Container(
                              width: (100 / 1.w).w,
                              decoration: BoxDecoration(
                                color: CustomTheme.of(context).primaryText,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 5),
                                    child: Text(
                                      (serviceController.isNew.value)
                                          ? 'Buat Servis'
                                          : 'Ubah Profil',
                                      style: CustomTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Poppins',
                                            color: CustomTheme.of(context)
                                                .primaryBackground,
                                            fontSize: (20 / 1.sp).sp,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class OperationalTimeView extends StatelessWidget {
  const OperationalTimeView({Key key, @required this.serviceController})
      : super(key: key);

  final ServiceController serviceController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(
          (25 / 1.w).w, (25 / 1.h).h, (25 / 1.w).w, (25 / 1.h).h),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: CustomTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(
                  (20 / 1.w).w, (20 / 1.h).h, 0, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'Waktu Operasional Servis',
                    style: CustomTheme.of(context).bodyText1.override(
                          fontFamily: 'Poppins',
                          fontSize: (24 / 1.sp).sp,
                        ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(
                  (20 / 1.w).w, (10 / 1.h).h, 0, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'Waktu operasional servis akan ditampilkan ke pengguna',
                    style: CustomTheme.of(context).bodyText1.override(
                          fontFamily: 'Poppins',
                          color: Color(0xFF9E9E9E),
                          fontSize: (16 / 1.sp).sp,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(
                  (30 / 1.w).w, (20 / 1.h).h, (30 / 1.w).w, (20 / 1.h).h),
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.18,
                decoration: BoxDecoration(
                  color: CustomTheme.of(context).secondaryBackground,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Jam Operasional',
                      style: CustomTheme.of(context).bodyText1.override(
                            fontFamily: 'Poppins',
                            fontSize: (18 / 1.sp).sp,
                          ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0, (5 / 1.h).h, 0, 0),
                      child: Obx(() {
                        return Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay(hour: 00, minute: 00),
                                ).then((value) {
                                  if (value == null) {
                                    serviceController
                                        .serviceProfileViewController.serviceObj
                                        .update((serviceObj) {
                                      serviceObj.openHour = "00:00";
                                    });
                                  } else {
                                    serviceController
                                        .serviceProfileViewController.serviceObj
                                        .update((serviceObj) {
                                      serviceObj.openHour = value.hour
                                              .toString()
                                              .padLeft(2, '0') +
                                          ":" +
                                          value.minute
                                              .toString()
                                              .padLeft(2, '0');
                                    });
                                  }
                                });
                              },
                              child: Container(
                                width: (100 / 1.w).w,
                                height: (30 / 1.h).h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    width: (1 / 1.w).w,
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      serviceController
                                          .serviceProfileViewController
                                          .serviceObj
                                          .value
                                          .openHour,
                                      style: CustomTheme.of(context).bodyText1,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  (10 / 1.w).w, 0, (10 / 1.w).w, 0),
                              child: Text(
                                'To',
                                style: CustomTheme.of(context).bodyText1,
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay(hour: 00, minute: 00),
                                ).then((value) {
                                  if (value == null) {
                                    serviceController
                                        .serviceProfileViewController.serviceObj
                                        .update((serviceObj) {
                                      serviceObj.closeHour = "00:00";
                                    });
                                  } else {
                                    serviceController
                                        .serviceProfileViewController.serviceObj
                                        .update((serviceObj) {
                                      serviceObj.closeHour = value.hour
                                              .toString()
                                              .padLeft(2, '0') +
                                          ":" +
                                          value.minute
                                              .toString()
                                              .padLeft(2, '0');
                                    });
                                  }
                                });
                              },
                              child: Container(
                                width: (100 / 1.w).w,
                                height: (30 / 1.h).h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    width: (1 / 1.w).w,
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      serviceController
                                          .serviceProfileViewController
                                          .serviceObj
                                          .value
                                          .closeHour,
                                      style: CustomTheme.of(context).bodyText1,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0, (20 / 1.h).h, 0, 0),
                      child: Text(
                        'Hari Operasional',
                        style: CustomTheme.of(context).bodyText1.override(
                              fontFamily: 'Poppins',
                              fontSize: (18 / 1.sp).sp,
                            ),
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            0, (5 / 1.h).h, 0, 0),
                        child: Obx(() {
                          return Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    (5 / 1.w).w, 0, (5 / 1.w).w, 0),
                                child: GestureDetector(
                                  onTap: () => serviceController
                                      .serviceProfileViewController
                                      .operationalServiceObjs[0]
                                      .update((operationalServiceObj) {
                                    operationalServiceObj.isOpen =
                                        !serviceController
                                            .serviceProfileViewController
                                            .operationalServiceObjs[0]
                                            .value
                                            .isOpen;
                                  }),
                                  child: Container(
                                    height: (30 / 1.h).h,
                                    decoration: BoxDecoration(
                                      color: serviceController
                                              .serviceProfileViewController
                                              .operationalServiceObjs[0]
                                              .value
                                              .isOpen
                                          ? CustomTheme.of(context).primaryText
                                          : CustomTheme.of(context)
                                              .primaryBackground,
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        width: (1 / 1.w).w,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  (5 / 1.w).w,
                                                  0,
                                                  (5 / 1.w).w,
                                                  0),
                                          child: Text(
                                            'Senin',
                                            style: CustomTheme.of(context)
                                                .bodyText1
                                                .override(
                                                    fontFamily: 'Poppins',
                                                    fontSize: (14 / 1.sp).sp,
                                                    color: serviceController
                                                            .serviceProfileViewController
                                                            .operationalServiceObjs[
                                                                0]
                                                            .value
                                                            .isOpen
                                                        ? CustomTheme.of(
                                                                context)
                                                            .primaryBackground
                                                        : CustomTheme.of(
                                                                context)
                                                            .primaryText),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    (5 / 1.w).w, 0, (5 / 1.w).w, 0),
                                child: GestureDetector(
                                  onTap: () => serviceController
                                      .serviceProfileViewController
                                      .operationalServiceObjs[1]
                                      .update((operationalServiceObj) {
                                    operationalServiceObj.isOpen =
                                        !serviceController
                                            .serviceProfileViewController
                                            .operationalServiceObjs[1]
                                            .value
                                            .isOpen;
                                  }),
                                  child: Container(
                                    height: (30 / 1.h).h,
                                    decoration: BoxDecoration(
                                      color: serviceController
                                              .serviceProfileViewController
                                              .operationalServiceObjs[1]
                                              .value
                                              .isOpen
                                          ? CustomTheme.of(context).primaryText
                                          : CustomTheme.of(context)
                                              .primaryBackground,
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        width: (1 / 1.w).w,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          (5 / 1.w).w, 0, (5 / 1.w).w, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Selasa',
                                            style: CustomTheme.of(context)
                                                .bodyText1
                                                .override(
                                                    fontFamily: 'Poppins',
                                                    fontSize: (14 / 1.sp).sp,
                                                    color: serviceController
                                                            .serviceProfileViewController
                                                            .operationalServiceObjs[
                                                                1]
                                                            .value
                                                            .isOpen
                                                        ? CustomTheme.of(
                                                                context)
                                                            .primaryBackground
                                                        : CustomTheme.of(
                                                                context)
                                                            .primaryText),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    (5 / 1.w).w, 0, (5 / 1.w).w, 0),
                                child: GestureDetector(
                                  onTap: () => serviceController
                                      .serviceProfileViewController
                                      .operationalServiceObjs[2]
                                      .update((operationalServiceObj) {
                                    operationalServiceObj.isOpen =
                                        !serviceController
                                            .serviceProfileViewController
                                            .operationalServiceObjs[2]
                                            .value
                                            .isOpen;
                                  }),
                                  child: Container(
                                    height: (30 / 1.h).h,
                                    decoration: BoxDecoration(
                                      color: serviceController
                                              .serviceProfileViewController
                                              .operationalServiceObjs[2]
                                              .value
                                              .isOpen
                                          ? CustomTheme.of(context).primaryText
                                          : CustomTheme.of(context)
                                              .primaryBackground,
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        width: (1 / 1.w).w,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          (5 / 1.w).w, 0, (5 / 1.w).w, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Rabu',
                                            style: CustomTheme.of(context)
                                                .bodyText1
                                                .override(
                                                    fontFamily: 'Poppins',
                                                    fontSize: (14 / 1.sp).sp,
                                                    color: serviceController
                                                            .serviceProfileViewController
                                                            .operationalServiceObjs[
                                                                2]
                                                            .value
                                                            .isOpen
                                                        ? CustomTheme.of(
                                                                context)
                                                            .primaryBackground
                                                        : CustomTheme.of(
                                                                context)
                                                            .primaryText),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    (5 / 1.w).w, 0, (5 / 1.w).w, 0),
                                child: GestureDetector(
                                  onTap: () => serviceController
                                      .serviceProfileViewController
                                      .operationalServiceObjs[3]
                                      .update((operationalServiceObj) {
                                    operationalServiceObj.isOpen =
                                        !serviceController
                                            .serviceProfileViewController
                                            .operationalServiceObjs[3]
                                            .value
                                            .isOpen;
                                  }),
                                  child: Container(
                                    height: (30 / 1.h).h,
                                    decoration: BoxDecoration(
                                      color: serviceController
                                              .serviceProfileViewController
                                              .operationalServiceObjs[3]
                                              .value
                                              .isOpen
                                          ? CustomTheme.of(context).primaryText
                                          : CustomTheme.of(context)
                                              .primaryBackground,
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        width: (1 / 1.w).w,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          (5 / 1.w).w, 0, (5 / 1.w).w, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Kamis',
                                            style: CustomTheme.of(context)
                                                .bodyText1
                                                .override(
                                                    fontFamily: 'Poppins',
                                                    fontSize: (14 / 1.sp).sp,
                                                    color: serviceController
                                                            .serviceProfileViewController
                                                            .operationalServiceObjs[
                                                                3]
                                                            .value
                                                            .isOpen
                                                        ? CustomTheme.of(
                                                                context)
                                                            .primaryBackground
                                                        : CustomTheme.of(
                                                                context)
                                                            .primaryText),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    (5 / 1.w).w, 0, (5 / 1.w).w, 0),
                                child: GestureDetector(
                                  onTap: () => serviceController
                                      .serviceProfileViewController
                                      .operationalServiceObjs[4]
                                      .update((operationalServiceObj) {
                                    operationalServiceObj.isOpen =
                                        !serviceController
                                            .serviceProfileViewController
                                            .operationalServiceObjs[4]
                                            .value
                                            .isOpen;
                                  }),
                                  child: Container(
                                    height: (30 / 1.h).h,
                                    decoration: BoxDecoration(
                                      color: serviceController
                                              .serviceProfileViewController
                                              .operationalServiceObjs[4]
                                              .value
                                              .isOpen
                                          ? CustomTheme.of(context).primaryText
                                          : CustomTheme.of(context)
                                              .primaryBackground,
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        width: (1 / 1.w).w,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          (5 / 1.w).w, 0, (5 / 1.w).w, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Jumat',
                                            style: CustomTheme.of(context)
                                                .bodyText1
                                                .override(
                                                    fontFamily: 'Poppins',
                                                    fontSize: (14 / 1.sp).sp,
                                                    color: serviceController
                                                            .serviceProfileViewController
                                                            .operationalServiceObjs[
                                                                4]
                                                            .value
                                                            .isOpen
                                                        ? CustomTheme.of(
                                                                context)
                                                            .primaryBackground
                                                        : CustomTheme.of(
                                                                context)
                                                            .primaryText),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    (5 / 1.w).w, 0, (5 / 1.w).w, 0),
                                child: GestureDetector(
                                  onTap: () => serviceController
                                      .serviceProfileViewController
                                      .operationalServiceObjs[5]
                                      .update((operationalServiceObj) {
                                    operationalServiceObj.isOpen =
                                        !serviceController
                                            .serviceProfileViewController
                                            .operationalServiceObjs[5]
                                            .value
                                            .isOpen;
                                  }),
                                  child: Container(
                                    height: (30 / 1.h).h,
                                    decoration: BoxDecoration(
                                      color: serviceController
                                              .serviceProfileViewController
                                              .operationalServiceObjs[5]
                                              .value
                                              .isOpen
                                          ? CustomTheme.of(context).primaryText
                                          : CustomTheme.of(context)
                                              .primaryBackground,
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        width: (1 / 1.w).w,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          (5 / 1.w).w, 0, (5 / 1.w).w, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Sabtu',
                                            style: CustomTheme.of(context)
                                                .bodyText1
                                                .override(
                                                    fontFamily: 'Poppins',
                                                    fontSize: (14 / 1.sp).sp,
                                                    color: serviceController
                                                            .serviceProfileViewController
                                                            .operationalServiceObjs[
                                                                5]
                                                            .value
                                                            .isOpen
                                                        ? CustomTheme.of(
                                                                context)
                                                            .primaryBackground
                                                        : CustomTheme.of(
                                                                context)
                                                            .primaryText),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    (5 / 1.w).w, 0, (5 / 1.w).w, 0),
                                child: GestureDetector(
                                  onTap: () => serviceController
                                      .serviceProfileViewController
                                      .operationalServiceObjs[6]
                                      .update((operationalServiceObj) {
                                    operationalServiceObj.isOpen =
                                        !serviceController
                                            .serviceProfileViewController
                                            .operationalServiceObjs[6]
                                            .value
                                            .isOpen;
                                  }),
                                  child: Container(
                                    height: (30 / 1.h).h,
                                    decoration: BoxDecoration(
                                      color: serviceController
                                              .serviceProfileViewController
                                              .operationalServiceObjs[6]
                                              .value
                                              .isOpen
                                          ? CustomTheme.of(context).primaryText
                                          : CustomTheme.of(context)
                                              .primaryBackground,
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        width: (1 / 1.w).w,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          (5 / 1.w).w, 0, (5 / 1.w).w, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Minggu',
                                            style: CustomTheme.of(context)
                                                .bodyText1
                                                .override(
                                                    fontFamily: 'Poppins',
                                                    fontSize: (14 / 1.sp).sp,
                                                    color: serviceController
                                                            .serviceProfileViewController
                                                            .operationalServiceObjs[
                                                                6]
                                                            .value
                                                            .isOpen
                                                        ? CustomTheme.of(
                                                                context)
                                                            .primaryBackground
                                                        : CustomTheme.of(
                                                                context)
                                                            .primaryText),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ServiceInformationView extends StatelessWidget {
  const ServiceInformationView({
    Key key,
    @required this.serviceController,
  }) : super(key: key);

  final ServiceController serviceController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: IntrinsicHeight(
        child: Container(
          width: (100 / 1.w).w,
          decoration: BoxDecoration(),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(
                (25 / 1.w).w, (25 / 1.h).h, (25 / 1.w).w, (25 / 1.w).w),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: CustomTheme.of(context).secondaryBackground,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(
                        (20 / 1.w).w, (20 / 1.h).h, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'Informasi Servis',
                          style: CustomTheme.of(context).bodyText1.override(
                                fontFamily: 'Poppins',
                                fontSize: (24 / 1.sp).sp,
                              ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(
                        (20 / 1.w).w, (10 / 1.h).h, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'Informasi servis akan ditampilkan ke pengguna',
                          style: CustomTheme.of(context).bodyText1.override(
                                fontFamily: 'Poppins',
                                color: Color(0xFF9E9E9E),
                                fontSize: (16 / 1.sp).sp,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(
                        (30 / 1.w).w, (20 / 1.h).h, (30 / 1.w).w, (20 / 1.h).h),
                    child: IntrinsicHeight(
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: CustomTheme.of(context).secondaryBackground,
                        ),
                        child: Form(
                          key: serviceController
                              .serviceProfileViewController.formKey,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0, (10 / 1.h).h, 0, (10 / 1.h).h),
                                child: TextFormField(
                                  controller: serviceController
                                      .serviceProfileViewController
                                      .serviceNameFieldController,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: 'Nama Service',
                                    hintText:
                                        'Masukan nama service anda disini',
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            CustomTheme.of(context).primaryText,
                                        width: (2 / 1.w).w,
                                      ),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(4.0),
                                        topRight: Radius.circular(4.0),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            CustomTheme.of(context).primaryText,
                                        width: (2 / 1.w).w,
                                      ),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(4.0),
                                        topRight: Radius.circular(4.0),
                                      ),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            CustomTheme.of(context).alternate,
                                        width: (2 / 1.w).w,
                                      ),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(4.0),
                                        topRight: Radius.circular(4.0),
                                      ),
                                    ),
                                    contentPadding:
                                        EdgeInsetsDirectional.fromSTEB(
                                            (10 / 1.w).w,
                                            (5 / 1.h).h,
                                            0,
                                            (5 / 1.w).w),
                                  ),
                                  style: CustomTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Poppins',
                                        fontSize: (16 / 1.sp).sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                  keyboardType: TextInputType.name,
                                  validator: (val) {
                                    if (val.isEmpty) {
                                      return "Nama servis harus diisi";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0, (10 / 1.h).h, 0, (10 / 1.h).h),
                                child: TextFormField(
                                  controller: serviceController
                                      .serviceProfileViewController
                                      .serviceAddressFieldController,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: 'Lokasi Service',
                                    hintText:
                                        'Masukan lokasi service anda disini',
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            CustomTheme.of(context).primaryText,
                                        width: (2 / 1.w).w,
                                      ),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(4.0),
                                        topRight: Radius.circular(4.0),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            CustomTheme.of(context).primaryText,
                                        width: (2 / 1.w).w,
                                      ),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(4.0),
                                        topRight: Radius.circular(4.0),
                                      ),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            CustomTheme.of(context).alternate,
                                        width: (2 / 1.w).w,
                                      ),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(4.0),
                                        topRight: Radius.circular(4.0),
                                      ),
                                    ),
                                    contentPadding:
                                        EdgeInsetsDirectional.fromSTEB(
                                            (10 / 1.w).w,
                                            (5 / 1.h).h,
                                            0,
                                            (5 / 1.h).h),
                                  ),
                                  style: CustomTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Poppins',
                                        fontSize: (16 / 1.sp).sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                  keyboardType: TextInputType.text,
                                  validator: (val) {
                                    if (val.isEmpty) {
                                      return "Lokasi servis harus diisi";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0, (10 / 1.h).h, 0, (10 / 1.h).h),
                                child: TextFormField(
                                  controller: serviceController
                                      .serviceProfileViewController
                                      .serviceDescriptionFieldController,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: 'Deskripsi Service',
                                    hintText:
                                        'Masukan deskripsi service mu disini',
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            CustomTheme.of(context).primaryText,
                                        width: (2 / 1.w).w,
                                      ),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(4.0),
                                        topRight: Radius.circular(4.0),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            CustomTheme.of(context).primaryText,
                                        width: (2 / 1.w).w,
                                      ),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(4.0),
                                        topRight: Radius.circular(4.0),
                                      ),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            CustomTheme.of(context).alternate,
                                        width: (2 / 1.w).w,
                                      ),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(4.0),
                                        topRight: Radius.circular(4.0),
                                      ),
                                    ),
                                    contentPadding:
                                        EdgeInsetsDirectional.fromSTEB(
                                            (10 / 1.w).w,
                                            (5 / 1.h).h,
                                            0,
                                            (5 / 1.w).w),
                                  ),
                                  keyboardType: TextInputType.text,
                                  style: CustomTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Poppins',
                                        fontSize: (16 / 1.sp).sp,
                                      ),
                                  maxLines: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
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
