import 'package:project/api/api.dart';
import 'package:project/modules/create_quiz/create_quiz_services.dart';
import 'package:project/modules/edit_quiz/edit_quiz_service.dart';
import 'package:project/models/quizModel.dart';
import 'package:project/models/question.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Option {
  String text;
  bool isCorrect;
  Option({required this.text, this.isCorrect = false});
}

class EditQuizController extends GetxController {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController questionController = TextEditingController();
  final TextEditingController answerController = TextEditingController();
  List<Option> options = [];
  final EditQuizServices edit_services = Get.find<EditQuizServices>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  QuizModel quiz = QuizModel();
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

  void makePrivate() {
    quiz.isPublic = false;
    refresh();
  }

  void makePublic() {
    quiz.isPublic = true;
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
      edit_services.deleteQuestion(q['id'], q['type']);
    }
  }
}
