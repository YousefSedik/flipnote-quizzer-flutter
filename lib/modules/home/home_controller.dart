import 'package:flutter/material.dart';
import 'package:project/modules/home/home_service.dart';
import 'package:project/models/quizModel.dart';
import 'package:get/get.dart';
import 'package:project/widgets/confirmation_dialog.dart';

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

  Future<void> deleteQuiz(String id) async{
    await showConfirmationDialog("confirmation to delete the quiz").then((confirmed) {
      if (confirmed) {
        print("Deleting quiz with id: $id");
        
        homeService.deleteQuiz(id);
        quizzes.removeWhere((quiz) => quiz.id == id);
        update();
      }
    });
  }
}
