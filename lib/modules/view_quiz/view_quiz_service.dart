import 'package:get/get.dart';
import 'package:project/api/api.dart';

class ViewQuizService extends GetxService {
  ApiClient apiClient = ApiClient();
  
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
    } else {}
    return questions;
  }
}
