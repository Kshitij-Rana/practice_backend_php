import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:getxpractice/app/modules/admin_category/views/admin_category_view.dart';
import 'package:getxpractice/app/modules/admin_home/views/admin_home_view.dart';
import 'package:getxpractice/app/modules/admin_order/views/admin_order_view.dart';
import 'package:getxpractice/app/modules/admin_product/views/admin_product_view.dart';
import '../../profile/views/profile_view.dart';

class AdminMainController extends GetxController {
  //TODO: Implement AdminMainController
  List<Widget> screens = [
    const AdminHomeView(),
    const AdminCategoryView(),
    const AdminProductView(),
    const AdminOrderView(),
    const ProfileView()
  ];
  final count = 0.obs;

  var currentIndex = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
