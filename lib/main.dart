import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:project/modules/create_quiz/create_quiz_bindings.dart';
import 'package:project/modules/home/home_bindings.dart';
import 'package:project/modules/login/login_screen.dart';
import 'package:project/modules/signup/signup_screen.dart';
import 'package:project/modules/create_quiz/create_quiz_screen.dart';
import 'package:project/modules/home/home_screen.dart';
import 'package:project/modules/edit_quiz/edit_quiz_screen.dart';
import 'package:project/modules/view_quiz/view_quiz_screen.dart';
import 'package:project/modules/splash/splash_screen.dart';
import 'package:get/get.dart';
import 'package:project/modules/edit_quiz/edit_quiz_bindings.dart';

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
      initialRoute: "/splash",
      getPages: [
        GetPage(name: "/login", page: () => LoginPage()),
        GetPage(name: "/signup", page: () => SignUpPage()),
        GetPage(name: "/home", page: () => HomePage(), binding: HomeBindings()),
        GetPage(name: "/quiz/edit", page: () => EditQuizPage(), binding: EditQuizBindings()),
        GetPage(name: "/quiz/create", page: () => CreateQuizPage(), binding: CreateQuizBindings()),
        GetPage(name: "/quiz/play", page: () => Quiz()),
        GetPage(name: "/splash", page: () => SplashPage(), )
      ],
    );
  }
}
