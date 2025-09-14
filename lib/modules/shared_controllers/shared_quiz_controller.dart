import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/models/question.dart';
import 'package:project/models/quizModel.dart';
import 'package:project/modules/create_quiz/create_quiz_services.dart';
import 'package:project/utils.dart';

class Option {
  String text;
  bool isCorrect;
  Option({required this.text, this.isCorrect = false});
}

class SharedQuizController extends GetxController {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController questionController = TextEditingController();
  final TextEditingController answerController = TextEditingController();
  List<Option> options = [];
  QuizModel quiz = QuizModel();



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

  Future<String> getQuestionsFromPDF() async {
    print("Upload PDF Button Pressed");
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    String content = "";
    if (result != null) {
      content = await pickAndReadPdf(result.paths[0]!);
    } else {
      print("No file selected");
    }

    return content;
  }
}
