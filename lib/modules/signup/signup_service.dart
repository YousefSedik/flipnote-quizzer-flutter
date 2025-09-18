import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/api/api.dart';

class SignupService extends GetxService {
  final apiClient = ApiClient();
  Future<bool> signUp(
    String username,
    String email,
    String password,
    String passwordConfirmation,
    String accountType,
  ) async {
    // true if all success, otherwise return map of errors
    final response = await apiClient.signup(
      username,
      email,
      password,
      passwordConfirmation,
      accountType,
    );
    if (response.statusCode == 201) {
      // if user is teacher, then account won't be activated until admin approves it, so we don't log them in automatically and show a message instead
      if (accountType == 'teacher') {
        Get.snackbar(
          "Success",
          "Account created successfully. Your account will be activated once an admin approves it.",
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 2),
          backgroundColor: Colors.black,
          colorText: Colors.white,
        );
        return true;
      }
      await apiClient.login(email, password);
      return true;
    } else if (response.statusCode == 400) {
      final Map<String, dynamic> data = response.data;
      for (var err in data.keys) {
        List errors = data[err] as List;
        Get.snackbar(
          err,
          errors.join(', '),
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 2),
          backgroundColor: Colors.black,
          colorText: Colors.white,
        );
      }
    } else {
      Get.snackbar(
        "Error",
        "An error occurred. Please try again.",
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 2),
        backgroundColor: Colors.black,
        colorText: Colors.white,
      );
    }
    return false;
  }
}


// middlewares => bindings => services => controller => screen 
