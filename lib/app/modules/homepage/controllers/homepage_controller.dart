import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:getxpractice/app/model/category.dart';
import 'package:getxpractice/app/model/product.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxpractice/app/components/constants.dart';
import 'package:getxpractice/app/routes/app_pages.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class HomepageController extends GetxController {
  List<Welcome>? categories;
  List<Product>? products;
  final count = 0.obs;
  late final SharedPreferences prefs;
  //For Category
  GlobalKey<FormState> categoryFormKey = GlobalKey<FormState>();
  TextEditingController categorycontroller = TextEditingController();
  //For Product
  GlobalKey<FormState> productFormKey = GlobalKey<FormState>();
  final ImagePicker picker = ImagePicker();
  XFile? image;
  var imagebytes = Uint8List(0).obs;
  TextEditingController productNameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  var selectedCategory = ''.obs;
  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    prefs = await SharedPreferences.getInstance();
    getCategories();
    getProduct();
  }

  Future<void> pickImage() async {
    try {
      image = await picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        imagebytes.value = await image!.readAsBytes();
        update();
      }
    } catch (e) {
      Get.showSnackbar(GetSnackBar(
        message: "Image upload failed",
        backgroundColor: Colors.red,
      ));
    }
  }

  void onLogOut() async {
    await prefs.remove('token');
    await prefs.clear();
    Get.offAllNamed(Routes.LOGIN);
  }

  void increment() => count.value++;
  void addCateory() async {
    try {
      if (categoryFormKey.currentState!.validate()) {
        var url = Uri.http(ipAdress, 'practice_api/addCategory.php');
        var response = await http.post(url, body: {
          'token': prefs.getString('token'),
          'title': categorycontroller.text
        });
        var result = jsonDecode(response.body);
        update();

        if (result['success']) {
          getCategories();
          Get.showSnackbar(GetSnackBar(
            backgroundColor: Colors.green,
            message: result['message'],
            duration: const Duration(seconds: 3),
          ));
          categorycontroller.clear();
        } else {
          Get.showSnackbar(GetSnackBar(
            backgroundColor: Colors.red,
            message: result['message'],
            duration: const Duration(seconds: 3),
          ));
        }
      }
    } catch (e) {
      Get.showSnackbar(const GetSnackBar(
        duration: Duration(seconds: 3),
        backgroundColor: Colors.red,
        message: "Something awrong",
      ));
    }
  }

  void getCategories() async {
    try {
      var url = Uri.http(ipAdress, 'practice_api/getCategory.php');

      var response = await http.get(url);

      var result = jsonDecode(response.body);

      if (result['success']) {
        // Get.showSnackbar(GetSnackBar(
        //     backgroundColor: Colors.green,
        //     message: result['message'],
        //     duration: const Duration(seconds: 3)));
        categories = welcomeFromJson(jsonEncode((result['data'])));
        update();
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
        message: "Bigriyo hai",
        duration: Duration(seconds: 3),
      ));
    }
  }

  void getProduct() async {
    try {
      var url = Uri.http(ipAdress, 'practice_api/getProduct.php');
      var response = await http.get(url);
      var result = jsonDecode(response.body);

      if (result['success']) {
        // Get.showSnackbar(GetSnackBar(
        //   message: result['message'],
        //   backgroundColor: Colors.green,
        //   duration: const Duration(seconds: 3),
        // ));
        products = productFromJson(jsonEncode(result['data']));
        update();
      } else {
        Get.showSnackbar(GetSnackBar(
          message: result['message'],
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        ));
      }
    } catch (e) {
      Get.showSnackbar(const GetSnackBar(
        duration: Duration(seconds: 3),
        message: "Something went wrong",
        backgroundColor: Colors.red,
      ));
    }
  }

  Future<void> addProduct() async {
    try {
      if (productFormKey.currentState!.validate()) {
        var url = Uri.http(ipAdress, 'practice_api/addProduct.php');
        var form = http.MultipartRequest('POST', url);
        form.fields['token'] = prefs.getString('token')!;
        form.fields['title'] = productNameController.text;
        form.fields['price'] = priceController.text;
        form.fields['description'] = descriptionController.text;
        form.fields['category'] = selectedCategory.value;
        form.files.add(http.MultipartFile.fromBytes('image', imagebytes.value,
            filename: image!.name));

        var response = await http.Response.fromStream(await form.send());

        var data = jsonDecode(response.body);
        if (data["success"]) {
          Get.back();
          getProduct();
          update();

          Get.showSnackbar(GetSnackBar(
            message: data['message'],
            backgroundColor: Colors.green,
            duration: Duration(seconds: 3),
          ));
        } else {
          Get.showSnackbar(GetSnackBar(
            message: data['message'],
            backgroundColor: Colors.red,
            duration: Duration(seconds: 3),
          ));
        }
      }
    } catch (e) {
      Get.showSnackbar(GetSnackBar(
        message: 'Something went wrong homepage',
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
      ));
    }
  }
}
