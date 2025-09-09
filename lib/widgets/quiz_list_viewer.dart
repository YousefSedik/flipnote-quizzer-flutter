import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';

class QuizListViewer extends StatefulWidget {
  final List questions;
  String id;
  QuizListViewer({super.key, required this.questions, required this.id});

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
            return buildQuizCardMCQ(
              widget.questions[index]['text']!,
              widget.questions[index]['choices']!,
              widget.questions[index]['correct_answer']!,
            );
          } else {
            return buildQuizCardWritten(
              widget.questions[index]['text']!,
              widget.questions[index]['answer']!,
            );
          }
        },
      ),
    );
  }

  Widget buildFlipCard(Widget front, Widget back) {
    return FlipCard(
      direction: FlipDirection.HORIZONTAL,
      side: CardSide.FRONT,
      front: front,
      back: back,
    );
  }

  Widget buildQuizCardMCQ(String question, List options, String answer) {
    return buildFlipCard(
      buildQuizCardMCQFront(question, options),
      buildQuizCardMCQBack(question, options, answer),
    );
  }

  Widget buildQuizCardMCQFront(String question, List options) {
    return Card(
      child: Center(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Text(
                question,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              ...List.generate(options.length, (index) {
                return Container(
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
                    options[index],
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                );
              }),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildQuizCardMCQBack(String question, List options, String answer) {
    return Card(
      child: Center(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Text(
                'Answer for "$question"',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              ...List.generate(options.length, (index) {
                return Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(
                    vertical: 4.0,
                    horizontal: 8.0,
                  ),
                  decoration: BoxDecoration(
                    color: options[index] == answer
                        ? Colors.green[100]
                        : Colors.white,
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
                        options[index],
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(width: 8),
                      getBadge(options[index], answer, options[index]) ??
                          Container(),
                    ],
                  ),
                );
              }),
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
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          question,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          softWrap: true,
        ),
      ),
    );
  }

  Widget buildQuizCardWrittenBack(String answer, String question) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Text(
              question,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              softWrap: true,
            ),
            Text(
              answer,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              softWrap: true,
            ),
          ],
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

  Widget? getBadge(
    String chosenAnswer,
    String correctAnswer,
    String currentAnswer,
  ) {
    if (chosenAnswer == correctAnswer && correctAnswer == currentAnswer) {
      return Icon(Icons.check_circle, color: Colors.green);
    } else if (chosenAnswer != correctAnswer &&
        currentAnswer == correctAnswer) {
      return Icon(Icons.check_circle, color: Colors.green);
    }
    return null;
  }
}
