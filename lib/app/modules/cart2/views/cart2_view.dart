import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:getxpractice/app/components/constants.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

import '../controllers/cart2_controller.dart';

class Cart2View extends GetView<Cart2Controller> {
  const Cart2View({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Cart2View'),
          centerTitle: true,
        ),
        body: GetBuilder<Cart2Controller>(
          builder: (controller) => Column(
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                child: SizedBox(
                  height: 300,
                  child: ListView.builder(
                    itemCount: controller.cart.length,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 2,
                                  color: Colors.grey.shade300,
                                  offset: const Offset(4, 4),
                                  spreadRadius: 2)
                            ]),
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.all(10),
                        child: SizedBox(
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Image.network(
                                  getImageUrl(
                                      controller.cart[index].product.image),
                                  fit: BoxFit.cover,
                                  height: 100,
                                  width: 100,
                                ),
                              ),
                              Expanded(
                                  flex: 2,
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                        left: 20, top: 10, bottom: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          controller.cart[index].product.title
                                                  ?.toUpperCase() ??
                                              '',
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          controller.cart[index].product
                                                  .description ??
                                              '',
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "Rs ${controller.cart[index].product.price ?? ''}",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w500),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Text("Quantity:"),
                                            GestureDetector(
                                              onTap: () {
                                                controller
                                                    .subtractQuantity(index);
                                              },
                                              child: Icon(Icons.remove_circle),
                                            ),
                                            Text(
                                                "${controller.cart[index].quantity}"),
                                            GestureDetector(
                                              onTap: () {
                                                controller.addQuantity(
                                                    index,
                                                    controller
                                                        .cart[index].quantity);
                                              },
                                              child: Icon(Icons.add_circle),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  )),
                              Expanded(
                                child: Positioned(
                                    child: GestureDetector(
                                  onTap: () => controller.removeProduct2(index),
                                  child: Icon(Icons.close_rounded),
                                )),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 150,
                width: 300,
                child: Container(
                  decoration: BoxDecoration(color: Colors.grey.shade300),
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      const Text(
                        "Total value: ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17),
                      ),
                      Obx(() => Text("Rs ${controller.total.value}")),
                      KhaltiButton(
                        style: ButtonStyle(),
                        config: PaymentConfig(
                            amount: 2000,
                            productIdentity: "Jeans",
                            productName: "Jeans"),
                        onSuccess: (value) {},
                        onFailure: (value) {},
                        onCancel: () {
                          Get.showSnackbar(GetSnackBar(
                            message: "Payment Cancelled",
                            backgroundColor: Colors.red,
                            duration: Duration(seconds: 3),
                          ));
                        },
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
