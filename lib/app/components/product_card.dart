import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxpractice/app/components/constants.dart';
import 'package:getxpractice/app/model/product.dart';
import 'package:getxpractice/app/modules/cart/controllers/cart_controller.dart';
import 'package:getxpractice/app/modules/cart2/controllers/cart2_controller.dart';
import 'package:getxpractice/app/routes/app_pages.dart';

class productCard extends StatelessWidget {
  final Product product;
  const productCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    var cartController = Get.find<CartController>();
    var cart2Controller = Get.find<Cart2Controller>();
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.DETAILED_PRODUCT, arguments: product);
      },
      child: Stack(
        children: [
          Container(
            child: Column(children: [
              Expanded(
                  child: Image.network(
                getImageUrl(product.image ?? ''),
                width: double.infinity,
                fit: BoxFit.cover,
              )),
              Expanded(
                  child: Container(
                child: Column(children: [
                  Text(product.title?.toUpperCase() ?? ''),
                  Row(
                    children: [
                      Text('Rs${product.price ?? ''}'),
                      InkWell(
                        onTap: () {
                          cartController.addProduct(product: product);
                          cart2Controller.addProduct2(product: product);
                        },
                        child: Icon(Icons.add_shopping_cart_sharp),
                      ),
                    ],
                  )
                ]),
              ))
            ]),
          )
        ],
      ),
    );
  }
}
