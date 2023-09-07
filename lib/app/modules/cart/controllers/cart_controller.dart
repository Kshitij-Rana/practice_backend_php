import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxpractice/app/components/constants.dart';
import 'package:getxpractice/app/model/product.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CartController extends GetxController {
  late final SharedPreferences? prefs;
  List<CartItem> cart = [];
  var total = 0.0.obs;

  void addProduct({required Product product, int? quantity}) {
    if (cart.any((element) => element.product.productId == product.productId)) {
      Get.showSnackbar(const GetSnackBar(
        message: 'This product is already added',
        duration: Duration(seconds: 3),
        backgroundColor: Colors.red,
      ));
      return;
    }
    cart.add(CartItem(product: product, quantity: quantity ?? 1));
    updateTotal();
    updateLocal();
    update();

    Get.showSnackbar(const GetSnackBar(
      backgroundColor: Colors.green,
      message: "Product has been added to the cart",
      duration: Duration(seconds: 3),
    ));
  }

  final count = 0.obs;

  void increment() => count.value++;
  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    prefs = await SharedPreferences.getInstance();
    mapCart();
  }

  String? getMyCart() {
    return prefs != null ? prefs!.getString('cart') : null;
  }

  void setMyCart(String cart) {
    prefs!.setString('cart', cart);
  }

  void mapCart() {
    var cart = jsonDecode(getMyCart() ?? '[]') as List<dynamic>;
    this.cart = cart
        .map((e) => CartItem(
            product: Product.fromJson(e['product']), quantity: e['quantity']))
        .toList();
    updateTotal();
  }

  void updateTotal() {
    total.value = 0;
    cart.forEach((element) {
      total.value = total.value +
          double.parse(element.product.price!) * element.quantity!;
    });
  }

  void updateLocal() {
    setMyCart(jsonEncode(cart
        .map((e) => {
              'product': e.product.toJson(),
              'quantity': e.quantity,
            })
        .toList()));
  }

  void removeProduct(int index) {
    cart.removeAt(index);
    updateLocal();
    updateTotal();
    update();
  }

  Future<int?> makeOrder() async {
    try {
      var url = Uri.http(ipAdress, 'practice_api/createOrder.php');
      var response = await http.post(url, body: {
        'token': prefs != null ? prefs!.getString('token') : null,
        'total': total.value.toString(),
        'cart': getMyCart(),
      });
      var result = jsonDecode(response.body);
      if (result['success']) {
        Get.showSnackbar(GetSnackBar(
          backgroundColor: Colors.green,
          message: result['message'],
          duration: Duration(seconds: 3),
        ));
        return result['order_id'];
      } else {
        Get.showSnackbar(GetSnackBar(
          backgroundColor: Colors.red,
          message: result['message'],
          duration: const Duration(seconds: 3),
        ));
      }
    } catch (e) {
      print(e);
      Get.showSnackbar(const GetSnackBar(
        backgroundColor: Colors.red,
        message: 'Something went wrong',
        duration: Duration(seconds: 3),
      ));
    }
    return null;
  }

  Future<void> makePayment(
      {required String amount,
      required String orderId,
      required String otherData}) async {
    try {
      var url = Uri.http(ipAdress, 'practice_api/payment.php');
      var response = await http.post(url, body: {
        'token': prefs != null ? prefs!.getString('token') : null,
        'amount': amount,
        'order_id': orderId,
        'other_data': otherData,
      });

      var result = jsonDecode(response.body);
      if (result['success']) {
        cart.clear();
        setMyCart('[]');
        updateTotal();
        Get.showSnackbar(GetSnackBar(
          message: result['message'],
          duration: const Duration(seconds: 3),
          backgroundColor: Colors.green,
        ));
      } else {
        Get.showSnackbar(GetSnackBar(
          backgroundColor: Colors.red,
          message: result['message'],
          duration: const Duration(seconds: 3),
        ));
      }
    } catch (e) {
      Get.showSnackbar(const GetSnackBar(
        backgroundColor: Colors.red,
        message: 'Something went wrong',
        duration: Duration(seconds: 3),
      ));
    }
    return;
  }
}

class CartItem {
  final Product product;
  final int? quantity;
  CartItem({required this.product, this.quantity = 1});
}
