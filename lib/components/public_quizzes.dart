import 'package:flutter/material.dart';

class PublicQuizzes extends StatelessWidget {
  const PublicQuizzes({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            "Public Quizzes ",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Card(
            child: ListTile(
              title: Row(
                children: [
                  Text("Public Quiz 1"),
                  // Text()
                ],
              ),
              subtitle: Text("Description of Public Quiz 1"),
            ),
          ),
          Card(
            child: ListTile(
              title: Text("Public Quiz 1"),
              subtitle: Text("Description of Public Quiz 1"),
            ),
          ),
        ],
      ),
    );
  }
}
