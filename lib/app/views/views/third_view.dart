import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:getxpractice/app/modules/onboarding2/controllers/onboarding2_controller.dart';

class ThirdView extends GetView {
  const ThirdView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(Onboarding2Controller());
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
                onPressed: controller.nextpage, child: const Text("Okay"))
          ],
        ),
      ),
    );
  }
}
