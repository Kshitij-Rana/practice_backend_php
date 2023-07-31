import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxpractice/app/routes/app_pages.dart';
import 'package:http/http.dart' as http;

import '../../../constants.dart';

class RegisterController extends GetxController {
  var dropdownValue;
  GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RegExp regex =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

  final count = 0.obs;
  void register() async {
    if (registerFormKey.currentState!.validate()) {
      try {
        var url = Uri.http(ipAdress, 'practice_api/auth/register.php');
        print(url);

        var response = await http.post(url, body: {
          'full_name': nameController.text,
          'email': emailController.text,
          'password': passwordController.text,
        });

        var result = jsonDecode(response.body);

        if (result['success']) {
          Get.toNamed(Routes.LOGIN);
          Get.showSnackbar(GetSnackBar(
              backgroundColor: Colors.green,
              message: result['message'],
              duration: const Duration(seconds: 3)));
        } else {
          Get.showSnackbar(GetSnackBar(
            backgroundColor: Colors.red,
            message: result['message'],
            duration: const Duration(seconds: 3),
          ));
        }
      } catch (e) {
        print("Caught exception: $e");
        Get.showSnackbar(const GetSnackBar(
          backgroundColor: Colors.red,
          message: "Gaad fatyo wrong vayo",
          duration: Duration(seconds: 3),
        ));
      }
    }
  }

  void increment() => count.value++;
  void dropdownCallBack(String? selectedValue) {
    if (selectedValue is String) {
      dropdownValue = selectedValue;
    }
  }
}
