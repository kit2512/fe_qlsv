import 'package:admin/features/login/presentation/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared/shared.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Page"),
      ),
      body: Center(
        child: Obx(
          () => CommonLoginForm(
            onSubmit: controller.login,
            errorMessage: controller.errorMessage.value,
            isLoading: Get.find<LoadingController>().isLoading.value,
          ),
        ),
      ),
    );
  }
}
