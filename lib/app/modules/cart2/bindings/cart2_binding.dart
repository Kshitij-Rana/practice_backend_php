import 'package:get/get.dart';

import '../controllers/cart2_controller.dart';

class Cart2Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Cart2Controller>(
      () => Cart2Controller(),
    );
  }
}
