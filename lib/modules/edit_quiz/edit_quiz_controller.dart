import 'package:project/modules/edit_quiz/edit_quiz_service.dart';
import 'package:project/models/question.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/modules/shared_controllers/shared_quiz_controller.dart';

class EditQuizController extends SharedQuizController {
  final EditQuizServices edit_services = Get.find<EditQuizServices>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  List<Map<String, dynamic>> toDelete = [];

  @override
  void onInit() async {
    print("Create Quiz Controller initialized");
    if (Get.arguments != null) {
      quiz.id = Get.arguments['id'] ?? null;
      quiz.title = Get.arguments['title'] ?? '';
      quiz.description = Get.arguments['description'] ?? '';
      quiz.isPublic = Get.arguments['isPublic'] ?? true;
      titleController.text = quiz.title!;
      descriptionController.text = quiz.description ?? '';
      List<dynamic> questions = await edit_services.fetchQuestions(quiz.id!);
      for (var question in questions) {
        if (question is MultipleChoiceQuestion) {
          quiz.MCQQuestions.add(question);
        } else if (question is WrittenQuestion) {
          quiz.writtenQuestions.add(question);
        }
      }
      print("Fetched ${quiz.MCQQuestions.length} MCQ questions");
      print("Fetched ${quiz.writtenQuestions.length} Written questions");
      // TODO: ..
      refresh();
    }
    super.onInit();
  }

  Future<bool> addMCQQuestion() async {
    // ensure all options are filled
    for (var option in options) {
      if (option.controller.text.isEmpty) {
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
        "Please select the correct answer",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return false;
    }
    quiz.MCQQuestions.add(
      MultipleChoiceQuestion(
        question: questionController.text,
        answer: answerController.text,
        options: options.map((e) => e.controller.text).toList(),
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

  void removeMCQQuestion(int index) {
    if (quiz.MCQQuestions[index].id != null) {
      toDelete.add({"id": quiz.MCQQuestions[index].id, "type": "mcq"});
    }
    quiz.MCQQuestions.removeAt(index);
    refresh();
  }

  void removeWrittenQuestion(int index) {
    if (quiz.writtenQuestions[index].id != null) {
      toDelete.add({"id": quiz.writtenQuestions[index].id, "type": "written"});
    }
    quiz.writtenQuestions.removeAt(index);
    refresh();
  }

  Future<void> updateQuiz() async {
    await edit_services.saveQuiz(quiz.toMap());
  }

  Future<void> updateQuestions() async {
    // update MCQ
    for (var q in quiz.MCQQuestions) {
      if (q.id == null) {
        edit_services.createQuestion(q.toJson(), quiz.id!);
      } else {
        // already existing question
        edit_services.updateQuestion(q.toJson(), quiz.id!);
      }
    }
    // update Written
    for (var q in quiz.writtenQuestions) {
      if (q.id == null) {
        // new question
        edit_services.createQuestion(q.toJson(), quiz.id!);
      } else {
        // already existing question
        edit_services.updateQuestion(q.toJson(), quiz.id!);
      }
    }

    for (var q in toDelete) {
      edit_services.deleteQuestion(quiz.id!, q['id'].toString(), q['type']);
    }
  }
}
