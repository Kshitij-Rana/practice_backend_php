import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxpractice/app/components/constants.dart';
import 'package:getxpractice/app/model/user.dart';
import 'package:getxpractice/app/utils/Memorymanagement.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../routes/app_pages.dart';
import 'package:http/http.dart' as http;

class ProfileController extends GetxController {
  late final SharedPreferences prefs;
  User? user;
  final count = 0.obs;

  void onLogOut() async {
    await prefs.remove('token');
    await prefs.clear();
    Get.offAllNamed(Routes.LOGIN);
  }

  Future<void> getUserInfo() async {
    try {
      var url = Uri.http(ipAdress, 'practice_api/getUserInfo.php');
      var response =
          await http.post(url, body: {'token': prefs.getString('token')});
      var result = jsonDecode(response.body);
      if (result['success']) {
        user = userFromJson(jsonEncode(result['data']));
        update();
      } else {
        Get.showSnackbar(GetSnackBar(
          backgroundColor: Colors.red,
          message: result['message'],
          duration: Duration(seconds: 3),
        ));
      }
    } catch (e) {
      print(e);
      Get.showSnackbar(GetSnackBar(
        backgroundColor: Colors.red,
        message: "User ko info fetch vayena controller bata",
        duration: Duration(seconds: 3),
      ));
    }
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    prefs = await SharedPreferences.getInstance();
    getUserInfo();
  }

  void increment() => count.value++;
}
