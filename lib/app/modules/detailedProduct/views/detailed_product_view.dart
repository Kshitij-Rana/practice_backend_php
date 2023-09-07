import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:getxpractice/app/components/constants.dart';
import 'package:getxpractice/app/model/product.dart';
import 'package:getxpractice/app/modules/cart/controllers/cart_controller.dart';

import '../controllers/detailed_product_controller.dart';

class DetailedProductView extends GetView<DetailedProductController> {
  const DetailedProductView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var product = Get.arguments as Product;
    var cartController = Get.find<CartController>();
    return Scaffold(
        appBar: AppBar(
          title: Text(product.title?.toUpperCase() ?? ''),
          centerTitle: true,
        ),
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Column(
            children: [
              Image.network(
                getImageUrl(product.image),
                // width: double.infinity,
                width: MediaQuery.of(context).size.width,
                height: Get.height * 0.3,
                fit: BoxFit.cover,
              )
            ],
          ),
          Container(
            margin: EdgeInsets.only(left: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title ?? '',
                  style: const TextStyle(fontSize: 25),
                ),
                Text(product.description ?? '', style: TextStyle(fontSize: 20)),
                Text('Rs. ${product.price}', style: TextStyle(fontSize: 20))
              ],
            ),
          ),
          Obx(
            () => Row(
              children: [
                controller.quantity == 1
                    ? const Padding(
                        padding: EdgeInsets.only(right: 12, left: 9),
                        child: Icon(
                          Icons.remove_circle_outline_outlined,
                          size: 30,
                          color: Colors.black45,
                        ),
                      )
                    : IconButton(
                        onPressed: () {
                          if (controller.quantity > 1) {
                            controller.quantity--;
                          }
                        },
                        icon: const Icon(
                          Icons.remove_circle_outline_outlined,
                          size: 30,
                        )),
                Text(
                  controller.quantity.toString(),
                  style: const TextStyle(fontSize: 25),
                ),
                IconButton(
                    onPressed: () {
                      controller.quantity++;
                    },
                    icon: const Icon(
                      Icons.add_circle_outline_outlined,
                      size: 30,
                    ))
              ],
            ),
          )
        ]));
  }
}
