import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxpractice/app/components/constants.dart';
import 'package:getxpractice/app/model/product.dart';
import 'package:getxpractice/app/modules/admin_product/controllers/admin_product_controller.dart';

class adminProductCard extends StatelessWidget {
  final Product product;
  const adminProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<AdminProductController>();

    return Container(
      height: 75,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            blurRadius: 2,
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            offset: const Offset(0, 3))
      ]),
      child: Row(
        children: [
          Image.network(
            getImageUrl(product.image ?? ''),
            width: 75,
            height: 70,
            fit: BoxFit.cover,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(product.title ?? ''),
          Spacer(),
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => DeleteproductDialog(
                  productId: product.productId!,
                  product: product,
                ),
              );
            },
            icon: product.inStock == 0
                ? Icon(
                    Icons.toggle_off_rounded,
                    color: Colors.red,
                  )
                : Icon(Icons.toggle_on_rounded),
            color: Colors.green,
          )
        ],
      ),
    );
  }
}

class DeleteproductDialog extends StatelessWidget {
  final String productId;
  final Product product;
  const DeleteproductDialog(
      {super.key, required this.productId, required this.product});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<AdminProductController>();
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Are you sure you want to delete this product?"),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(product.inStock),
                TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text('No')),
                SizedBox(
                  width: 100,
                ),
                TextButton(
                    onPressed: () {
                      if (product.inStock == 1) {
                        controller.onDeletelaiAdd(productId: productId);
                      } else {
                        controller.onDeleteClicked(productId: productId);
                      }
                    },
                    child: Text('Yes')),
              ],
            )
          ],
        ),
      ),
    );
  }
}
