import 'package:get/get.dart';
import 'package:project/modules/create_quiz/create_quiz_controller.dart';
import 'package:project/modules/create_quiz/create_quiz_services.dart';

class CreateQuizBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<CreateQuizServices>(CreateQuizServices());
    Get.put<QuizController>(QuizController());
  }
}