import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxpractice/app/model/product.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Cart2Controller extends GetxController {
  //TODO: Implement Cart2Controller
  late final SharedPreferences? prefs;
  List<CartItem2> cart = [];
  var total = 0.0.obs;
  final ind_quantity = 1.obs;
  final count = 0.obs;
  void addProduct2({required Product product, int? quantity}) {
    if (cart.any((element) => element.product.productId == product.productId)) {
      Get.showSnackbar(GetSnackBar(
        message: "${product.title} is already added!",
        duration: Duration(seconds: 3),
        backgroundColor: Colors.red,
      ));

      // quantitt.value = 0;
      // cart.forEach((element) {
      //   quantitt.value = (element.quantity!) + 1;
      // });
      // updateLocal2();
      // updateTotal2();
      // update();
    } else {
      cart.add(CartItem2(product: product, quantity: quantity ?? 1));

      updateTotal2();
      updateLocal2();
      update();
    }
  }

  void subtractQuantity(int index) {
    if (cart.any((element) => element.quantity == 1)) {
      cart.removeAt(index);
      return;
    }
  }

  void addQuantity(int quantity,int index) {
    // int quantity = cart[index].quantity!;
    // quantity++;
    // print("Quantity: ${quantity}");
    if (quantity >= 0 && quantity < cart.length) {
      cart[index].quantity++;
    }

    updateTotal2();
    updateLocal2();
    update();
  }

  String? getmyCart2() {
    return prefs != null ? prefs!.getString('cart') : null;
  }

  void setMyCart2(String cart) {
    prefs!.setString('cart', cart);
  }

  void mapCart2() {
    var cart = jsonDecode(getmyCart2() ?? '[]') as List<dynamic>;
    this.cart = cart
        .map((e) => CartItem2(
            product: Product.fromJson(e['product']), quantity: e['quantity']))
        .toList();
    updateTotal2();
  }

  void updateTotal2() {
    total.value = 0;
    cart.forEach((element) {
      total.value = total.value +
          double.parse(element.product.price!) * element.quantity!;
    });
  }

  void updateLocal2() {
    setMyCart2(jsonEncode(cart
        .map((e) => {
              'product': e.product.toJson(),
              'quantity': e.quantity,
            })
        .toList()));
  }

  void removeProduct2(int index) {
    cart.removeAt(index);
    updateLocal2();
    updateTotal2();
    update();
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    prefs = await SharedPreferences.getInstance();
    mapCart2();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}

class CartItem2 {
  late final Product product;
  late final int quantity;
  CartItem2({required this.product, this.quantity = 1});
}
