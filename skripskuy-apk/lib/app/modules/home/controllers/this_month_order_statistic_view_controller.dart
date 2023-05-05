import 'package:get/get.dart';
import 'package:skripskuy_web/app/models/service/service_model.dart';

import '../../../controllers/auth_controller.dart';
import '../../../controllers/notification_controller.dart';
import '../../../models/order/providers/order_provider.dart';
import '../../../models/service/providers/service_provider.dart';

class ThisMonthOrderStatisticViewController extends GetxController
    with StateMixin<Map<String, dynamic>> {
  final authController = Get.find<AuthController>();
  final ServiceProvider serviceProvider = ServiceProvider();
  final OrderProvider orderProvider = OrderProvider();

  var serviceObj = Service().obs;
  var undoneOrderJsons = new List<dynamic>().obs;

  Stream updateUINotifier =
      Get.find<NotificationController>().updateUINotifier.stream;

  Stream homeControllerIndicator;

  ThisMonthOrderStatisticViewController(this.homeControllerIndicator);

  @override
  void onInit() {
    super.onInit();
    updateUINotifier.listen((_) {
      initThisMonthOrderStatistic();
    });
    homeControllerIndicator.listen((_) {
      initThisMonthOrderStatistic();
    });
    initThisMonthOrderStatistic();
  }

  Future<void> initThisMonthOrderStatistic() async {
    try {
      change(null, status: RxStatus.loading());
      serviceProvider
          .getServiceByUserId(userId: authController.getCurrentFirebaseId)
          .then((serviceObj) {
        this.serviceObj = serviceObj.obs;
        orderProvider
            .getThisMonthOrderStatisticJson(serviceId: this.serviceObj?.value?.id ?? 0)
            .then((thisMonthOrderStatisticJson) {
          if (thisMonthOrderStatisticJson != null) {
            change(thisMonthOrderStatisticJson, status: RxStatus.success());
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
