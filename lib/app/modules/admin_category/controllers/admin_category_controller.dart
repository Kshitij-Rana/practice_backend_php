import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxpractice/app/components/adCategoryPopup.dart';

class AdminCategoryController extends GetxController {
  //TODO: Implement AdminCategoryController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  void onCategoryAdd() {
    showDialog(
      context: Get.context!,
      builder: (context) => const addCategoryPopup(),
    );
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
