import 'package:flutter/material.dart';
import 'package:project/api/api.dart';
import 'package:get/get.dart';
import 'package:project/modules/signup/signup_service.dart';

enum AccountType { student, teacher }

class SignupController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmationController =
      TextEditingController();

  AccountType accountType = AccountType.student;
  final formKey = GlobalKey<FormState>();
  SignupService services = Get.put(SignupService());
  bool _isLoading = false;

  void setLoading(bool value) {
    _isLoading = value;
    update();
  }

  bool get isLoading => _isLoading;

  Future<void> signUp() async {
    bool response = await services.signUp(
      usernameController.text,
      emailController.text,
      passwordController.text,
      passwordConfirmationController.text,
      accountType == AccountType.student ? "student" : "teacher",
    );
    if (accountType == AccountType.student) {
      if (response == true) {
        Get.offAllNamed('/home');
      }
    } else {
      if (response == true) {
        Get.offAllNamed('/login'); // since teacher accounts need admin approval
      }
    }
  }
}
