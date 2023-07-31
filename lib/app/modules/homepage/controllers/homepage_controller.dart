import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxpractice/app/constants.dart';
import 'package:getxpractice/app/routes/app_pages.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class HomepageController extends GetxController {
  final count = 0.obs;
  late final SharedPreferences prefs;
  GlobalKey<FormState> categoryFormKey = GlobalKey<FormState>();
  TextEditingController categorycontroller = TextEditingController();

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    prefs = await SharedPreferences.getInstance();
  }

  Future<void> onLogOut() async {
    await prefs.remove('token');
    Get.offAllNamed(Routes.LOGIN);
  }

  void increment() => count.value++;
  Future<void> addCateory() async {
    try {
      if (categoryFormKey.currentState!.validate()) {
        var url = Uri.http(ipAdress, 'practice_api/addCategory.php');
        var response = await http.post(url, body: {
          'token': prefs.getString('token'),
          'title': categorycontroller.text
        });
        var result = jsonDecode(response.body);
        print(result);

        if (result['success']) {
           Get.showSnackbar(GetSnackBar(
            backgroundColor: Colors.green,
            message: result['message'],
            duration: Duration(seconds: 3),
          ));
        } else {
          Get.showSnackbar(GetSnackBar(
            backgroundColor: Colors.red,
            message: result['message'],
            duration: Duration(seconds: 3),
          ));
        }
      }
    } catch (e) {
      print(e);
      Get.showSnackbar(GetSnackBar(
        duration: Duration(seconds: 3),
        backgroundColor: Colors.red,
        message: "Something awrong",
      ));
    }
  }
}
void getCategories(){
  
}
