import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:getxpractice/app/views/views/first_view.dart';
import 'package:getxpractice/app/views/views/second_view.dart';
import 'package:getxpractice/app/views/views/third_view.dart';

import '../controllers/onboarding2_controller.dart';

class Onboarding2View extends GetView<Onboarding2Controller> {
  const Onboarding2View({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: controller.pageController,
      physics: ClampingScrollPhysics(),
      children: const [SecondView(), ThirdView(), FirstView()],
    );
  }
}
