import 'package:flutter/material.dart';
import 'package:project/api/api.dart';
import 'package:project/components/black_button.dart';
import 'package:project/components/quiz_card.dart';
import 'package:project/models/quizModel.dart';

class MyQuizzesWidget extends StatefulWidget {
  MyQuizzesWidget({super.key});

  @override
  State<MyQuizzesWidget> createState() => _MyQuizzesWidgetState();
}

class _MyQuizzesWidgetState extends State<MyQuizzesWidget> {
  List<QuizModel> quizzes = [];
  final ApiClient apiClient = ApiClient();
  Future<List<QuizModel>> getQuizzes() async {
    List<QuizModel>? quizzes = [];
    return await apiClient.getQuizzes().then((response) {
      if (response.statusCode == 200) {
        final data = response.data['results'] as List;
        for (var item in data) {
          quizzes.add(QuizModel.fromJson(item));
        }
      }
      return quizzes;
    });
  }

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
                Text("(${quizzes.length} total)"),
                IconButton(
                  color: Colors.blue,
                  onPressed: () async {
                    quizzes = await getQuizzes();
                    setState(() {
                      quizzes = quizzes;
                    });
                  },
                  icon: Icon(Icons.refresh),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Column(
            children: [
              ...List.generate(quizzes.length, (index) {
                // print(quizzes[index].timeSince);
                return QuizCard(
                  id: quizzes[index].id!,
                  title: quizzes[index].title!,
                  description: quizzes[index].description!,
                  author: quizzes[index].author ?? "Unknown",
                  questionCount: 3,
                  createdAt: quizzes[index].createdAt!,
                  isPrivate: quizzes[index].isPrivate!,
                  timeSince: quizzes[index].timeSince,
                );
              }),
              BlackButton(
                text: "Create Quiz",
                icon: Icon(Icons.add_circle_outline_sharp, color: Colors.white),
                onPressed: () {
                  Navigator.pushNamed(context, "/quiz/create");
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
