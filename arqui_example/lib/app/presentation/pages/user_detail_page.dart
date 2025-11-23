import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/user_controller.dart';

class UserDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<UserController>();

    return Scaffold(
      appBar: AppBar(title: const Text('User Detail')),
      body: Obx(() {
        final user = controller.selectedUser.value;

        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (user == null) {
          return const Center(child: Text("No user selected"));
        }

        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('ID: ${user.id}', style: const TextStyle(fontSize: 20)),
              const SizedBox(height: 10),
              Text('Name: ${user.name}', style: const TextStyle(fontSize: 20)),
              const SizedBox(height: 10),
              Text('Email: ${user.email}', style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 10),
              Text('Website: ${user.website}', style: const TextStyle(fontSize: 18)),
            ],
          ),
        );
      }),
    );
  }
}
