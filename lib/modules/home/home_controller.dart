import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:project/models/user.dart';
import 'package:project/modules/home/home_service.dart';
import 'package:project/models/quizModel.dart';
import 'package:get/get.dart';
import 'package:project/utils.dart';
import 'package:project/widgets/confirmation_dialog.dart';

class HomeController extends GetxController {
  HomeService homeService = Get.find<HomeService>();
  List<QuizModel> quizzes = [];
  final storage = const FlutterSecureStorage();
  var currentPageIndex = 0;


  @override
  void onInit() async {
    await fetchQuizzes();
    super.onInit();
  }

  Future<void> fetchQuizzes() async {
    quizzes = await homeService.getMyQuizzes();
    update();
  }

  Future<void> deleteQuiz(String id) async {
    await showConfirmationDialog("confirmation to delete the quiz").then((
      confirmed,
    ) {
      if (confirmed) {
        homeService.deleteQuiz(id);
        quizzes.removeWhere((quiz) => quiz.id == id);
        update();
      }
    });
  }

  Future<void> logout() async {
    if (await showConfirmationDialog("Are you sure you want to logout?")) {
      await storage.delete(key: "token");
      Get.offAllNamed('/login');
    }
  }

  void toProfile() async {
    User? userId = await getCurrentUserModel();
    if (userId == null) {
      return;
    }
    Get.toNamed('/profile', arguments: {'user_id': userId.id});
  }
}
