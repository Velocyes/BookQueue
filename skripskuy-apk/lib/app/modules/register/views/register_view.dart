import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:skripskuy_web/app/utils/custom_button.dart';

import '../../../utils/custom_theme.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldKey,
      backgroundColor: CustomTheme.of(context).primaryBackground,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: [
              Align(
                alignment: AlignmentDirectional(0, 0),
                child: Image.network(
                  'https://picsum.photos/seed/285/600',
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0, 0),
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(),
                  child: ClipRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 5,
                        sigmaY: 5,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB((60 / 1.w).w,
                              (60 / 1.h).h, (60 / 1.w).w, (60 / 1.h).h),
                          child: Container(
                            width: (100 / 1.w).w,
                            height: (100 / 1.h).h,
                            decoration: BoxDecoration(
                              color:
                                  CustomTheme.of(context).secondaryBackground,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  (30 / 1.w).w, 0, (30 / 1.w).w, 0),
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(),
                                      child: SingleChildScrollView(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0, (50 / 1.h).h, 0, 0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      'BookQueue',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: CustomTheme.of(
                                                              context)
                                                          .bodyText1
                                                          .override(
                                                            fontFamily:
                                                                'Poppins',
                                                            fontSize:
                                                                (35 / 1.sp).sp,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: double.infinity,
                                              decoration: BoxDecoration(),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0, (20 / 1.h).h, 0, 0),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0,
                                                                  (20 / 1.h).h,
                                                                  0,
                                                                  0),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Expanded(
                                                            child: Text(
                                                              'Daftar',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: CustomTheme
                                                                      .of(context)
                                                                  .bodyText1
                                                                  .override(
                                                                    fontFamily:
                                                                        'Poppins',
                                                                    fontSize:
                                                                        (24 / 1.sp)
                                                                            .sp,
                                                                  ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0,
                                                                  (20 / 1.h).h,
                                                                  0,
                                                                  0),
                                                      child: Form(
                                                        key: controller.formKey,
                                                        autovalidateMode:
                                                            AutovalidateMode
                                                                .onUserInteraction,
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            Padding(
                                                              padding: EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0,
                                                                      (10 / 1.h)
                                                                          .h,
                                                                      0,
                                                                      (10 / 1.h)
                                                                          .h),
                                                              child:
                                                                  TextFormField(
                                                                controller:
                                                                    controller
                                                                        .fullNameFieldController,
                                                                obscureText:
                                                                    false,
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
                                                                      width: (2 /
                                                                              1.w)
                                                                          .w,
                                                                    ),
                                                                    borderRadius:
                                                                        const BorderRadius
                                                                            .only(
                                                                      topLeft: Radius
                                                                          .circular(
                                                                              4.0),
                                                                      topRight:
                                                                          Radius.circular(
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
                                                                      width: (2 /
                                                                              1.w)
                                                                          .w,
                                                                    ),
                                                                    borderRadius:
                                                                        const BorderRadius
                                                                            .only(
                                                                      topLeft: Radius
                                                                          .circular(
                                                                              4.0),
                                                                      topRight:
                                                                          Radius.circular(
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
                                                                      width: (2 /
                                                                              1.w)
                                                                          .w,
                                                                    ),
                                                                    borderRadius:
                                                                        const BorderRadius
                                                                            .only(
                                                                      topLeft: Radius
                                                                          .circular(
                                                                              4.0),
                                                                      topRight:
                                                                          Radius.circular(
                                                                              4.0),
                                                                    ),
                                                                  ),
                                                                  contentPadding: EdgeInsetsDirectional.fromSTEB(
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
                                                                validator:
                                                                    (value) {
                                                                  if (value
                                                                      .isEmpty) {
                                                                    return "Nama lengkap harus diisi";
                                                                  }
                                                                  return null;
                                                                },
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding: EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0,
                                                                      (10 / 1.h)
                                                                          .h,
                                                                      0,
                                                                      (10 / 1.h)
                                                                          .h),
                                                              child:
                                                                  TextFormField(
                                                                controller:
                                                                    controller
                                                                        .phoneNumberFieldController,
                                                                obscureText:
                                                                    false,
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
                                                                      width: (2 /
                                                                              1.w)
                                                                          .w,
                                                                    ),
                                                                    borderRadius:
                                                                        const BorderRadius
                                                                            .only(
                                                                      topLeft: Radius
                                                                          .circular(
                                                                              4.0),
                                                                      topRight:
                                                                          Radius.circular(
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
                                                                      width: (2 /
                                                                              1.w)
                                                                          .w,
                                                                    ),
                                                                    borderRadius:
                                                                        const BorderRadius
                                                                            .only(
                                                                      topLeft: Radius
                                                                          .circular(
                                                                              4.0),
                                                                      topRight:
                                                                          Radius.circular(
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
                                                                      width: (2 /
                                                                              1.w)
                                                                          .w,
                                                                    ),
                                                                    borderRadius:
                                                                        const BorderRadius
                                                                            .only(
                                                                      topLeft: Radius
                                                                          .circular(
                                                                              4.0),
                                                                      topRight:
                                                                          Radius.circular(
                                                                              4.0),
                                                                    ),
                                                                  ),
                                                                  contentPadding: EdgeInsetsDirectional.fromSTEB(
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
                                                                validator:
                                                                    (value) {
                                                                  if (value
                                                                      .isEmpty) {
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
                                                              padding: EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0,
                                                                      (10 / 1.h)
                                                                          .h,
                                                                      0,
                                                                      (10 / 1.h)
                                                                          .h),
                                                              child:
                                                                  TextFormField(
                                                                controller:
                                                                    controller
                                                                        .emailFieldController,
                                                                obscureText:
                                                                    false,
                                                                decoration:
                                                                    InputDecoration(
                                                                  labelText:
                                                                      'Email',
                                                                  hintText:
                                                                      'Masukan email anda disini',
                                                                  enabledBorder:
                                                                      OutlineInputBorder(
                                                                    borderSide:
                                                                        BorderSide(
                                                                      color: CustomTheme.of(
                                                                              context)
                                                                          .primaryText,
                                                                      width: (2 /
                                                                              1.w)
                                                                          .w,
                                                                    ),
                                                                    borderRadius:
                                                                        const BorderRadius
                                                                            .only(
                                                                      topLeft: Radius
                                                                          .circular(
                                                                              4.0),
                                                                      topRight:
                                                                          Radius.circular(
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
                                                                      width: (2 /
                                                                              1.w)
                                                                          .w,
                                                                    ),
                                                                    borderRadius:
                                                                        const BorderRadius
                                                                            .only(
                                                                      topLeft: Radius
                                                                          .circular(
                                                                              4.0),
                                                                      topRight:
                                                                          Radius.circular(
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
                                                                      width: (2 /
                                                                              1.w)
                                                                          .w,
                                                                    ),
                                                                    borderRadius:
                                                                        const BorderRadius
                                                                            .only(
                                                                      topLeft: Radius
                                                                          .circular(
                                                                              4.0),
                                                                      topRight:
                                                                          Radius.circular(
                                                                              4.0),
                                                                    ),
                                                                  ),
                                                                  contentPadding: EdgeInsetsDirectional.fromSTEB(
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
                                                                validator:
                                                                    (value) {
                                                                  if (value
                                                                      .isEmpty) {
                                                                    return "Email harus diisi";
                                                                  } else if (!value
                                                                      .isEmail) {
                                                                    return "Harap isi email dengan format yang benar";
                                                                  }
                                                                  return null;
                                                                },
                                                              ),
                                                            ),
                                                            Padding(
                                                                padding: EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0,
                                                                        (10 / 1.h)
                                                                            .h,
                                                                        0,
                                                                        (10 / 1.h)
                                                                            .h),
                                                                child: Obx(() {
                                                                  return TextFormField(
                                                                    controller:
                                                                        controller
                                                                            .passwordFieldController,
                                                                    obscureText:
                                                                        !controller
                                                                            .passwordVisibility
                                                                            .value,
                                                                    decoration:
                                                                        InputDecoration(
                                                                      labelText:
                                                                          'Password',
                                                                      hintText:
                                                                          'Masukan password anda disini',
                                                                      enabledBorder:
                                                                          OutlineInputBorder(
                                                                        borderSide:
                                                                            BorderSide(
                                                                          color:
                                                                              CustomTheme.of(context).primaryText,
                                                                          width:
                                                                              (2 / 1.w).w,
                                                                        ),
                                                                        borderRadius:
                                                                            const BorderRadius.only(
                                                                          topLeft:
                                                                              Radius.circular(4.0),
                                                                          topRight:
                                                                              Radius.circular(4.0),
                                                                        ),
                                                                      ),
                                                                      focusedBorder:
                                                                          OutlineInputBorder(
                                                                        borderSide:
                                                                            BorderSide(
                                                                          color:
                                                                              CustomTheme.of(context).primaryText,
                                                                          width:
                                                                              (2 / 1.w).w,
                                                                        ),
                                                                        borderRadius:
                                                                            const BorderRadius.only(
                                                                          topLeft:
                                                                              Radius.circular(4.0),
                                                                          topRight:
                                                                              Radius.circular(4.0),
                                                                        ),
                                                                      ),
                                                                      errorBorder:
                                                                          OutlineInputBorder(
                                                                        borderSide:
                                                                            BorderSide(
                                                                          color:
                                                                              CustomTheme.of(context).alternate,
                                                                          width:
                                                                              (2 / 1.w).w,
                                                                        ),
                                                                        borderRadius:
                                                                            const BorderRadius.only(
                                                                          topLeft:
                                                                              Radius.circular(4.0),
                                                                          topRight:
                                                                              Radius.circular(4.0),
                                                                        ),
                                                                      ),
                                                                      contentPadding: EdgeInsetsDirectional.fromSTEB(
                                                                          (10 / 1.w)
                                                                              .w,
                                                                          (5 / 1.h)
                                                                              .h,
                                                                          0,
                                                                          (5 / 1.h)
                                                                              .h),
                                                                      suffixIcon:
                                                                          InkWell(
                                                                        onTap: () => controller
                                                                            .passwordVisibility
                                                                            .toggle(),
                                                                        focusNode:
                                                                            FocusNode(skipTraversal: true),
                                                                        child:
                                                                            Icon(
                                                                          controller.passwordVisibility.value
                                                                              ? Icons.visibility_outlined
                                                                              : Icons.visibility_off_outlined,
                                                                          color:
                                                                              Color(0xFF757575),
                                                                          size:
                                                                              (22 / 1.sp).sp,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    style: CustomTheme.of(
                                                                            context)
                                                                        .bodyText1
                                                                        .override(
                                                                          fontFamily:
                                                                              'Poppins',
                                                                          fontSize:
                                                                              (16 / 1.sp).sp,
                                                                        ),
                                                                    keyboardType:
                                                                        TextInputType
                                                                            .text,
                                                                    validator:
                                                                        (value) {
                                                                      if (value
                                                                          .isEmpty) {
                                                                        return "Password harus diisi";
                                                                      } else if (value
                                                                              .length <
                                                                          6) {
                                                                        return "Password harus terdiri dari minimal 6 karakter";
                                                                      }
                                                                      return null;
                                                                    },
                                                                  );
                                                                })),
                                                            Padding(
                                                              padding: EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0,
                                                                      (10 / 1.h)
                                                                          .h,
                                                                      0,
                                                                      (10 / 1.h)
                                                                          .h),
                                                              child: Obx(() {
                                                                return TextFormField(
                                                                  controller:
                                                                      controller
                                                                          .confirmationPasswordFieldController,
                                                                  obscureText:
                                                                      !controller
                                                                          .passwordVisibility
                                                                          .value,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    labelText:
                                                                        'Konfirmasi Password',
                                                                    hintText:
                                                                        'Ulangi password anda disini',
                                                                    enabledBorder:
                                                                        OutlineInputBorder(
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color: CustomTheme.of(context)
                                                                            .primaryText,
                                                                        width: (2 /
                                                                                1.w)
                                                                            .w,
                                                                      ),
                                                                      borderRadius:
                                                                          const BorderRadius
                                                                              .only(
                                                                        topLeft:
                                                                            Radius.circular(4.0),
                                                                        topRight:
                                                                            Radius.circular(4.0),
                                                                      ),
                                                                    ),
                                                                    focusedBorder:
                                                                        OutlineInputBorder(
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color: CustomTheme.of(context)
                                                                            .primaryText,
                                                                        width: (2 /
                                                                                1.w)
                                                                            .w,
                                                                      ),
                                                                      borderRadius:
                                                                          const BorderRadius
                                                                              .only(
                                                                        topLeft:
                                                                            Radius.circular(4.0),
                                                                        topRight:
                                                                            Radius.circular(4.0),
                                                                      ),
                                                                    ),
                                                                    errorBorder:
                                                                        OutlineInputBorder(
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color: CustomTheme.of(context)
                                                                            .alternate,
                                                                        width: (2 /
                                                                                1.w)
                                                                            .w,
                                                                      ),
                                                                      borderRadius:
                                                                          const BorderRadius
                                                                              .only(
                                                                        topLeft:
                                                                            Radius.circular(4.0),
                                                                        topRight:
                                                                            Radius.circular(4.0),
                                                                      ),
                                                                    ),
                                                                    contentPadding: EdgeInsetsDirectional.fromSTEB(
                                                                        (10 / 1.w)
                                                                            .w,
                                                                        (5 / 1.h)
                                                                            .h,
                                                                        0,
                                                                        (5 / 1.h)
                                                                            .h),
                                                                    suffixIcon:
                                                                        InkWell(
                                                                      onTap: () => controller
                                                                          .passwordVisibility
                                                                          .toggle(),
                                                                      focusNode:
                                                                          FocusNode(
                                                                              skipTraversal: true),
                                                                      child:
                                                                          Icon(
                                                                        controller.passwordVisibility.value
                                                                            ? Icons.visibility_outlined
                                                                            : Icons.visibility_off_outlined,
                                                                        color: Color(
                                                                            0xFF757575),
                                                                        size: (22 /
                                                                                1.sp)
                                                                            .sp,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  style: CustomTheme.of(
                                                                          context)
                                                                      .bodyText1
                                                                      .override(
                                                                        fontFamily:
                                                                            'Poppins',
                                                                        fontSize:
                                                                            (16 / 1.sp).sp,
                                                                      ),
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .text,
                                                                  validator:
                                                                      (value) {
                                                                    if (value
                                                                        .isEmpty) {
                                                                      return "Konfirmasi password harus diisi";
                                                                    } else if (value !=
                                                                        controller
                                                                            .passwordFieldController
                                                                            .text) {
                                                                      return "Konfirmasi password harus sama dengan password";
                                                                    }
                                                                    return null;
                                                                  },
                                                                );
                                                              }),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0,
                                                                  (50 / 1.h).h,
                                                                  0,
                                                                  0),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          CustomButton(
                                                            tag: 'registerBtn',
                                                            onPressed: () =>
                                                                controller
                                                                    .register(),
                                                            text: 'Daftar',
                                                            options:
                                                                CustomButtonOptions(
                                                              width:
                                                                  (130 / 1.w).w,
                                                              height:
                                                                  (40 / 1.h).h,
                                                              color: CustomTheme
                                                                      .of(context)
                                                                  .primaryText,
                                                              textStyle:
                                                                  CustomTheme.of(
                                                                          context)
                                                                      .subtitle2
                                                                      .override(
                                                                        fontFamily:
                                                                            'Poppins',
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                              elevation: 20,
                                                              borderSide:
                                                                  BorderSide(
                                                                color: Colors
                                                                    .transparent,
                                                                width:
                                                                    (1 / 1.w).w,
                                                              ),
                                                              borderRadius: 12,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0,
                                                                  (20 / 1.h).h,
                                                                  0,
                                                                  (20 / 1.h).h),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            'Sudah Memiliki Akun ?',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style:
                                                                CustomTheme.of(
                                                                        context)
                                                                    .bodyText1
                                                                    .override(
                                                                      fontFamily:
                                                                          'Poppins',
                                                                      fontSize:
                                                                          (16 / 1.sp)
                                                                              .sp,
                                                                    ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        (4 / 1.w)
                                                                            .w,
                                                                        0,
                                                                        0,
                                                                        0),
                                                            child:
                                                                GestureDetector(
                                                              onTap: () =>
                                                                  Get.back(),
                                                              child: Text(
                                                                'Masuk',
                                                                style: CustomTheme.of(
                                                                        context)
                                                                    .bodyText1
                                                                    .override(
                                                                      fontFamily:
                                                                          'Poppins',
                                                                      color: CustomTheme.of(
                                                                              context)
                                                                          .primaryColor,
                                                                      fontSize:
                                                                          (16 / 1.sp)
                                                                              .sp,
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
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            (30 / 1.w).w, (50 / 1.h).h, 0, (50 / 1.h).h),
                        child: Container(
                          width: double.infinity,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            color: CustomTheme.of(context).secondaryBackground,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(100),
                              bottomRight: Radius.circular(0),
                              topLeft: Radius.circular(100),
                              topRight: Radius.circular(0),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                (100 / 1.w).w,
                                (80 / 1.h).h,
                                (80 / 1.w).w,
                                (150 / 1.h).h),
                            child: Container(
                              width: (100 / 1.w).w,
                              height: (100 / 1.h).h,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: Image.asset(
                                    'assets/images/BookQueue.png',
                                  ).image,
                                ),
                              ),
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
      ),
    );
  }
}
