import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:get/get.dart';
import 'package:getxpractice/app/modules/onboarding2/controllers/onboarding2_controller.dart';

class FirstView extends GetView {
  const FirstView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(Onboarding2Controller());
    return Scaffold(
      appBar: AppBar(
        title: const Text('FirstView'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const Center(
            child: Text(
              'FirstView is working',
              style: TextStyle(fontSize: 20),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              controller.nextpage(
              
              );
            

            },
            child: const Text("Next"),
          )
        ],
      ),
    );
  }
}
