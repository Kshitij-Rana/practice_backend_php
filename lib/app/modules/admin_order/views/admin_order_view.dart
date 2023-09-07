import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:getxpractice/app/components/constants.dart';
import 'package:getxpractice/app/modules/homepage/controllers/homepage_controller.dart';

import '../controllers/admin_order_controller.dart';

class AdminOrderView extends GetView<AdminOrderController> {
  const AdminOrderView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<HomepageController>(
      init: HomepageController(),
      builder: (controller) {
        if (controller.products == null) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: controller.products?.length ?? 0,
          itemBuilder: (context, index) {
            return Container(
              height: 75,
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                    color: Colors.grey.shade400,
                    blurRadius: 2,
                    spreadRadius: 2,
                    offset: const Offset(3, 3))
              ]),
              child: Row(
                children: [
                  Image.network(
                    getImageUrl(controller.products?[index].image ?? ''),
                    height: 100,
                    width: 100,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    controller.products?[index].title ?? '',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  )
                ],
              ),
            );
          },
        );
      },
    ));
  }
}
