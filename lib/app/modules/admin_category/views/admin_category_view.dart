import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:getxpractice/app/components/constants.dart';
import 'package:getxpractice/app/modules/homepage/controllers/homepage_controller.dart';

import '../controllers/admin_category_controller.dart';

class AdminCategoryView extends GetView<AdminCategoryController> {
  const AdminCategoryView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(AdminCategoryController());
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: GetBuilder<HomepageController>(
            init: HomepageController(),
            builder: (controller) {
              if (controller.products == null) {
                return CircularProgressIndicator();
              }
              return Column(
                children: [
                  SizedBox(
                    height: 57,
                    width: 390,
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.categories?.length ?? 0,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.only(
                              top: 10, bottom: 10, left: 15, right: 15),
                          decoration: BoxDecoration(
                              color: Colors.blue.shade100,
                              borderRadius: BorderRadius.circular(8)),
                          child: Column(
                            children: [
                              Text(
                                  controller.categories?[index].categoryTitle ??
                                      '')
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  GridView.builder(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        mainAxisExtent: 350),
                    itemCount: controller.products?.length ?? 0,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.all(30),
                        decoration:
                            BoxDecoration(color: Colors.white, boxShadow: [
                          BoxShadow(
                              color: Colors.grey.shade200,
                              blurRadius: 2,
                              offset: Offset(4, 4),
                              spreadRadius: 2),
                        ]),
                        child: SizedBox(
                          height: 400,
                          width: 200,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.network(
                                getImageUrl(
                                    controller.products?[index].image ?? ''),
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                              Text(controller.products?[index].title ?? ''),
                              Text(controller.products?[index].description ??
                                  ''),
                              Text(controller.products?[index].price ?? '')
                            ],
                          ),
                        ),
                      );
                    },
                  )
                ],
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          label: Text("Add Category"),
          icon: Icon(Icons.add),
          onPressed: controller.onCategoryAdd,
        ),
      ),
    );
  }
}
