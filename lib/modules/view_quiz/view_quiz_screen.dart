import 'package:flutter/material.dart';
import 'package:project/modules/view_quiz/view_quiz_controller.dart';
import 'package:project/widgets/app_bar.dart';
import 'package:project/widgets/black_button.dart';
import 'package:project/widgets/quiz_list_viewer.dart';
import 'package:get/get.dart';

class Quiz extends StatelessWidget {
  ViewQuizController controller = Get.put<ViewQuizController>(
    ViewQuizController(quizId: Get.arguments['id']!),
  );
  @override
  Widget build(BuildContext context) {
    final String title = Get.arguments['title'] ?? 'Quiz';
    final String id = Get.arguments['id'];
    print("Viewing quiz $title with id $id");
    return Scaffold(
      appBar: getAppBar(title: title),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: BlackButton(
                    text: "Shuffle",
                    icon: Icon(Icons.shuffle_rounded),
                    onPressed: () {
                      print("Shuffling ques");
                      controller.questions.shuffle();
                      for (var q in controller.questions) {
                        if (q['type'] == 'mcq') {
                          q['choices'].shuffle();
                        }
                      }
                    },
                  ),
                ),
                QuizListViewer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
