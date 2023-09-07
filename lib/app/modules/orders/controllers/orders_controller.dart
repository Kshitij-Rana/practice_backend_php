import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxpractice/app/components/constants.dart';
import 'package:getxpractice/app/model/order.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class OrdersController extends GetxController {
  SharedPreferences? prefs;

  List<Order>? orders;
  final count = 0.obs;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    prefs = await SharedPreferences.getInstance();
    getOrders();
    update();
  }

  String? getAccessRole() {
    return prefs != null ? prefs!.getString('role') : null;
  }

  String? getAccessToken() {
    return prefs != null ? prefs!.getString('token') : null;
  }

  Future<void> getOrders() async {
    try {
      var url = Uri.http(ipAdress, 'practice_api/getorders.php');
      var response = await http.post(url, body: {
        'token': getAccessToken(),
      });
      print(response.body);
      var result = jsonDecode(response.body);
      print(result['success']);
      if (result['success']) {
        orders = orderFromJson(jsonEncode(result['data']));
      } else {
        Get.showSnackbar(GetSnackBar(
          backgroundColor: Colors.red,
          message: result['message'],
          duration: const Duration(seconds: 3),
        ));
      }
    } catch (e) {
      print(e);
      Get.showSnackbar(const GetSnackBar(
        backgroundColor: Colors.red,
        message: 'Something went wrong',
        duration: Duration(seconds: 3),
      ));
    }
  }

  void increment() => count.value++;
}
