import 'package:get/get.dart';
import 'package:skripskuy_web/app/controllers/auth_controller.dart';
import 'package:skripskuy_web/app/models/service/service_model.dart';

import '../../../controllers/notification_controller.dart';
import '../../../models/order/providers/order_provider.dart';
import '../../../models/service/providers/service_provider.dart';

class ThisMonthIncomeViewController extends GetxController
    with StateMixin<Map<String, dynamic>> {
  final authController = Get.find<AuthController>();
  final ServiceProvider serviceProvider = ServiceProvider();
  final OrderProvider orderProvider = OrderProvider();

  var serviceObj = Service().obs;
  var undoneOrderJsons = new List<dynamic>().obs;

  Stream updateUINotifier =
      Get.find<NotificationController>().updateUINotifier.stream;

  Stream homeControllerIndicator;

  ThisMonthIncomeViewController(this.homeControllerIndicator);

  @override
  void onInit() {
    super.onInit();
    updateUINotifier.listen((_) {
      initThisMonthIncome();
    });
    homeControllerIndicator.listen((_) {
      initThisMonthIncome();
    });
    initThisMonthIncome();
  }

  Future<void> initThisMonthIncome() async {
    try {
      change(null, status: RxStatus.loading());
      serviceProvider
          .getServiceByUserId(userId: authController.getCurrentFirebaseId)
          .then((serviceObj) {
        this.serviceObj = serviceObj.obs;
        orderProvider
            .getThisMonthIncomeJson(serviceId: this.serviceObj?.value?.id ?? 0)
            .then((thisMonthIncomeJson) {
          if (thisMonthIncomeJson != null) {
            change(thisMonthIncomeJson, status: RxStatus.success());
          } else {
            change({}, status: RxStatus.success());
          }
        });
      });
    } catch (e) {
      print(e);
    }
  }
}
