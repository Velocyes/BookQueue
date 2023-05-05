import 'package:get/get.dart';

import 'package:skripskuy_web/app/modules/account/bindings/account_binding.dart';
import 'package:skripskuy_web/app/modules/account/views/account_view.dart';
import 'package:skripskuy_web/app/modules/dashboard/bindings/dashboard_binding.dart';
import 'package:skripskuy_web/app/modules/dashboard/views/dashboard_view.dart';
import 'package:skripskuy_web/app/modules/forget_password/bindings/forget_password_binding.dart';
import 'package:skripskuy_web/app/modules/forget_password/views/forget_password_view.dart';
import 'package:skripskuy_web/app/modules/home/bindings/home_binding.dart';
import 'package:skripskuy_web/app/modules/home/views/home_view.dart';
import 'package:skripskuy_web/app/modules/login/bindings/login_binding.dart';
import 'package:skripskuy_web/app/modules/login/views/login_view.dart';
import 'package:skripskuy_web/app/modules/order/bindings/order_binding.dart';
import 'package:skripskuy_web/app/modules/order/views/order_view.dart';
import 'package:skripskuy_web/app/modules/order_history_detail/bindings/order_history_detail_binding.dart';
import 'package:skripskuy_web/app/modules/register/bindings/register_binding.dart';
import 'package:skripskuy_web/app/modules/register/views/register_view.dart';
import 'package:skripskuy_web/app/modules/service/bindings/service_binding.dart';
import 'package:skripskuy_web/app/modules/service/views/service_view.dart';

import '../modules/order_history_detail/views/order_history_detail_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.FORGET_PASSWORD,
      page: () => ForgetPasswordView(),
      binding: ForgetPasswordBinding(),
    ),
    GetPage(
      name: _Paths.ORDER,
      page: () => OrderView(),
      binding: OrderBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SERVICE,
      page: () => ServiceView(),
      binding: ServiceBinding(),
    ),
    GetPage(
      name: _Paths.ACCOUNT,
      page: () => AccountView(),
      binding: AccountBinding(),
    ),
    GetPage(
      name: _Paths.ORDER_HISTORY_DETAIL,
      page: () => OrderHistoryDetailView(),
      binding: OrderHistoryDetailBinding(),
    ),
  ];
}
