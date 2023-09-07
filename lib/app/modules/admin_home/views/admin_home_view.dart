import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:getxpractice/app/model/stats.dart';

import '../controllers/admin_home_controller.dart';

class AdminHomeView extends GetView<AdminHomeController> {
  const AdminHomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(AdminHomeController());
    return Scaffold(
        body: GetBuilder<AdminHomeController>(
      init: AdminHomeController(),
      builder: (controller) {
        if (controller.stats == null) {
          return const Center(child: CircularProgressIndicator());
        }
        return RefreshIndicator(
          onRefresh: () async {
            await controller.getStats();
          },
          child: Container(
            margin: EdgeInsets.all(10),
            child: GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, mainAxisSpacing: 5, crossAxisSpacing: 5),
              children: [
                StatsCard(
                  value: controller.stats?.totalProducts.toString() ?? '',
                  label: 'Total Products',
                  icon: Icon(Icons.production_quantity_limits_rounded),
                ),
                StatsCard(
                  label: "Total Users",
                  value: controller.stats?.totalUsers.toString() ?? '',
                  icon: Icon(Icons.people),
                ),
                StatsCard(
                  label: "Total Income",
                  value: controller.stats?.totalIncome.toString() ?? '',
                  icon: Icon(Icons.attach_money),
                  isAmount: true,
                ),
                StatsCard(
                  label: "Total Orders",
                  value: controller.stats?.totalOrders.toString() ?? '',
                  icon: Icon(Icons.shopping_bag),
                )
              ],
            ),
          ),
        );
      },
    ));
  }
}

class StatsCard extends StatelessWidget {
  final String label;
  final String value;
  final Icon? icon;
  final bool isAmount;
  final Color? color;
  const StatsCard(
      {super.key,
      required this.label,
      required this.value,
      this.icon,
      this.isAmount = false,
      this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          spreadRadius: 2,
          color: Colors.black12,
          offset: Offset(1, 1),
        )
      ], color: color ?? Colors.blue.shade100),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            (isAmount ? 'Rs.' : '') + value,
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              icon ?? const SizedBox.shrink(),
            ],
          )
        ],
      ),
    );
  }
}
