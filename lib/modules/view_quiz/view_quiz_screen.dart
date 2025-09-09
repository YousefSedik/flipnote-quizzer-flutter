import 'package:flutter/material.dart';
import 'package:project/widgets/app_bar.dart';
import 'package:project/widgets/black_button.dart';
import 'package:project/widgets/quiz_list_viewer.dart';

class Quiz extends StatefulWidget {
  Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    List questions = args['questions'] ?? [];
    print("questions are $questions");
    return Scaffold(
      appBar: getAppBar(title: args['title']!),
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
                      setState(() {
                        print("Shuffling ques");
                        questions.shuffle();
                        for (var q in questions) {
                          if (q['type'] == 'mcq') {
                            q['choices'].shuffle();
                          }
                        }
                      });
                    },
                  ),
                ),
                QuizListViewer(questions: questions, id: args['id']!),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
