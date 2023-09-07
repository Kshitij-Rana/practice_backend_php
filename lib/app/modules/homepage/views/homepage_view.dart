import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:getxpractice/app/components/admin_product_card.dart';
import 'package:getxpractice/app/components/product_card.dart';
import 'package:getxpractice/app/model/product.dart';

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
        actions: [
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: SearchView());
              },
              icon: Icon(Icons.search))
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              // ElevatedButton(
              //     onPressed: () {
              //       controller.onLogOut();
              //     },
              //     child: const Text(
              //       'Logout',
              //       style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              //     )),
              // Form(
              //     key: controller.productFormKey,
              //     child: Column(
              //       children: [
              //         const SizedBox(
              //           height: 30,
              //         ),
              //         TextFormField(
              //           controller: controller.productNameController,
              //           decoration: const InputDecoration(
              //               hintText: "Product Name",
              //               border: OutlineInputBorder()),
              //         ),
              //         const SizedBox(
              //           height: 20,
              //         ),
              //         TextFormField(
              //           controller: controller.priceController,
              //           decoration: const InputDecoration(
              //               hintText: "Price", border: OutlineInputBorder()),
              //         ),
              //         const SizedBox(
              //           height: 20,
              //         ),
              //         TextFormField(
              //           controller: controller.descriptionController,
              //           decoration: const InputDecoration(
              //               hintText: "Description",
              //               border: OutlineInputBorder()),
              //         ),
              //         const SizedBox(
              //           height: 20,
              //         ),
              //         ElevatedButton(
              //             onPressed: () {}, child: const Text('Add Product'))
              //       ],
              //     )),
              GetBuilder<HomepageController>(
                builder: (controller) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 40,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: controller.categories?.length ?? 0,
                            itemBuilder: (context, index) {
                              return SizedBox(
                                width: 100,
                                child: Container(
                                  margin: const EdgeInsets.only(right: 10),
                                  decoration: BoxDecoration(
                                      color: Colors.amber,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Center(
                                    child: Text(
                                      controller.categories?[index]
                                              .categoryTitle ??
                                          '',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        controller.products == null
                            ? const Center(child: CircularProgressIndicator())
                            : GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: controller.products?.length ?? 0,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 10,
                                        mainAxisSpacing: 10),
                                itemBuilder: (context, index) => SizedBox(
                                  child: Container(
                                      margin: const EdgeInsets.all(10),
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                                blurRadius: 2,
                                                color: Colors.grey.shade300,
                                                offset: const Offset(4, 4),
                                                spreadRadius: 2)
                                          ]),
                                      child: productCard(
                                          product:
                                              controller.products![index])),
                                ),
                              )
                      ],
                    ),
                  );
                },
              ),
              // ElevatedButton(
              //     onPressed: () {
              //       controller.onLogOut();
              //     },
              //     child: Text('LogOut'))
            ],
          ),
        ),
      ),
    );
  }
}

HomepageController controller = Get.find();

class SearchView extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildSuggestions(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Product> suggestions = [];
    suggestions = query.length == 0
        ? []
        : controller.products
                ?.where((element) =>
                    element.title
                        ?.toLowerCase()
                        .contains(query.toLowerCase()) ??
                    false)
                .toList() ??
            [];

    if (query.length == 0) {
      return Center(
          child: Text(
        'Search your fav products',
        style: TextStyle(fontSize: 17),
      ));
    } else if (query.length > 0 && suggestions.isEmpty) {
      return Center(
        child: Text(
          "No results found",
          style: TextStyle(fontSize: 17),
        ),
      );
    }

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) =>
          adminProductCard(product: suggestions[index]),
    );
  }
}
