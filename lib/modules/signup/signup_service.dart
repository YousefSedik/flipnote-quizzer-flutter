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
  ) async {
    // true if all success, otherwise return map of errors
    final response = await apiClient.signup(
      username,
      email,
      password,
      passwordConfirmation,
    );
    if (response.statusCode == 201) {
      await apiClient.login(username, password);
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
