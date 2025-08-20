import 'package:flutter/material.dart';

class QuizListViewer extends StatefulWidget {
  const QuizListViewer({super.key});

  @override
  State<QuizListViewer> createState() => _QuizCardsGridViewerState();
}

class _QuizCardsGridViewerState extends State<QuizListViewer> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: 10, // Example count, replace with actual data length
        itemBuilder: (context, index) {
          if (index % 2 == 0) {
            return buildQuizCardMCQ('Sample Question $index', [
              'Option A',
              'Option B',
              'Option C',
            ]);
          } else {
            return buildQuizCardWritten(index);
          }
        },
      ),
    );
  }

  Card buildQuizCardMCQ(String question, List<String> options) {
    return Card(
      color: Colors.lightBlue,
      child: Center(
        child: Column(
          children: [
            Text(
              question,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ...options.map(
              (option) => Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: Text(option, style: TextStyle(fontSize: 16, backgroundColor: Colors.blueGrey)),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Card buildQuizCardWritten(int index) {
    return Card(child: Center(child: Text('Written Quiz $index')));
  }
}
