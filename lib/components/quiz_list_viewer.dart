import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';

class QuizListViewer extends StatefulWidget {
  QuizListViewer({super.key, required this.questions});
  dynamic questions;
  @override
  State<QuizListViewer> createState() => _QuizCardsGridViewerState();
}

class _QuizCardsGridViewerState extends State<QuizListViewer> {
  @override
  void initState() {
    super.initState();
    widget.questions.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: widget.questions.length,
        itemBuilder: (context, index) {
          if (widget.questions[index]['type'] == 'mcq') {
            return Expanded(
              child: buildQuizCardMCQ(
                widget.questions[index]['question']!,
                widget.questions[index]['options']!,
                widget.questions[index]['answer']!,
              ),
            );
          } else {
            return Expanded(
              child: buildQuizCardWritten(
                widget.questions[index]['question']!,
                widget.questions[index]['answer']!,
              ),
            );
          }
        },
      ),
    );
  }

  Widget buildFlipCard(Widget front, Widget back) {
    return Expanded(
      child: FlipCard(
        fill: Fill
            .fillBack, // Fill the back side of the card to make in the same size as the front.
        direction: FlipDirection.HORIZONTAL,
        side: CardSide.FRONT,
        front: Container(child: front),
        back: Container(child: back),
      ),
    );
  }

  Widget buildQuizCardMCQ(
    String question,
    List<String> options,
    String answer,
  ) {
    return Expanded(
      child: buildFlipCard(
        buildQuizCardMCQFront(question, options),
        buildQuizCardMCQBack(question, options, answer),
      ),
    );
  }

  Widget buildQuizCardMCQFront(String question, List<String> options) {
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
                width: double.infinity,

                margin: const EdgeInsets.symmetric(
                  vertical: 4.0,
                  horizontal: 8.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 16.0,
                ),
                child: Text(
                  option,
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget buildQuizCardMCQBack(
    String question,
    List<String> options,
    String answer,
  ) {
    return Expanded(
      child: Card(
        child: Center(
          child: Column(
            children: [
              Text(
                'Answer for "$question"',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              ...options.map(
                (option) => Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(
                    vertical: 4.0,
                    horizontal: 8.0,
                  ),
                  decoration: BoxDecoration(
                    color: option == answer ? Colors.green[100] : Colors.white,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 16.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        option,
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(width: 8),
                      Container(child: getBadge(option, answer, option) ?? Container()),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildQuizCardWritten(String question, String answer) {
    return buildFlipCard(
      buildQuizCardWrittenFront(question),
      buildQuizCardWrittenBack(answer, question),
    );
  }

  Widget buildQuizCardWrittenFront(String question) {
    return Card(
      color: Colors.white,
      child: Center(
        child: Text(
          question,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget buildQuizCardWrittenBack(String answer, String question) {
    return Expanded(
      child: Card(
        child: Center(
          child: Text(
            'Q: $question\n\nA: $answer',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget chosenAnswer() {
    return Container(decoration: BoxDecoration(color: Colors.green));
  }

  Widget correctAnswer() {
    return Container(decoration: BoxDecoration(color: Colors.red));
  }

  Widget? getBadge(String chosenAnswer, String correctAnswer, String currentAnswer) {
    if (chosenAnswer == correctAnswer && correctAnswer == currentAnswer) {
      return Icon(Icons.check_circle, color: Colors.green);
    } else if (chosenAnswer != correctAnswer && currentAnswer == correctAnswer) {
      return Icon(Icons.check_circle, color: Colors.green);
    } else if (chosenAnswer != correctAnswer && currentAnswer == chosenAnswer) {
      return Icon(Icons.cancel, color: Colors.red);
    }
    return null;
  }
}
