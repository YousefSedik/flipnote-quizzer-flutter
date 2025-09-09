import 'package:flutter/material.dart';
import 'package:project/api/api.dart';
import 'package:project/modules/home/home_controller.dart';
import 'package:project/widgets/black_button.dart';
import 'package:project/widgets/quiz_card.dart';
import 'package:project/models/quizModel.dart';
import 'package:get/get.dart';

class MyQuizzesWidget extends StatelessWidget {
  MyQuizzesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        children: [
          Center(
            child: Row(
              spacing: 10,
              children: [
                Text(
                  "My Quizzes",
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 24),
                ),
                GetBuilder<HomeController>(
                  builder: (controller) {
                    return Text("(${controller.quizzes.length} total)");
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          GetBuilder<HomeController>(
            builder: (controller) {
              return Column(
                children: List.generate(controller.quizzes.length, (index) {
                  final quiz = controller.quizzes[index];
                  return QuizCard(
                    id: quiz.id!,
                    title: quiz.title!,
                    description: quiz.description!,
                    author: quiz.author ?? "Unknown",
                    questionCount:
                        quiz.MCQQuestions.length + quiz.writtenQuestions.length,
                    createdAt: quiz.createdAt!,
                    isPublic: quiz.isPublic,
                    timeSince: quiz.timeSince,
                  );
                }),
              );
            },
          ),
          SizedBox(height: 45),
        ],
      ),
    );
  }
}
