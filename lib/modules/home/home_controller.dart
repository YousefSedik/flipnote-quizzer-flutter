import 'package:project/modules/home/home_service.dart';
import 'package:project/models/quizModel.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  HomeService homeService = Get.find<HomeService>();
  List<QuizModel> quizzes = [];

  @override
  void onInit() async {
    await fetchQuizzes();
    super.onInit();
  }

  Future<void> fetchQuizzes() async {
    quizzes = await homeService.getMyQuizzes();
    update();
  }

  void deleteQuiz(String id) {
    homeService.deleteQuiz(id);
    quizzes.removeWhere((quiz) => quiz.id == id);
    update();
  }
}
