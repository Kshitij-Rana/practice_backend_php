import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxpractice/app/modules/cart/controllers/cart_controller.dart';
import 'package:getxpractice/app/modules/cart2/controllers/cart2_controller.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  var token = prefs.getString('token');
  var role = prefs.getString('role');
  Get.put(CartController(), permanent: true);
  Get.put(Cart2Controller(), permanent: true);

  runApp(
    KhaltiScope(
      publicKey: "test_public_key_079a2f2576844ba2962c82378012eb4b",
      builder: (context, navigatorKey) => GetMaterialApp(
        navigatorKey: navigatorKey,
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('ne', 'NP'),
        ],
        localizationsDelegates: const [KhaltiLocalizations.delegate],
        debugShowCheckedModeBanner: false,
        title: "Application",
        initialRoute: token != null
            ? (role != null && role == 'admin')
                ? Routes.ADMIN_MAIN
                : Routes.HOME
            : AppPages.INITIAL,
        getPages: AppPages.routes,
      ),
    ),
  );
}
