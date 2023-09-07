import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:getxpractice/app/components/admin_product_card.dart';
import 'package:getxpractice/app/modules/homepage/controllers/homepage_controller.dart';

import '../controllers/admin_product_controller.dart';

class AdminProductView extends GetView<AdminProductController> {
  const AdminProductView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(AdminProductController());
    return Scaffold(
        body: GetBuilder<HomepageController>(
          init: HomepageController(),
          builder: (controller) {
            if (controller.products == null) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
              itemCount: controller.products?.length ?? 0,
              itemBuilder: (context, index) {
                return adminProductCard(
                  product: controller.products![index],
                );
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton.extended(
          label: Text("Add product"),
          icon: Icon(Icons.add),
          onPressed: controller.onAdd,
        ));
  }
}
