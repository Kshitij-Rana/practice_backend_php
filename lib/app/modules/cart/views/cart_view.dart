import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:getxpractice/app/components/constants.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

import '../controllers/cart_controller.dart';

class CartView extends GetView<CartController> {
  const CartView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('CartView'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: GetBuilder<CartController>(
            builder: (controller) => Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 400,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller.cart.length,
                      itemBuilder: (context, index) => CartCard(
                        cartItem: controller.cart[index],
                        index: index,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                          blurRadius: 5,
                          spreadRadius: 7,
                          color: Colors.grey.shade200)
                    ]),
                    child: Column(
                      children: [
                        const Text(
                          "Your Total: ",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Rs.${controller.total.value}",
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        TextButton(
                            onPressed: () async {
                              var orderId = await controller.makeOrder();
                              if (orderId == null) {
                                return;
                              } else {
                                KhaltiScope.of(Get.context!).pay(
                                  preferences: [
                                    PaymentPreference.khalti,
                                    PaymentPreference.connectIPS
                                  ],
                                  config: PaymentConfig(
                                      amount: 1000,
                                      productIdentity: "Test Product",
                                      productName: "My test product"),
                                  onSuccess: (PaymentSuccessModel v) {
                                    controller.makePayment(
                                        amount: (v.amount / 100).toString(),
                                        orderId: orderId.toString(),
                                        otherData: v.toString());
                                    Get.showSnackbar(const GetSnackBar(
                                      message: "Payment successfull",
                                      backgroundColor: Colors.green,
                                      duration: Duration(seconds: 2),
                                    ));
                                  },
                                  onFailure: (value) {
                                    Get.showSnackbar(const GetSnackBar(
                                      message: "Payment failed",
                                      backgroundColor: Colors.red,
                                      duration: Duration(seconds: 2),
                                    ));
                                  },
                                  onCancel: () {
                                    Get.showSnackbar(const GetSnackBar(
                                      message: "Payment cancelled",
                                      backgroundColor: Colors.red,
                                      duration: Duration(seconds: 2),
                                    ));
                                  },
                                );
                              }
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: 40, left: 40),
                              padding: EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Pay with khalti"),
                                  Image.network(
                                    'https://raw.githubusercontent.com/khalti/khalti-flutter-sdk/master/assets/khalti_logo.png',
                                    height: 100,
                                    width: 100,
                                  ),
                                ],
                              ),
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

class CartCard extends StatelessWidget {
  final CartItem cartItem;
  final int index;
  const CartCard({super.key, required this.cartItem, required this.index});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(color: Colors.grey.shade100, boxShadow: [
            BoxShadow(
                blurRadius: 2,
                color: Colors.grey.shade300,
                offset: const Offset(0, 4),
                spreadRadius: 2)
          ]),
          child: Row(children: [
            Expanded(
                flex: 1,
                child: Image.network(
                  getImageUrl(cartItem.product.image),
                  fit: BoxFit.cover,
                  height: 70,
                  width: 100,
                )),
            Expanded(
                flex: 2,
                child: Container(
                  margin: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cartItem.product.title?.toUpperCase() ?? '',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Rs ${cartItem.product.price}',
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w400),
                      ),
                      Text('Quantity: ${cartItem.quantity}')
                    ],
                  ),
                ))
          ]),
        ),
        Positioned(
            right: 5,
            top: 10,
            child: IconButton(
                onPressed: () {
                  controller.removeProduct(index);
                },
                icon: const Icon(
                  Icons.close,
                  color: Colors.black,
                  size: 30,
                )))
      ],
    );
  }
}
