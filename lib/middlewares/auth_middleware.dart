// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:project/api/api.dart';

// class AuthMiddleware extends GetMiddleware {
//   ApiClient api = ApiClient();
//   @override
//   Future<RouteSettings?> redirect(String? route) {
//     // Check if the user is authenticated

//     final isAuthenticated = await api.isAuthenticated();
//     if (!isAuthenticated) {
//       return RouteSettings(name: '/login');
//     }
//     return RouteSettings(name: route);
//   }
// }
