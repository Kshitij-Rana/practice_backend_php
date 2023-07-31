import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Onboarding2Controller extends GetxController {
  //TODO: Implement Onboarding2Controller

  final count = 0.obs;
  PageController pageController = PageController();
  void nextpage() {
    pageController.nextPage(
        duration: Duration(seconds: 1), curve: Curves.elasticInOut);
  }

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
