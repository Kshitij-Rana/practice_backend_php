import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:getxpractice/app/modules/cart/views/cart_view.dart';
import 'package:getxpractice/app/modules/cart2/views/cart2_view.dart';
import 'package:getxpractice/app/modules/homepage/views/homepage_view.dart';
import 'package:getxpractice/app/modules/orders/views/orders_view.dart';
import 'package:getxpractice/app/modules/profile/views/profile_view.dart';

class HomeController extends GetxController {
  List<Widget> screens = [
    const HomepageView(),
    const OrdersView(),
    const CartView(),
    const ProfileView(),
    const Cart2View(),
  ];
  var currentIndex = 0.obs;

  final count = 0.obs;
  void increment() => count.value++;
}
