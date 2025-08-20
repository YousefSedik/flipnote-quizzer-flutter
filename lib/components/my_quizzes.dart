import 'package:flutter/material.dart';
import 'package:project/components/quiz_card.dart';

class MyQuizzesWidget extends StatelessWidget {
  const MyQuizzesWidget({super.key});

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
                Text("(1 total)"),
              ],
            ),
          ),
          const SizedBox(height: 16),
          QuizCard(
            title: 'Flutter Basics',
            description: 'Learn the basics of Flutter widgets and layouts',
            author: 'Yousef',
            questionCount: 10,
            createdAt: '2025-08-01',
            isPrivate: false,
          ),
          QuizCard(
            title: 'Dart Language',
            description: 'Test your Dart programming skills',
            author: 'Ali',
            questionCount: 15,
            createdAt: '2025-08-10',
            isPrivate: true,
          ),
          QuizCard(
            title: 'Data Structures',
            description: 'Questions on arrays, lists, and trees',
            author: 'Sara',
            questionCount: 20,
            createdAt: '2025-07-20',
            isPrivate: false,
          ),
          QuizCard(
            title: 'OOP Concepts',
            description: 'Quiz on classes, objects, and inheritance',
            author: 'Mona',
            questionCount: 12,
            createdAt: '2025-08-15',
            isPrivate: true,
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(8),
            ),
            margin: const EdgeInsets.symmetric(vertical: 16),
            child: TextButton(
              onPressed: () {
                Navigator.pushNamed(context, "/quiz/create");
              },

              style: ButtonStyle(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 6,
                children: [
                  Icon(Icons.add_circle_outline_sharp, color: Colors.white),
                  Text("Create Quiz", style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget CreateQuizWidget() {
    return Container();
  }
}
