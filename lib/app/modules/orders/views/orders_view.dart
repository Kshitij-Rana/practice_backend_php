import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:getxpractice/app/components/OrderCard.dart';

import '../controllers/orders_controller.dart';

class OrdersView extends GetView<OrdersController> {
  const OrdersView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(OrdersController());
    return Scaffold(
        appBar: AppBar(
          title: Text(
              controller.getAccessRole() == "admin" ? 'Orders' : 'My Orders'),
          centerTitle: true,
        ),
        body: GetBuilder<OrdersController>(
          init: OrdersController(),
          builder: (controller) {
            if (controller.orders == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
                padding: EdgeInsets.all(20),
                itemCount: controller.orders!.length,
                itemBuilder: (context, index) =>
                    OrderCard(order: controller.orders![index]));
          },
        ));
  }
}
