import 'package:flutter/material.dart';

class EmptyPlaceholders extends StatelessWidget {
  const EmptyPlaceholders({super.key, required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.inbox, // you can change this
              size: 80,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 16),
            Text(
              message,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}


// Expanded(
//   child: quizzes.isEmpty
//       ? Center(
//           child: Text(
//             "No quizzes yet",
//             style: TextStyle(fontSize: 16, color: Colors.grey),
//           ),
//         )
//       : ListView.builder(
//           itemCount: quizzes.length,
//           itemBuilder: (BuildContext context, int index) {
//             return QuizCard(
//               title: quizzes[index].title,
//               description: quizzes[index].description,
//               author: 'Yousef',
//               questionCount: 3,
//               createdAt: '2025-08-01',
//               isPrivate: false,
//             );
//           },
//         ),
// ),
