import 'package:project/modules/view_quiz/view_quiz_service.dart';
import 'package:get/get.dart';

class ViewQuizController extends GetxController {
  ViewQuizService service = Get.put<ViewQuizService>(ViewQuizService());
  ViewQuizController({required this.quizId});
  var questions = [].obs;

  String quizId;
  @override
  void onInit() async {
    questions.value = await service.fetchQuestions(quizId);
    print("Fetched ${questions.length} questions");
    super.onInit();
  }
}
