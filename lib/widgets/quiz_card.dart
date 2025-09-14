import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/modules/home/home_controller.dart';

class QuizCard extends StatelessWidget {
  QuizCard({
    super.key,
    this.isVisible = true,
    required this.id,
    required this.title,
    required this.description,
    required this.author,
    required this.createdAt,
    required this.isPublic,
    required this.timeSince,
  });
  final String id;
  final String title;
  final String description;
  final String author;
  final String createdAt;
  final bool isPublic;
  final String? timeSince;

  bool isVisible = true;
  void deleteCard(String id) async {
    await controller.deleteQuiz(id);
  }

  final HomeController controller = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisible,
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
                      title,
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
              Text(description, style: TextStyle(color: Colors.black54)),

              const SizedBox(height: 10),
              Row(
                children: [
                  Icon(Icons.person_outline, size: 16, color: Colors.black54),
                  Text(
                    "Created by ${author}",
                    style: TextStyle(fontSize: 13, color: Colors.black87),
                  ),
                ],
              ),

              const SizedBox(height: 4),
              Text(
                "Created ${timeSince}",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),

              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(Icons.delete_outline),
                    onPressed: () {
                      deleteCard(id);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit_outlined),
                    onPressed: () async {
                      await Get.toNamed(
                        "/quiz/edit",
                        arguments: {
                          'id': id,
                          'title': title,
                          'description': description,
                          'isPublic': isPublic,
                        },
                      );
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
                        Get.toNamed(
                          "/quiz/play",
                          arguments: {
                            'id': id,
                            'title': title,
                            'description': description,
                          },
                        );
                        controller.fetchQuizzes();
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
        color: isPublic ? Colors.green.shade100 : Colors.red.shade100,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        isPublic ? "Public" : "Private",
        style: TextStyle(
          color: isPublic ? Colors.green : Colors.red,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
