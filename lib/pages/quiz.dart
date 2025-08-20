import 'package:flutter/material.dart';
import 'package:project/components/app_bar.dart';
import 'package:project/components/quiz_list_viewer.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              children: [
                QuizListViewer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
