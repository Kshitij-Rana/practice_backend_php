import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:getxpractice/app/model/user.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(ProfileController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('ProfileView'),
        centerTitle: true,
      ),
      body: GetBuilder<ProfileController>(
        init: ProfileController(),
        builder: (controller) => Column(
          children: [
            Container(
              height: 400,
              width: 300,
              child: ListView(
                shrinkWrap: true,
                children: [ProfileCard(user: controller.user!)],
              ),
            ),
            Center(
              child: Column(
                children: [
                  ElevatedButton(
                      onPressed: () {
                        controller.onLogOut();
                      },
                      child: Text("Log Out"))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key, required this.user});
  final User user;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text('Name: ${user.fullName}'),
          Text('Email: ${user.email}')
        ],
      ),
    );
  }
}
