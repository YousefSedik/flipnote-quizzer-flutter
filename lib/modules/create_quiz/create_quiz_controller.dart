import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/models/question.dart';
import 'package:project/modules/create_quiz/create_quiz_services.dart';
import 'package:project/modules/shared_controllers/shared_quiz_controller.dart';

// enum questionTypes { Written, MCQ }

class QuizController extends SharedQuizController {
  final CreateQuizServices createServices = Get.find<CreateQuizServices>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> addMCQQuestion() async {
    for (var option in options) {
      if (option.isCorrect) {
        answerController.text = option.controller.text;
      }
    }
    for (var option in options) {
      if (option.controller.text.isEmpty) {
        Get.snackbar(
          "Error",
          "Please fill all options or delete unused ones",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
        return;
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
      return ;
    }
    if (!options.any((option) => option.isCorrect)) {
      Get.snackbar(
        "Error",
        "Please select a correct answer",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }
    print("Adding MCQ question");
    print("Question: ${questionController.text}");
    print("Answer: ${answerController.text}");
    print(
      "Options: ${options.map((e) => "${e.controller.text} ${e.isCorrect}").toList()}",
    );
    print(quiz.MCQQuestions.length);
    quiz.MCQQuestions.add(
      MultipleChoiceQuestion(
        question: questionController.text,
        answer: options
            .firstWhere((option) => option.isCorrect)
            .controller
            .text,
        options: options.map((e) => e.controller.text).toList(),
      ),
    );
    print(quiz.MCQQuestions.length);
    questionController.clear();
    answerController.clear();
    options.clear();
    for (var q in quiz.MCQQuestions) {
      print("mcq q: ${q.question} ${q.answer} ${q.options}");
    }
    Get.back();
    Get.back();
    refresh();

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
    clearAll();
    for (var q in quiz.writtenQuestions) {
      print("Written q: ${q.question} ${q.answer}");
    }
    return true;
  }

  Future<void> createQuiz() async {
    // first create the quiz, then add the questions
    print(quiz.toMap());
    var resp = await createServices.createQuiz(quiz.toMap());
    if (resp == null) {
      print("Failed to create quiz");
      return;
    }
    String quizId = resp['id'].toString();
    print("Quiz created with id ${quizId}");

    createServices.addQuestions(quizId);
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
