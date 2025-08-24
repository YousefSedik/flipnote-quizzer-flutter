import 'package:flutter/material.dart';
import 'package:project/api/api.dart';
import 'package:project/pages/home.dart';
import 'package:project/pages/login.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 4), () {
      print("SplashPage: Authentication check complete.");
    });
    return FutureBuilder<bool>(
      future: ApiClient().isAuthenticated(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.data == true) {
          return const HomePage();
        } else {
          // return CreateQuizPage();
          return const HomePage();
          // return LoginPage();
        }
      },
    );
  }
}
