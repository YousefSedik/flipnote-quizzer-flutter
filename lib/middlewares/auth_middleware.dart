import 'package:flutter/material.dart';
import 'package:project/api/api.dart';
import 'package:get/get.dart';

class AuthMiddleware extends GetMiddleware {
  AuthController authController = Get.put<AuthController>(AuthController());
  
  @override
  RouteSettings? redirect(String? route) {
    try {
      if (authController.isAuthenticated) {
        // check if the user is a teacher or student
        if (authController.accountType == 'teacher') {
          return RouteSettings(name: '/teacherHome');
        } else if (authController.accountType == 'student') {
          return RouteSettings(name: '/home');
        }
      }
      return RouteSettings(name: '/login');
    } catch (e) {
      return RouteSettings(name: '/login');
    }
  }
}

class AuthController extends GetxController {
  ApiClient api = ApiClient();
  late bool isAuthenticated;
  late String accountType;

  @override
  void onInit() async {
    final response = await api.getProfile();
    try {
      if (response.statusCode == 200) {
        // check if the user is a teacher or student
        String accountType = response.data['account_type'];
        if (accountType == 'teacher') {
          isAuthenticated = true;
          this.accountType = 'teacher';
        } else if (accountType == 'student') {
          isAuthenticated = true;
          this.accountType = 'student';
        }
      }
      isAuthenticated = false;
    } catch (e) {
      isAuthenticated = false;
    }
    super.onInit();
  }
}
