import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';

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
            // return buildQuizCardWritten("Sample Question $index", "Sample Answer $index");
          }
        },
      ),
    );
  }

  FlipCard buildFlipCard(Card front, Card back) {
    return FlipCard(
      fill: Fill
          .fillBack, // Fill the back side of the card to make in the same size as the front.
      direction: FlipDirection.HORIZONTAL, // default
      side: CardSide.FRONT, // The side to initially display.
      front: Container(child: front),
      back: Container(child: back),
    );
  }

  FlipCard buildQuizCardMCQ(String question, List<String> options) {
    return buildFlipCard(
      buildQuizCardMCQFront(question, options),
      buildQuizCardMCQBack(question, options),
    );
  }

  Card buildQuizCardMCQFront(String question, List<String> options) {
    return Card(
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
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 16.0,
                ),
                child: Text(option, style: TextStyle(fontSize: 16)),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Card buildQuizCardMCQBack(String question, List<String> options) {
    return Card(
      child: Center(
        child: Column(
          children: [
            Text(
              'Answer for $question',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ...options.map(
              (option) => Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 16.0,
                ),
                child: Text(option, style: TextStyle(fontSize: 16)),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  FlipCard buildQuizCardWritten(String question, String answer) {
    return buildFlipCard(
      buildQuizCardWrittenFront(question),
      buildQuizCardWrittenBack(answer),
    );
  }

  Card buildQuizCardWrittenFront(String question) {
    return Card(
      child: Center(
        child: Text(
          question,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Card buildQuizCardWrittenBack(String answer) {
    return Card(
      child: Center(
        child: Text(
          'Answer: $answer',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
