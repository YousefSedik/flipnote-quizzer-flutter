import 'package:flutter/material.dart';
import 'package:project/components/app_bar.dart';
import 'package:project/components/quiz_list_viewer.dart';

class Quiz extends StatelessWidget {
  const Quiz({super.key});

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
                // shuffle, edit if owner, delete 
                QuizListViewer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
