import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/user_controller.dart';
import 'user_detail_page.dart';

class UserPage extends GetView<UserController> {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text('Users')),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.errorMessage.value.isNotEmpty) {
          return Center(
            child: Text(
              controller.errorMessage.value,
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

        final users = controller.users;

        if (users.isEmpty) {
          return const Center(child: Text("No users found"));
        }

        return ListView.builder(
          itemCount: users.length,
          itemBuilder: (_, index) {
            final user = users[index];

            return ListTile(
              title: Text(user.name),
              subtitle: Text('${user.email}  |  Website: ${user.website}'),
              onTap: () {
                controller.loadUserById(user.id);
                Get.to(() => UserDetailPage());
              },
            );
          },
        );
      }),
    );
  }
}
