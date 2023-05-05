import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:skripskuy_web/app/utils/custom_button.dart';

import '../../../utils/custom_theme.dart';
import '../controllers/order_history_detail_controller.dart';

class OrderHistoryDetailView extends GetView<OrderHistoryDetailController> {
  final addServiceDetialController = Get.put(OrderHistoryDetailController());

  @override
  Widget build(BuildContext context) {
    return addServiceDetialController.obx((orderHistoryJson) {
      return Scaffold(
        key: addServiceDetialController.scaffoldKey,
        backgroundColor: CustomTheme.of(context).primaryBackground,
        body: SafeArea(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(
                  (20 / 1.w).w, (20 / 1.h).h, (20 / 1.w).w, (20 / 1.h).h),
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 1,
                decoration: BoxDecoration(
                  color: CustomTheme.of(context).lineColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(
                      0, (20 / 1.h).h, 0, (20 / 1.h).h),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              (20 / 1.w).w, 0, (20 / 1.w).w, 0),
                          child: IntrinsicHeight(
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(0),
                                  bottomRight: Radius.circular(0),
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    flex: 100,
                                    child: Container(
                                      width: (100 / 1.w).w,
                                      decoration: BoxDecoration(),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        (25 / 1.w).w, 0, 0, 0),
                                                child: Text(
                                                  'Resi',
                                                  style: CustomTheme.of(context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily: 'Poppins',
                                                        fontSize:
                                                            (36 / 1.sp).sp,
                                                      ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    (20 / 1.w).w,
                                                    0,
                                                    (20 / 1.w).w,
                                                    0),
                                            child: Container(
                                              width: double.infinity,
                                              height: (5 / 1.h).h,
                                              decoration: BoxDecoration(
                                                color: CustomTheme.of(context)
                                                    .primaryText,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB((30 / 1.w).w,
                                                          (10 / 1.h).h, 0, 0),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        orderHistoryJson[
                                                                    'service_name']
                                                                ?.toString() ??
                                                            '[Tidak didefinisikan]',
                                                        style: CustomTheme.of(
                                                                context)
                                                            .bodyText1
                                                            .override(
                                                              fontFamily:
                                                                  'Poppins',
                                                              fontSize:
                                                                  (20 / 1.sp)
                                                                      .sp,
                                                            ),
                                                      ),
                                                      Text(
                                                        orderHistoryJson[
                                                                    'service_address']
                                                                ?.toString() ??
                                                            '[Tidak didefinisikan]',
                                                        style: CustomTheme.of(
                                                                context)
                                                            .bodyText1
                                                            .override(
                                                              fontFamily:
                                                                  'Poppins',
                                                              fontSize:
                                                                  (20 / 1.sp)
                                                                      .sp,
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
                                  ),
                                  Expanded(
                                    flex: 40,
                                    child: Container(
                                      width: 100,
                                      decoration: BoxDecoration(
                                        color: CustomTheme.of(context)
                                            .secondaryBackground,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            (10 / 1.w).w,
                                            (10 / 1.h).h,
                                            (10 / 1.w).w,
                                            (10 / 1.h).h),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Nomor Order : ',
                                                  style: CustomTheme.of(context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily: 'Poppins',
                                                        fontSize:
                                                            (18 / 1.sp).sp,
                                                      ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB((20 / 1.w).w, 0,
                                                          0, 0),
                                                  child: Text(
                                                    orderHistoryJson['id']
                                                            ?.toString() ??
                                                        '[Tidak didefinisikan]',
                                                    style: CustomTheme.of(
                                                            context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily: 'Poppins',
                                                          fontSize:
                                                              (18 / 1.sp).sp,
                                                        ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0, (10 / 1.h).h, 0, 0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Expanded(
                                                    child: Container(
                                                      width: (100 / 1.w).w,
                                                      height: (100 / 1.h).h,
                                                      decoration:
                                                          BoxDecoration(),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0,
                                                                    (2 / 1.h).h,
                                                                    0,
                                                                    0),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            Text(
                                                              orderHistoryJson[
                                                                          'date']
                                                                      ?.toString() ??
                                                                  '[Tidak didefinisikan]',
                                                              style: CustomTheme
                                                                      .of(context)
                                                                  .bodyText1,
                                                            ),
                                                            Text(
                                                              orderHistoryJson[
                                                                          'service_package_name']
                                                                      ?.toString() ??
                                                                  '[Tidak didefinisikan]',
                                                              style: CustomTheme
                                                                      .of(context)
                                                                  .bodyText1,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                      width: (100 / 1.w).w,
                                                      height: (100 / 1.h).h,
                                                      decoration:
                                                          BoxDecoration(),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          Text(
                                                            orderHistoryJson[
                                                                        'plate_number']
                                                                    ?.toString() ??
                                                                '[Tidak didefinisikan]',
                                                            style:
                                                                CustomTheme.of(
                                                                        context)
                                                                    .bodyText1,
                                                          ),
                                                          Text(
                                                            orderHistoryJson[
                                                                        'user_full_name']
                                                                    ?.toString() ??
                                                                '[Tidak didefinisikan]',
                                                            style:
                                                                CustomTheme.of(
                                                                        context)
                                                                    .bodyText1,
                                                          ),
                                                        ],
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
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              (20 / 1.w).w, 0, (20 / 1.w).w, 0),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                                topLeft: Radius.circular(0),
                                topRight: Radius.circular(0),
                              ),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, (10 / 1.h).h, 0, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          width: double.infinity,
                                          height: (50 / 1.h).h,
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
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    (50 / 1.w).w, 0, 0, 0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB((10 / 1.w).w, 0,
                                                          (10 / 1.w).w, 0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        width: (120 / 1.w).w,
                                                        decoration:
                                                            BoxDecoration(),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: [
                                                            Text(
                                                              'No',
                                                              style: CustomTheme
                                                                      .of(context)
                                                                  .bodyText1,
                                                            ),
                                                            Text(
                                                              'Qty',
                                                              style: CustomTheme
                                                                      .of(context)
                                                                  .bodyText1,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    (10 / 1.w)
                                                                        .w,
                                                                    0,
                                                                    0,
                                                                    0),
                                                        child: Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.54,
                                                          decoration:
                                                              BoxDecoration(),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Text(
                                                                'Description',
                                                                style: CustomTheme.of(
                                                                        context)
                                                                    .bodyText1,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Container(
                                                          width: (100 / 1.w).w,
                                                          decoration:
                                                              BoxDecoration(),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                'Price',
                                                                style: CustomTheme.of(
                                                                        context)
                                                                    .bodyText1,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Container(
                                                          width: (100 / 1.w).w,
                                                          decoration:
                                                              BoxDecoration(),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                'Sub-Total',
                                                                style: CustomTheme.of(
                                                                        context)
                                                                    .bodyText1,
                                                              ),
                                                            ],
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
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  height:
                                      MediaQuery.of(context).size.height * 0.6,
                                  decoration: BoxDecoration(),
                                  child: Form(
                                      key: addServiceDetialController.formKey,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      child: Obx(() {
                                        return ListView.builder(
                                            padding: EdgeInsets.zero,
                                            primary: false,
                                            scrollDirection: Axis.vertical,
                                            itemCount: addServiceDetialController
                                                    .listTextEditingController
                                                    ?.length ??
                                                0,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return OrderHistoryDetailSubView(
                                                  index: index);
                                            });
                                      })),
                                ),
                              ],
                            ),
                          ),
                        ),
                        (addServiceDetialController.isNew.value)
                            ? Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    (40 / 1.w).w, 0, (40 / 1.w).w, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    CustomButton(
                                      tag: 'sendReceiptBtn',
                                      onPressed: () =>
                                          addServiceDetialController
                                              .addOrderDetail(),
                                      text: 'Kirim',
                                      options: CustomButtonOptions(
                                        width: (130 / 1.w).w,
                                        height: (40 / 1.h).h,
                                        color:
                                            CustomTheme.of(context).primaryText,
                                        textStyle: CustomTheme.of(context)
                                            .subtitle2
                                            .override(
                                              fontFamily: 'Poppins',
                                              color: Colors.white,
                                            ),
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                          width: (1 / 1.w).w,
                                        ),
                                        borderRadius: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Container()
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}

class OrderHistoryDetailSubView extends StatelessWidget {
  OrderHistoryDetailSubView({
    Key key,
    @required this.index,
  }) : super(key: key);

  final addServiceDetailController = Get.find<OrderHistoryDetailController>();

  int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: (50 / 1.h).h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0),
          bottomRight: Radius.circular(0),
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: (60 / 1.w).w,
            decoration: BoxDecoration(),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(
                      (5 / 1.w).w, (5 / 1.h).h, (5 / 1.w).w, (5 / 1.h).h),
                  child: GestureDetector(
                    onTap: (addServiceDetailController.isNew == true)
                        ? (index ==
                                (addServiceDetailController
                                        .listTextEditingController.length -
                                    1)
                            ? () => addServiceDetailController.addList()
                            : () =>
                                addServiceDetailController.removeList(index))
                        : null,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFEEEEEE),
                        borderRadius: BorderRadius.circular(25),
                        shape: BoxShape.rectangle,
                        border: Border.all(
                          width: (2 / 1.w).w,
                        ),
                      ),
                      child: (addServiceDetailController.isNew == true)
                          ? ((index ==
                                  (addServiceDetailController
                                          .listTextEditingController.length -
                                      1))
                              ? Icon(
                                  Icons.add,
                                  color: Colors.black,
                                  size: (24 / 1.sp).sp,
                                )
                              : Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 2),
                                  child: FaIcon(
                                    FontAwesomeIcons.minus,
                                    color: Colors.black,
                                    size: (24 / 1.sp).sp,
                                  ),
                                ))
                          : FaIcon(
                              FontAwesomeIcons.ban,
                              color: Colors.black,
                              size: (24 / 1.sp).sp,
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: (120 / 1.w).w,
            decoration: BoxDecoration(),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(
                        (5 / 1.w).w, 0, (5 / 1.w).w, 0),
                    child: TextFormField(
                      initialValue: index.toString(),
                      enabled: false,
                      autofocus: false,
                      obscureText: false,
                      decoration: InputDecoration(
                        isDense: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: CustomTheme.of(context).primaryText,
                            width: (1 / 1.w).w,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: CustomTheme.of(context).primaryText,
                            width: (1 / 1.w).w,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: CustomTheme.of(context).alternate,
                            width: (1 / 1.w).w,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        contentPadding: EdgeInsetsDirectional.fromSTEB(
                            (10 / 1.w).w,
                            (10 / 1.h).h,
                            (10 / 1.w).w,
                            (10 / 1.h).h),
                      ),
                      style: CustomTheme.of(context).bodyText1,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(
                        (5 / 1.w).w, 0, (5 / 1.w).w, 0),
                    child: TextFormField(
                      controller: addServiceDetailController
                          .listTextEditingController[index]['quantity'],
                      onChanged: (_) =>
                          addServiceDetailController.calculation(index),
                      enabled:
                          addServiceDetailController.isNew.value ? true : false,
                      autofocus: false,
                      obscureText: false,
                      decoration: InputDecoration(
                        isDense: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: CustomTheme.of(context).primaryText,
                            width: (1 / 1.w).w,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: CustomTheme.of(context).primaryText,
                            width: (1 / 1.w).w,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: CustomTheme.of(context).alternate,
                            width: (1 / 1.w).w,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        contentPadding: EdgeInsetsDirectional.fromSTEB(
                            (10 / 1.w).w,
                            (10 / 1.h).h,
                            (10 / 1.w).w,
                            (10 / 1.h).h),
                      ),
                      style: CustomTheme.of(context).bodyText1,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "";
                        } else if (!value.isNumericOnly) {
                          return "";
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding:
                EdgeInsetsDirectional.fromSTEB((5 / 1.w).w, 0, (5 / 1.w).w, 0),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.55,
              decoration: BoxDecoration(),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: addServiceDetailController
                          .listTextEditingController[index]['description'],
                      enabled:
                          addServiceDetailController.isNew.value ? true : false,
                      autofocus: false,
                      obscureText: false,
                      decoration: InputDecoration(
                        isDense: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: CustomTheme.of(context).primaryText,
                            width: (1 / 1.w).w,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: CustomTheme.of(context).primaryText,
                            width: (1 / 1.w).w,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: CustomTheme.of(context).alternate,
                            width: (1 / 1.w).w,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        contentPadding: EdgeInsetsDirectional.fromSTEB(
                            (10 / 1.w).w,
                            (10 / 1.h).h,
                            (10 / 1.w).w,
                            (10 / 1.h).h),
                      ),
                      style: CustomTheme.of(context).bodyText1,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Deskripsi harus diisi";
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: (100 / 1.w).w,
              decoration: BoxDecoration(),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          (5 / 1.w).w, 0, (5 / 1.w).w, 0),
                      child: TextFormField(
                        controller: addServiceDetailController
                            .listTextEditingController[index]['price'],
                        onChanged: (val) =>
                            addServiceDetailController.calculation(index),
                        enabled: addServiceDetailController.isNew.value
                            ? true
                            : false,
                        autofocus: false,
                        obscureText: false,
                        decoration: InputDecoration(
                          isDense: true,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: CustomTheme.of(context).primaryText,
                              width: (1 / 1.w).w,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: CustomTheme.of(context).primaryText,
                              width: (1 / 1.w).w,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          contentPadding: EdgeInsetsDirectional.fromSTEB(
                              (10 / 1.w).w,
                              (10 / 1.h).h,
                              (10 / 1.w).w,
                              (10 / 1.h).h),
                        ),
                        style: CustomTheme.of(context).bodyText1,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: (100 / 1.w).w,
              decoration: BoxDecoration(),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          (5 / 1.w).w, 0, (5 / 1.w).w, 0),
                      child: TextFormField(
                        controller: addServiceDetailController
                            .listTextEditingController[index]['subTotal'],
                        enabled: false,
                        autofocus: false,
                        obscureText: false,
                        decoration: InputDecoration(
                          isDense: true,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: CustomTheme.of(context).primaryText,
                              width: (1 / 1.w).w,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: CustomTheme.of(context).primaryText,
                              width: (1 / 1.w).w,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          contentPadding: EdgeInsetsDirectional.fromSTEB(
                              (10 / 1.w).w,
                              (10 / 1.h).h,
                              (10 / 1.w).w,
                              (10 / 1.h).h),
                        ),
                        style: CustomTheme.of(context).bodyText1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
