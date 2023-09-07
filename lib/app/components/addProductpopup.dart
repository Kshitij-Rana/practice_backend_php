import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxpractice/app/modules/homepage/controllers/homepage_controller.dart';

class addProductPopup extends StatelessWidget {
  const addProductPopup({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomepageController());
    return GetBuilder<HomepageController>(
      builder: (controller) => Dialog(
        child: SingleChildScrollView(
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Form(
              key: controller.productFormKey,
              child: Container(
                padding: const EdgeInsets.all(18),
                child: Column(
                  children: [
                    const Text(
                      'Add Product',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    controller.imagebytes.value.isEmpty
                        ? SizedBox(
                            height: 40,
                            width: 150,
                            child: ElevatedButton(
                                onPressed: controller.pickImage,
                                child: const Text("Upload image")),
                          )
                        : SizedBox(
                            height: 200,
                            width: 200,
                            child: Image.memory(controller.imagebytes.value),
                          ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      controller: controller.productNameController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Enter your product name",
                          labelText: "Product Name"),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter name of the product';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      controller: controller.descriptionController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Enter description",
                          labelText: "Description"),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter product description!';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      controller: controller.priceController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Enter the price",
                          labelText: "Product Prce"),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter price for your product';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    controller.categories == null
                        ? const CircularProgressIndicator()
                        : DropdownButtonFormField(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                            hint: const Text("Select Category"),
                            items: controller.categories!
                                .map((e) => DropdownMenuItem(
                                    value: e.categoryId,
                                    child: Text(e.categoryTitle ?? '')))
                                .toList(),
                            onChanged: (value) {
                              controller.selectedCategory.value = value ?? '';
                            },
                          ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 50,
                      width: 250,
                      child: ElevatedButton(
                          onPressed: controller.addProduct,
                          child: const Text(
                            "Add Product",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          )),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
