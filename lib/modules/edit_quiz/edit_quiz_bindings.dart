import 'package:get/get.dart';
import 'package:project/modules/edit_quiz/edit_quiz_controller.dart';
import 'package:project/modules/edit_quiz/edit_quiz_service.dart';

class EditQuizBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<EditQuizServices>(EditQuizServices());
    Get.put<EditQuizController>(EditQuizController());
  }
}
