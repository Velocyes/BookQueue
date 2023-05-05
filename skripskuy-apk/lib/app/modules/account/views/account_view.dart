import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../utils/custom_button.dart';
import '../../../utils/custom_theme.dart';
import '../controllers/account_controller.dart';

class AccountView extends StatelessWidget {
  final accountController = Get.put(AccountController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: accountController.scaffoldKey,
      backgroundColor: CustomTheme.of(context).primaryBackground,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(
              (20 / 1.w).w, (20 / 1.h).h, (20 / 1.w).w, (20 / 1.h).h),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xFFE0E3E7),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(
                  (20 / 1.w).w, (20 / 1.h).h, (20 / 1.w).w, (20 / 1.h).h),
              child: RefreshIndicator(
                onRefresh: () => accountController.initProfile(),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.5,
                        decoration: BoxDecoration(
                          color: Color(0xFFEEEEEE),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.93,
                              height: double.infinity,
                              decoration: BoxDecoration(
                                color:
                                    CustomTheme.of(context).secondaryBackground,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    (20 / 1.w).w,
                                    (20 / 1.h).h,
                                    (20 / 1.w).w,
                                    (20 / 1.h).h),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          (20 / 1.w).w, 0, (20 / 1.w).w, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Text(
                                            'Profil',
                                            style: CustomTheme.of(context)
                                                .bodyText1
                                                .override(
                                                  fontFamily: 'Poppins',
                                                  fontSize: (28 / 1.sp).sp,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            (20 / 1.w).w, 0, (20 / 1.w).w, 0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: (500 / 1.w).w,
                                              decoration: BoxDecoration(
                                                color: CustomTheme.of(context)
                                                    .secondaryBackground,
                                              ),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0, (20 / 1.h).h, 0, 0),
                                                child: Form(
                                                  key: accountController
                                                      .profileFormKey,
                                                  autovalidateMode:
                                                      AutovalidateMode
                                                          .onUserInteraction,
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0,
                                                                    (10 / 1.h)
                                                                        .h,
                                                                    0,
                                                                    (10 / 1.h)
                                                                        .h),
                                                        child: TextFormField(
                                                          controller:
                                                              accountController
                                                                  .fullNameFieldController,
                                                          obscureText: false,
                                                          decoration:
                                                              InputDecoration(
                                                            labelText:
                                                                'Nama Lengkap',
                                                            hintText:
                                                                'Masukan nama lengkap anda disini',
                                                            enabledBorder:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                color: CustomTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                                width:
                                                                    (2 / 1.w).w,
                                                              ),
                                                              borderRadius:
                                                                  const BorderRadius
                                                                      .only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        4.0),
                                                                topRight: Radius
                                                                    .circular(
                                                                        4.0),
                                                              ),
                                                            ),
                                                            focusedBorder:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                color: CustomTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                                width:
                                                                    (2 / 1.w).w,
                                                              ),
                                                              borderRadius:
                                                                  const BorderRadius
                                                                      .only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        4.0),
                                                                topRight: Radius
                                                                    .circular(
                                                                        4.0),
                                                              ),
                                                            ),
                                                            errorBorder:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                color: CustomTheme.of(
                                                                        context)
                                                                    .alternate,
                                                                width:
                                                                    (2 / 1.w).w,
                                                              ),
                                                              borderRadius:
                                                                  const BorderRadius
                                                                      .only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        4.0),
                                                                topRight: Radius
                                                                    .circular(
                                                                        4.0),
                                                              ),
                                                            ),
                                                            contentPadding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        (10 / 1.w)
                                                                            .w,
                                                                        (5 / 1.h)
                                                                            .h,
                                                                        0,
                                                                        (5 / 1.h)
                                                                            .h),
                                                          ),
                                                          style: CustomTheme.of(
                                                                  context)
                                                              .bodyText1
                                                              .override(
                                                                fontFamily:
                                                                    'Poppins',
                                                                fontSize:
                                                                    (16 / 1.sp)
                                                                        .sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                          keyboardType:
                                                              TextInputType
                                                                  .name,
                                                          validator: (value) {
                                                            if (value.isEmpty) {
                                                              return "Nama lengkap harus diisi";
                                                            }
                                                            return null;
                                                          },
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0,
                                                                    (10 / 1.h)
                                                                        .h,
                                                                    0,
                                                                    (10 / 1.h)
                                                                        .h),
                                                        child: TextFormField(
                                                          controller:
                                                              accountController
                                                                  .phoneNumberFieldController,
                                                          obscureText: false,
                                                          decoration:
                                                              InputDecoration(
                                                            labelText:
                                                                'Nomor Telepon',
                                                            hintText:
                                                                'Masukan nomor telepon anda disini',
                                                            enabledBorder:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                color: CustomTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                                width:
                                                                    (2 / 1.w).w,
                                                              ),
                                                              borderRadius:
                                                                  const BorderRadius
                                                                      .only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        4.0),
                                                                topRight: Radius
                                                                    .circular(
                                                                        4.0),
                                                              ),
                                                            ),
                                                            focusedBorder:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                color: CustomTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                                width:
                                                                    (2 / 1.w).w,
                                                              ),
                                                              borderRadius:
                                                                  const BorderRadius
                                                                      .only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        4.0),
                                                                topRight: Radius
                                                                    .circular(
                                                                        4.0),
                                                              ),
                                                            ),
                                                            errorBorder:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                color: CustomTheme.of(
                                                                        context)
                                                                    .alternate,
                                                                width:
                                                                    (2 / 1.w).w,
                                                              ),
                                                              borderRadius:
                                                                  const BorderRadius
                                                                      .only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        4.0),
                                                                topRight: Radius
                                                                    .circular(
                                                                        4.0),
                                                              ),
                                                            ),
                                                            contentPadding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        (10 / 1.w)
                                                                            .w,
                                                                        (5 / 1.h)
                                                                            .h,
                                                                        0,
                                                                        (5 / 1.h)
                                                                            .h),
                                                          ),
                                                          style: CustomTheme.of(
                                                                  context)
                                                              .bodyText1
                                                              .override(
                                                                fontFamily:
                                                                    'Poppins',
                                                                fontSize:
                                                                    (16 / 1.sp)
                                                                        .sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                          keyboardType:
                                                              TextInputType
                                                                  .emailAddress,
                                                          validator: (value) {
                                                            if (value.isEmpty) {
                                                              return "Nomor telepon harus diisi";
                                                            } else if (!value
                                                                    .isNumericOnly ||
                                                                value.length !=
                                                                    12) {
                                                              return "Harap isi nomor telepon dengan format yang benar";
                                                            }
                                                            return null;
                                                          },
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0,
                                                                    (10 / 1.h)
                                                                        .h,
                                                                    0,
                                                                    (10 / 1.h)
                                                                        .h),
                                                        child: TextFormField(
                                                          controller:
                                                              accountController
                                                                  .emailFieldController,
                                                          enabled: false,
                                                          obscureText: false,
                                                          decoration:
                                                              InputDecoration(
                                                            labelText: 'Email',
                                                            hintText:
                                                                'Masukan email anda disini',
                                                            enabledBorder:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                color: CustomTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                                width:
                                                                    (2 / 1.w).w,
                                                              ),
                                                              borderRadius:
                                                                  const BorderRadius
                                                                      .only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        4.0),
                                                                topRight: Radius
                                                                    .circular(
                                                                        4.0),
                                                              ),
                                                            ),
                                                            focusedBorder:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                color: CustomTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                                width:
                                                                    (2 / 1.w).w,
                                                              ),
                                                              borderRadius:
                                                                  const BorderRadius
                                                                      .only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        4.0),
                                                                topRight: Radius
                                                                    .circular(
                                                                        4.0),
                                                              ),
                                                            ),
                                                            errorBorder:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                color: CustomTheme.of(
                                                                        context)
                                                                    .alternate,
                                                                width:
                                                                    (0.5.w).w,
                                                              ),
                                                              borderRadius:
                                                                  const BorderRadius
                                                                      .only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        4.0),
                                                                topRight: Radius
                                                                    .circular(
                                                                        4.0),
                                                              ),
                                                            ),
                                                            contentPadding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        (10 / 1.w)
                                                                            .w,
                                                                        (5 / 1.h)
                                                                            .h,
                                                                        0,
                                                                        (5 / 1.h)
                                                                            .h),
                                                          ),
                                                          style: CustomTheme.of(
                                                                  context)
                                                              .bodyText1
                                                              .override(
                                                                fontFamily:
                                                                    'Poppins',
                                                                fontSize:
                                                                    (16 / 1.sp)
                                                                        .sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                          keyboardType:
                                                              TextInputType
                                                                  .emailAddress,
                                                          validator: (value) {
                                                            if (value.isEmpty) {
                                                              return "Email harus diisi";
                                                            } else if (!value
                                                                .isEmail) {
                                                              return "Harap isi email dengan format yang benar";
                                                            }
                                                            return null;
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0, (20 / 1.h).h, 0, 0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            0, 0.05),
                                                    child: CustomButton(
                                                      tag: 'updateProfileBtn',
                                                      onPressed: () =>
                                                          accountController
                                                              .updateProfile(),
                                                      text: 'Simpan',
                                                      options:
                                                          CustomButtonOptions(
                                                        width: (150 / 1.w).w,
                                                        height: (40 / 1.h).h,
                                                        color: CustomTheme.of(
                                                                context)
                                                            .primaryText,
                                                        textStyle: CustomTheme
                                                                .of(context)
                                                            .subtitle2
                                                            .override(
                                                              fontFamily:
                                                                  'Poppins',
                                                              color:
                                                                  Colors.white,
                                                              fontSize:
                                                                  (16 / 1.sp)
                                                                      .sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                        elevation: 2,
                                                        borderSide: BorderSide(
                                                          color: Colors
                                                              .transparent,
                                                          width: (1 / 1.w).w,
                                                        ),
                                                        borderRadius: 8,
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
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            (15 / 1.w), (10 / 1.h), (15 / 1.w), (10 / 1.h)),
                        child: Container(
                          width: double.infinity,
                          height: (2 / 1.h).h,
                          decoration: BoxDecoration(
                            color: CustomTheme.of(context).primaryText,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.5,
                        decoration: BoxDecoration(
                          color: Color(0xFFEEEEEE),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.93,
                              height: double.infinity,
                              decoration: BoxDecoration(
                                color:
                                    CustomTheme.of(context).secondaryBackground,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    (20 / 1.w).w,
                                    (20 / 1.h).h,
                                    (20 / 1.w).w,
                                    (20 / 1.h).h),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Text(
                                          'Password',
                                          style: CustomTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: 'Poppins',
                                                fontSize: (24 / 1.sp).sp,
                                              ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, (10 / 1.h).h, 0, 0),
                                      child: Form(
                                        key: accountController.passwordFormKey,
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                (20 / 1.w).w,
                                                                0,
                                                                0,
                                                                0),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Text(
                                                          'Password Lama',
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
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                (40 / 1.w).w,
                                                                0,
                                                                (40 / 1.w).w,
                                                                0),
                                                    child: Container(
                                                      width: double.infinity,
                                                      decoration:
                                                          BoxDecoration(),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0,
                                                                    (5 / 1.h).h,
                                                                    0,
                                                                    0),
                                                        child: Obx(() {
                                                          return TextFormField(
                                                            controller:
                                                                accountController
                                                                    .oldPasswordFieldController,
                                                            autofocus: false,
                                                            obscureText:
                                                                !accountController
                                                                    .passwordVisibility
                                                                    .value,
                                                            decoration:
                                                                InputDecoration(
                                                              isDense: true,
                                                              enabledBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: CustomTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                  width:
                                                                      (1 / 1.w)
                                                                          .w,
                                                                ),
                                                                borderRadius:
                                                                    const BorderRadius
                                                                        .only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          4.0),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          4.0),
                                                                ),
                                                              ),
                                                              focusedBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: CustomTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                  width:
                                                                      (1 / 1.w)
                                                                          .w,
                                                                ),
                                                                borderRadius:
                                                                    const BorderRadius
                                                                        .only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          4.0),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          4.0),
                                                                ),
                                                              ),
                                                              errorBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: CustomTheme.of(
                                                                          context)
                                                                      .alternate,
                                                                  width:
                                                                      (2 / 1.w)
                                                                          .w,
                                                                ),
                                                                borderRadius:
                                                                    const BorderRadius
                                                                        .only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          4.0),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          4.0),
                                                                ),
                                                              ),
                                                              suffixIcon:
                                                                  InkWell(
                                                                onTap: () =>
                                                                    accountController
                                                                        .passwordVisibility
                                                                        .toggle(),
                                                                child: Icon(
                                                                  accountController
                                                                          .passwordVisibility
                                                                          .value
                                                                      ? Icons
                                                                          .visibility_outlined
                                                                      : Icons
                                                                          .visibility_off_outlined,
                                                                  color: Color(
                                                                      0xFF757575),
                                                                  size: (22 /
                                                                          1.sp)
                                                                      .sp,
                                                                ),
                                                              ),
                                                            ),
                                                            style:
                                                                CustomTheme.of(
                                                                        context)
                                                                    .bodyText1,
                                                            validator: (value) {
                                                              if (value
                                                                  .isEmpty) {
                                                                return "Password lama harus diisi";
                                                              }
                                                              return null;
                                                            },
                                                          );
                                                        }),
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
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                (20 / 1.w).w,
                                                                0,
                                                                0,
                                                                0),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Text(
                                                          'Password Baru',
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
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                (30 / 1.w).w,
                                                                0,
                                                                (30 / 1.w).w,
                                                                0),
                                                    child: Container(
                                                      width: double.infinity,
                                                      decoration:
                                                          BoxDecoration(),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0,
                                                                    (5 / 1.h).h,
                                                                    0,
                                                                    0),
                                                        child: Obx(() {
                                                          return TextFormField(
                                                            controller:
                                                                accountController
                                                                    .newPasswordFieldController,
                                                            autofocus: false,
                                                            obscureText:
                                                                !accountController
                                                                    .passwordVisibility
                                                                    .value,
                                                            decoration:
                                                                InputDecoration(
                                                              isDense: true,
                                                              enabledBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: CustomTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                  width:
                                                                      (1 / 1.w)
                                                                          .w,
                                                                ),
                                                                borderRadius:
                                                                    const BorderRadius
                                                                        .only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          4.0),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          4.0),
                                                                ),
                                                              ),
                                                              focusedBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: CustomTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                  width:
                                                                      (1 / 1.w)
                                                                          .w,
                                                                ),
                                                                borderRadius:
                                                                    const BorderRadius
                                                                        .only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          4.0),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          4.0),
                                                                ),
                                                              ),
                                                              errorBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: CustomTheme.of(
                                                                          context)
                                                                      .alternate,
                                                                  width:
                                                                      (2 / 1.w)
                                                                          .w,
                                                                ),
                                                                borderRadius:
                                                                    const BorderRadius
                                                                        .only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          4.0),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          4.0),
                                                                ),
                                                              ),
                                                              suffixIcon:
                                                                  InkWell(
                                                                onTap: () =>
                                                                    accountController
                                                                        .passwordVisibility
                                                                        .toggle(),
                                                                child: Icon(
                                                                  accountController
                                                                          .passwordVisibility
                                                                          .value
                                                                      ? Icons
                                                                          .visibility_outlined
                                                                      : Icons
                                                                          .visibility_off_outlined,
                                                                  color: Color(
                                                                      0xFF757575),
                                                                  size: (22 /
                                                                          1.sp)
                                                                      .sp,
                                                                ),
                                                              ),
                                                            ),
                                                            style:
                                                                CustomTheme.of(
                                                                        context)
                                                                    .bodyText1,
                                                            validator: (value) {
                                                              if (value
                                                                  .isEmpty) {
                                                                return "Password baru harus diisi";
                                                              } else if (value
                                                                      .length <
                                                                  6) {
                                                                return "Password baru harus terdiri dari minimal 6 karakter";
                                                              }
                                                              return null;
                                                            },
                                                          );
                                                        }),
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
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          (20 / 1.w), 0, (20 / 1.w), 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          CustomButton(
                                            tag: 'changePasswordBtn',
                                            onPressed: () => accountController
                                                .changePassword(),
                                            text: 'Ubah Password',
                                            options: CustomButtonOptions(
                                              width: (180 / 1.w).w,
                                              height: (40 / 1.h).h,
                                              color: CustomTheme.of(context)
                                                  .primaryText,
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
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            0, (10 / 1.h).h, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomButton(
                              tag: 'logOutBtn',
                              onPressed: () => accountController.logOut(),
                              text: 'Keluar',
                              icon: FaIcon(
                                FontAwesomeIcons.signOutAlt,
                              ),
                              options: CustomButtonOptions(
                                width: (180 / 1.w).w,
                                height: (50 / 1.h).h,
                                color: CustomTheme.of(context).alternate,
                                textStyle:
                                    CustomTheme.of(context).subtitle2.override(
                                          fontFamily: 'Poppins',
                                          color: Colors.white,
                                          fontSize: (20 / 1.sp).sp,
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
