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
}
