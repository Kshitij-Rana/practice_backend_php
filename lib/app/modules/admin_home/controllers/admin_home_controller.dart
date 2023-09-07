import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxpractice/app/components/constants.dart';
import 'package:getxpractice/app/model/stats.dart';
import 'package:getxpractice/app/routes/app_pages.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AdminHomeController extends GetxController {
  Stats? stats;
  late final SharedPreferences prefs;

  final count = 0.obs;
  @override
  Future<void> onInit() async {
    super.onInit();
    prefs = await SharedPreferences.getInstance();
    getStats();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> onLogOut() async {
    await prefs.clear();
    Get.offAllNamed(Routes.LOGIN);
  }

  Future<void> getStats() async {
    try {
      var url = Uri.http(ipAdress, 'practice_api/getStats.php');
      var response =
          await http.post(url, body: {'token': prefs.getString('token')});

      var result = jsonDecode(response.body);
      if (result['success']) {
        stats = statsFromJson(jsonEncode(result['data']));
        update();
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
