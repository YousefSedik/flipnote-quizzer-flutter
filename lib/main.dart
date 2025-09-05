import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:project/pages/create_quiz.dart';
import 'package:project/pages/edit_quiz.dart';
import 'package:project/pages/home.dart';
import 'package:project/pages/login.dart';
import 'package:project/pages/quiz.dart';
import 'package:project/pages/signup.dart';
import 'package:project/pages/splash.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await dotenv.load();
  } catch (e) {
    throw Exception('Error loading .env file: $e');
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flipnote Quizzer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const SplashPage(),
      getPages: [
        GetPage(name: "/login", page: () => LoginPage()),
        GetPage(name: "/signup", page: () => SignUpPage()),
        GetPage(name: "/home", page: () => HomePage()),
        GetPage(name: "/quiz/edit", page: () => EditQuizPage()),
        GetPage(name: "/quiz/create", page: () => CreateQuizPage()),
        GetPage(name: "/quiz/play", page: () => Quiz()),
      ],
    );
  }
}
