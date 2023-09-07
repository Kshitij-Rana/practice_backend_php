import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxpractice/app/modules/homepage/controllers/homepage_controller.dart';

class addCategoryPopup extends StatelessWidget {
  const addCategoryPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: GetBuilder<HomepageController>(
        builder: (controller) => Dialog(
          child: Container(
            width: 300,
            height: 300,
            decoration: const BoxDecoration(),
            child: Form(
              key: controller.categoryFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Add Category",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                      height: 50,
                      width: 200,
                      child: TextFormField(
                        controller: controller.categorycontroller,
                        decoration: const InputDecoration(
                            hintText: "Enter category Name",
                            labelText: "Category Name",
                            border: OutlineInputBorder()),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter the category you want to enter";
                          }
                          return null;
                        },
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: controller.addCateory,
                      child: const Text('Add category')),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
