import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxpractice/app/components/addProductpopup.dart';
import 'package:getxpractice/app/components/constants.dart';
import 'package:getxpractice/app/modules/homepage/controllers/homepage_controller.dart';
import 'package:getxpractice/app/utils/Memorymanagement.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AdminProductController extends GetxController {
  SharedPreferences? prefs;
  //TODO: Implement AdminProductController
  final ImagePicker picker = ImagePicker();
  XFile? image;
  var imagebytes = Uint8List(0).obs;

  final count = 0.obs;
  void onAdd() {
    showDialog(context: Get.context!, builder: (context) => addProductPopup());
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    prefs = await SharedPreferences.getInstance();
  }

  Future<void> onDeleteClicked({required String productId}) async {
    try {
      var url = Uri.http(ipAdress, 'practice_api/deleteProduct.php');
      print(url);
      var response = await http.post(url,
          body: {'product_id': productId, 'token': prefs!.getString('token')});
      print(response.body);
      var result = jsonDecode(response.body);
      print(result['success']);
      if (result['success']) {
        Get.back();
        Get.showSnackbar(GetSnackBar(
          message: result['message'],
          backgroundColor: Colors.green,
          duration: Duration(seconds: 3),
        ));
        var homePageController = Get.find<HomepageController>();
        homePageController.getProduct();
      } else {
        Get.showSnackbar(GetSnackBar(
          message: result['message'],
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ));
      }
    } catch (e) {
      print(e);
      Get.showSnackbar(GetSnackBar(
        message: "Something went wrong",
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
      ));
    }
  }

  Future<void> onDeletelaiAdd({required String productId}) async {
    try {
      var url = Uri.http(ipAdress, 'practice_api/deleteProductlaiAdd.php');
      var response = await http.post(url,
          body: {'product_id': productId, 'token': prefs!.getString('token')});
      var result = jsonDecode(response.body);
      if (result['success']) {
        Get.back();
        Get.showSnackbar(GetSnackBar(
          message: result['message'],
          backgroundColor: Colors.green,
          duration: Duration(seconds: 3),
        ));
        var homePageController = Get.find<HomepageController>();
        homePageController.getProduct();
      } else {
        Get.showSnackbar(GetSnackBar(
          message: result['message'],
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ));
      }
    } catch (e) {
      print(e);

      Get.showSnackbar(GetSnackBar(
        message: "Something went wrong",
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
      ));
    }
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
