import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/homepage_controller.dart';

class HomepageView extends GetView<HomepageController> {
  const HomepageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(HomepageController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomepageView'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  controller.onLogOut();
                },
                child: const Text(
                  'Logout',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                )),
            Form(
              key: controller.categoryFormKey,
              child: Column(
                children: [
                  SizedBox(
                      height: 30,
                      width: 350,
                      child: TextFormField(
                        controller: controller.categorycontroller,
                        decoration:
                            InputDecoration(border: OutlineInputBorder()),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter the category you want to enter";
                          }
                          return null;
                        },
                      )),
                  ElevatedButton(
                      onPressed: controller.addCateory,
                      child: Text('Add category'))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
