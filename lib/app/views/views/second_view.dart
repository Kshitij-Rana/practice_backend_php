import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:getxpractice/app/modules/onboarding2/controllers/onboarding2_controller.dart';

class SecondView extends GetView {
  const SecondView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(Onboarding2Controller());
    return Scaffold(
      appBar: AppBar(
        title: const Text('SecondView'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            const Text(
              'SecondView is working',
              style: TextStyle(fontSize: 20),
            ),
            ElevatedButton(
                onPressed: controller.nextpage, child: const Text("NextPage"))
          ],
        ),
      ),
    );
  }
}
