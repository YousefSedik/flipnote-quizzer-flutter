import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/modules/login/login_service.dart';

class LoginController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  LoginService services = Get.put(LoginService());
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;

  void login() async {
    services.login(emailController.text, passwordController.text);
  }
  void setLoading(bool value) {
    isLoading = value;
    update();
  }
}
