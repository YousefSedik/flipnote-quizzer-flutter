import 'package:flutter/material.dart';
import 'package:project/components/app_bar.dart';
import 'package:project/components/my_quizzes.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      body: SafeArea(
        child: ListView(children: [MyQuizzesWidget()]),
      ),
    );
  }
}
