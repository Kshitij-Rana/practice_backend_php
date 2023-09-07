import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxpractice/app/components/constants.dart';
import 'package:getxpractice/app/routes/app_pages.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  late final SharedPreferences prefs;

  GlobalKey<FormState> LoginFormKey = GlobalKey<FormState>();
  RegExp regex =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var isview = false.obs;

  final count = 0.obs;
  @override
  void onInit() async {
    super.onInit();
    prefs = await SharedPreferences.getInstance();
  }

  void login() async {
    if (LoginFormKey.currentState!.validate()) {
      try {
        var url = Uri.http(ipAdress, 'practice_api/auth/login.php');
        var response = await http.post(url, body: {
          'email': emailController.text,
          'password': passwordController.text,
        });

        var result = jsonDecode(response.body);
        if (result['success']) {
          await prefs.setString('role', result['role']);
          await prefs.setString('token', result['token']);
          if (result['role'] == 'admin') {
            Get.offAllNamed(Routes.ADMIN_MAIN);
          } else {
            Get.offAllNamed(Routes.HOME);
          }

          Get.showSnackbar(GetSnackBar(
            backgroundColor: Colors.green,
            message: result['message'],
            duration: const Duration(seconds: 3),
          ));
        } else {
          Get.showSnackbar(GetSnackBar(
            backgroundColor: Colors.red,
            message: result['message'],
            duration: const Duration(seconds: 3),
          ));
        }
      } catch (e) {
        Get.showSnackbar(const GetSnackBar(
          backgroundColor: Colors.red,
          message: 'Something went wrong',
          duration: Duration(seconds: 3),
        ));
      }
    }
  }

  void increment() => count.value++;
}
