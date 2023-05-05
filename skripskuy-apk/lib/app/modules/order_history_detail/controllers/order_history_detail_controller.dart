import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skripskuy_web/app/models/order/providers/order_provider.dart';
import 'package:skripskuy_web/app/models/order_detail/providers/order_detail_provider.dart';

class OrderHistoryDetailController extends GetxController
    with StateMixin<Map<String, dynamic>> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final orderProvider = OrderProvider();
  final orderDetailProvider = OrderDetailProvider();

  List<RxMap<String, TextEditingController>> listTextEditingController =
      new List<RxMap<String, TextEditingController>>().obs;

  var isNew = true.obs;

  @override
  void onInit() {
    super.onInit();
    change(null, status: RxStatus.loading());
    initOrderHistoryDetail();
  }

  void addList() async {
    await orderProvider
        .getOrderHistoryJson(orderId: Get.arguments)
        .then((orderHistoryJson) {
      listTextEditingController.add({
        'quantity': TextEditingController(),
        'description': TextEditingController(),
        'price': TextEditingController(),
        'subTotal': TextEditingController(),
      }.obs);
    });
  }

  void removeList(int index) {
    listTextEditingController.removeAt(index);
  }

  void calculation(int index) {
    listTextEditingController[index]['subTotal'].text = (int.parse(
                (listTextEditingController[index]['quantity'].text != ''
                    ? listTextEditingController[index]['quantity'].text
                    : 0.toString())) *
            int.parse((listTextEditingController[index]['price'].text != ''
                ? listTextEditingController[index]['price'].text
                : 0.toString())))
        .toString();
  }

  Future<void> initOrderHistoryDetail() async {
    change(null, status: RxStatus.loading());
    try {
      await orderProvider
          .getOrderHistoryJson(orderId: Get.arguments)
          .then((orderHistoryJson) async {
        if (orderHistoryJson != null) {
          await orderDetailProvider
              .getOrderDetailByOrderId(orderId: Get.arguments)
              .then((orderDetailObjs) async {
            if (orderDetailObjs != null) {
              await orderDetailObjs.forEach((orderDetailObj) {
                listTextEditingController.add({
                  'quantity': TextEditingController(
                      text: orderDetailObj.quantity.toString()),
                  'description': TextEditingController(
                      text: orderDetailObj.header.toString()),
                  'price': TextEditingController(
                      text: orderDetailObj.cost.toString()),
                  'subTotal': TextEditingController(
                      text: ((orderDetailObj.quantity != null
                                  ? orderDetailObj.quantity
                                  : 0) *
                              (orderDetailObj.cost != null
                                  ? orderDetailObj.cost
                                  : 0))
                          .toString()),
                }.obs);
              });
            }
          });
          if (listTextEditingController.isEmpty) {
            await orderProvider
                .getOrderHistoryJson(orderId: Get.arguments)
                .then((orderHistoryJson) {
              listTextEditingController.add({
                'quantity': TextEditingController(text: '1'),
                'description': TextEditingController(
                    text: orderHistoryJson['service_package_name'].toString()),
                'price': TextEditingController(
                    text: orderHistoryJson['service_package_cost'].toString()),
                'subTotal': TextEditingController(
                    text: (1 * orderHistoryJson['service_package_cost']).toString()),
              }.obs);
            });
          } else {
            isNew = false.obs;
          }
          change(orderHistoryJson, status: RxStatus.success());
        } else {
          change(null, status: RxStatus.success());
        }
      });
    } catch (e) {
      print(e);
    }
  }

  void addOrderDetail() {
    try {
      listTextEditingController
          .asMap()
          .forEach((index, textEditingController) async {
        await orderDetailProvider
            .createOrderDetail(
                orderId: Get.arguments,
                quantity: int.parse(textEditingController['quantity'].text != ''
                    ? textEditingController['quantity'].text
                    : '1'),
                header: textEditingController['description'].text,
                price: int.parse(textEditingController['price'].text != ''
                    ? textEditingController['price'].text
                    : '0'))
            .then((_) {
          if (index + 1 == listTextEditingController.length) {
            orderProvider.paidOrder(orderId: Get.arguments).then((orderObj) {
              if (orderObj != null) {
                Get.back();
                Get.snackbar('Berhasil', 'Order telah diselesaikan',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.white,
                    borderRadius: 20);
              }
              ;
            });
          }
        });
      });
    } catch (e) {
      print(e);
      Get.snackbar("Terdapat kesalahan",
          "Permintaan tidak dapat di proses (Kesalahan Sistem)",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
          borderRadius: 20);
    }
  }
}
