import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:project/modules/login/login_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final storage = const FlutterSecureStorage();
  LoginService services = Get.put(LoginService());

  final formKey = GlobalKey<FormState>();
  bool isLoading = false;

  void login() async {
    bool succeed = await services.login(
      emailController.text,
      passwordController.text,
    );
    if (succeed) {
      // get account type
      String? data = await storage.read(key: "profile");
      print(data ?? "No profile data found");
      Get.offAllNamed('/home');
    } else {
      Get.snackbar(
        "Error",
        "Login failed. Please check your credentials.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    }
  }

  void setLoading(bool value) {
    isLoading = value;
    update();
  }
}
