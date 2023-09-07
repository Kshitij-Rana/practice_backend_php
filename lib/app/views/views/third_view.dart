import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:getxpractice/app/modules/onboarding/controllers/onboarding_controller.dart';

class ThirdView extends GetView {
  const ThirdView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(OnboardingController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('ThirdView'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            // ignore: prefer_const_constructors
            Text(
              'ThirdView is working',
              style: const TextStyle(fontSize: 20),
            ),
            ElevatedButton(
                onPressed: controller.nextPage, child: const Text("Okay"))
          ],
        ),
      ),
    );
  }
}
