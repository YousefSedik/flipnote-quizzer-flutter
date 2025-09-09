import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/models/question.dart';
import 'package:project/models/quizModel.dart';
import 'package:project/modules/create_quiz/create_quiz_services.dart';

class Option {
  String text;
  bool isCorrect;
  Option({required this.text, this.isCorrect = false});
}

// enum questionTypes { Written, MCQ }

class QuizController extends GetxController {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController questionController = TextEditingController();
  final TextEditingController answerController = TextEditingController();
  List<Option> options = [];
  final CreateQuizServices create_services = Get.find<CreateQuizServices>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  QuizModel quiz = QuizModel();

  Future<void> addMCQQuestion() async {
    if (options.length < 2) {
      Get.snackbar(
        "Error",
        "Please add at least 2 options",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    if (!options.any((option) => option.isCorrect)) {
      Get.snackbar(
        "Error",
        "Please select a correct answer",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
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

    Get.back();
    Get.back();
    refresh();
  }

  Future<void> addWrittenQuestion() async {
    quiz.writtenQuestions.add(
      WrittenQuestion(
        question: questionController.text,
        answer: answerController.text,
      ),
    );
    questionController.clear();
    answerController.clear();
    Get.back();
    Get.back();
    refresh();
    for (var q in quiz.writtenQuestions) {
      print("Written q: ${q.question} ${q.answer}");
    }
  }

  void addOption() {
    print("Adding option");
    options.add(Option(text: ""));
    selectCorrectAnswer(0);
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
