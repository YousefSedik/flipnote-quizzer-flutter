import 'package:get/get.dart';
import 'package:project/api/api.dart';
import 'package:project/models/quizModel.dart';

class HomeService extends GetxService {
  final ApiClient apiClient = ApiClient();

  Future<List<QuizModel>> getMyQuizzes() async {
    List<QuizModel> quizzes = [];
    return await apiClient.getMyQuizzes().then((response) {
      if (response.statusCode == 200) {
        final data = response.data['results'] as List;
        for (var item in data) {
          quizzes.add(QuizModel.fromJson(item));
        }
      }
      return quizzes;
    });
  }

  void deleteQuiz(String id) {
    apiClient.deleteQuiz(id).then((response) {
      if (response.statusCode == 204) {
          // is visible = false
      } else {
        print("Failed to delete quiz");
      }
    });
  }

  Future<List> fetchQuestions(String id) async {
    List questions = [];
    final response = await apiClient.getQuestions(id);

    if (response.statusCode == 200) {
      final data = response.data as Map;
      for (var question in data["mcq_questions"]) {
        question['type'] = 'mcq';
        questions.add(question);
      }
      for (var question in data["written_questions"]) {
        question['type'] = 'written';
        questions.add(question);
      }
    } else {
    }
    return questions;
  }

}
