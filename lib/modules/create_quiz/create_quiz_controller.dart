import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/models/question.dart';
import 'package:project/modules/create_quiz/create_quiz_services.dart';
import 'package:project/modules/shared_controllers/shared_quiz_controller.dart';

// enum questionTypes { Written, MCQ }

class QuizController extends SharedQuizController {
  final CreateQuizServices create_services = Get.find<CreateQuizServices>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<bool> addMCQQuestion() async {
    print(options[0].text);
    for (var option in options) {
      if (option.text.isEmpty) {
        Get.snackbar(
          "Error",
          "Please fill all options or delete unused ones",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
        return false;
      }
    }
    if (options.length < 2) {
      Get.snackbar(
        "Error",
        "Please add at least 2 options",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return false;
    }
    if (!options.any((option) => option.isCorrect)) {
      Get.snackbar(
        "Error",
        "Please select a correct answer",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return false;
    }
    print("Adding MCQ question");
    print("Question: ${questionController.text}");
    print("Answer: ${answerController.text}");
    print("Options: ${options.map((e) => "${e.text} ${e.isCorrect}").toList()}");
    quiz.MCQQuestions.add(
      MultipleChoiceQuestion(
        question: questionController.text,
        answer: answerController.text,
        options: options.map((e) => e.text).toList(),
      ),
    );
    questionController.clear();
    answerController.clear();
    options.clear();
    for (var q in quiz.MCQQuestions) {
      print("mcq q: ${q.question} ${q.answer} ${q.options}");
    }

    refresh();
    return true;
  }

  Future<bool> addWrittenQuestion() async {
    if (questionController.text.isEmpty || answerController.text.isEmpty) {
      Get.snackbar(
        "Error",
        "Please fill both question and answer",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return false;
    }
    quiz.writtenQuestions.add(
      WrittenQuestion(
        question: questionController.text,
        answer: answerController.text,
      ),
    );
    questionController.clear();
    answerController.clear();

    refresh();
    for (var q in quiz.writtenQuestions) {
      print("Written q: ${q.question} ${q.answer}");
    }
    return true;
  }

  void addOption(String option) {
    print("Adding option");
    options.add(Option(text: option));
    if (options.length == 1) {
      selectCorrectAnswer(0);
      return;
    }
    refresh(); // notify UI
  }

  void updateOption(int index, String text) {
    print("Updating option $index to $text");
    options[index].text = text;
    refresh(); // notify UI
  }

  void selectCorrectAnswer(int index) {
    print("Selecting correct answer $index");
    for (int i = 0; i < options.length; i++) {
      options[i].isCorrect = (i == index);
      answerController.text = options[index].text;
    }
    refresh();
  }

  void removeOption(int index) {
    print("Removing option $index");
    options.removeAt(index);
    refresh();
  }

  Future<void> createQuiz() async {
    // first create the quiz, then add the questions
    print(quiz.toMap());
    var resp = await create_services.createQuiz(quiz.toMap());
    if (resp == null) {
      print("Failed to create quiz");
      return;
    }
    String quizId = resp['id'].toString();
    print("Quiz created with id ${quizId}");

    create_services.addQuestions(quizId);
  }

  void removeMCQQuestion(int index) {
    quiz.MCQQuestions.removeAt(index);
    refresh();
  }

  void removeWrittenQuestion(int index) {
    quiz.writtenQuestions.removeAt(index);
    refresh();
  }

  void makePrivate() {
    quiz.isPublic = false;
    refresh();
  }

  void makePublic() {
    quiz.isPublic = true;
    refresh();
  }
}
