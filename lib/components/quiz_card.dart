import 'package:flutter/material.dart';
import 'package:project/api/api.dart';
import 'package:get/get.dart';
class QuizCard extends StatefulWidget {
  QuizCard({
    super.key,
    this.isVisible = true,
    required this.id,
    required this.title,
    required this.description,
    required this.author,
    required this.questionCount,
    required this.createdAt,
    required this.isPrivate,
    required this.timeSince,
  });
  final String id;
  final String title;
  final String description;
  final String author;
  final int questionCount;
  final String createdAt;
  final bool isPrivate;
  final String? timeSince;

  bool isVisible = true;

  @override
  State<QuizCard> createState() => _QuizCardState();
}

class _QuizCardState extends State<QuizCard> {
  final ApiClient apiClient = ApiClient();

  void deleteCard(String id) {
    apiClient.deleteQuiz(id).then((response) {
      if (response.statusCode == 204) {
        print("Quiz deleted successfully");
        setState(() {
          widget.isVisible = false;
        });
      } else {
        print("Failed to delete quiz");
      }
    });
  }

  Future<List> fetchQuestions(String id) async {
    List questions = [];
    final response = await apiClient.getQuestions(id);

    if (response.statusCode == 200) {
      final data = response.data as Map;
      for (var question in data["mcq_questions"]) {
        question['type'] = 'mcq';
        questions.add(question);
      }
      for (var question in data["written_questions"]) {
        question['type'] = 'written';
        questions.add(question);
      }
    } else {
      print("Failed to load questions");
    }
    // print("Fetched questions: $questions");
    return questions;
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.isVisible,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      widget.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  _privateTag,
                ],
              ),

              const SizedBox(height: 6),
              Text(widget.description, style: TextStyle(color: Colors.black54)),

              const SizedBox(height: 10),
              Row(
                children: [
                  Icon(Icons.person_outline, size: 16, color: Colors.black54),
                  Text(
                    "Created by ${widget.author}",
                    style: TextStyle(fontSize: 13, color: Colors.black87),
                  ),
                ],
              ),

              const SizedBox(height: 4),
              Text(
                "${widget.questionCount} questions",
                style: TextStyle(fontSize: 13, color: Colors.black87),
              ),

              const SizedBox(height: 4),
              Text(
                "Created ${widget.timeSince}",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),

              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(Icons.delete_outline),
                    onPressed: () {
                      deleteCard(widget.id);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit_outlined),
                    onPressed: () {
                      Get.toNamed("/quiz/edit", arguments: {
                        'id': widget.id,
                        'title': widget.title,
                        'description': widget.description,
                        'isPrivate': widget.isPrivate,
                      });
                    },
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.play_arrow, color: Colors.white),
                      onPressed: () async {
                        List questions = await fetchQuestions(widget.id);
                        Get.toNamed("/quiz/play", arguments: {
                          'id': widget.id,
                          'title': widget.title,
                          'description': widget.description,
                          'author': widget.author,
                          'questionCount': widget.questionCount,
                          'createdAt': widget.createdAt,
                          'isPrivate': widget.isPrivate,
                          'questions': questions,
                        });
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container get _privateTag {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: !widget.isPrivate ? Colors.green.shade100 : Colors.red.shade100,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        widget.isPrivate ? "Private" : "Public",
        style: TextStyle(
          color: widget.isPrivate ? Colors.red : Colors.green,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
