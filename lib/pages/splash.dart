import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:project/api/api.dart';
import 'package:project/pages/home.dart';
import 'package:project/pages/login.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Response>(
      future: ApiClient().getProfile(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasData && snapshot.data!.statusCode == 200) {
          return HomePage();
        } else {
          return LoginPage();
        }
      },
    );
  }
}