import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:project/api/api.dart';
import 'package:project/models/question.dart';
import 'package:project/modules/create_quiz/create_quiz_controller.dart';

class CreateQuizServices extends GetxService {
  final ApiClient apiClient = ApiClient();
  Future<dynamic> createQuiz(Map<String, dynamic> data) async {
    return await apiClient.createQuiz(data).then((response) {
      if (response.statusCode == 201) {
        return response.data;
      }
    });
  }

  Future<void> addQuestions(String id) async {
    // save written questions
    for (var question in Get.find<QuizController>().quiz.writtenQuestions) {
      apiClient.createQuestion(question.toJson(), id);
    }
    // save MCQ questions
    for (var question in Get.find<QuizController>().quiz.MCQQuestions) {
      apiClient.createQuestion(question.toJson(), id);
    }
  }

  Future<void> saveQuiz(Map<String, dynamic> data) async {
    await apiClient.updateQuiz(data);
  }

  Future<List<dynamic>> fetchQuestions(String id) async{
    List<dynamic> questions = [];
    await apiClient.getQuestions(id).then((response) {
      if (response.statusCode == 200) {
        final data = response.data;
        // print(data);        
        for (var question in data["mcq_questions"]) {
          // print(question);
          questions.add(MultipleChoiceQuestion.fromJson(question));
        }
        for (var question in data["written_questions"]) {
          questions.add(WrittenQuestion.fromJson(question));
        }
      }
    });
    return questions;
  }

}
