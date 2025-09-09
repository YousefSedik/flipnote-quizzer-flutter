import 'package:get/get.dart';
import 'package:project/api/api.dart';
import 'package:project/models/question.dart';
import 'package:project/modules/edit_quiz/edit_quiz_controller.dart';

class EditQuizServices extends GetxService {
  final ApiClient apiClient = ApiClient();

  Future<void> saveQuiz(Map<String, dynamic> data) async {
    // update Quiz
    await apiClient.updateQuiz(data);
  }

  Future<List<dynamic>> fetchQuestions(String id) async {
    List<dynamic> questions = [];
    await apiClient.getQuestions(id).then((response) {
      if (response.statusCode == 200) {
        final data = response.data;
        for (var question in data["mcq_questions"]) {
          questions.add(MultipleChoiceQuestion.fromJson(question));
        }
        for (var question in data["written_questions"]) {
          questions.add(WrittenQuestion.fromJson(question));
        }
      }
    });
    return questions;
  }

  Future<void> createQuestion(Map<String, dynamic> data, String id) {
    return apiClient.createQuestion(data, id);
  }

  Future<void> updateQuestion(Map<String, dynamic> data, String Quizid) {
    return apiClient.updateMCQQuestion(data, Quizid, data['id']);
  }

  Future<void> deleteQuestion(String id, String type) async {
    if (type == "written") {
      apiClient.deleteQuestion(id, type);
    } else if (type == "mcq") {
      apiClient.deleteQuestion(id, type);
    }
  }
}
