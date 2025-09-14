import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:project/modules/home/home_controller.dart';
import 'package:project/widgets/my_quizzes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final HomeController controller = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    final storage = const FlutterSecureStorage();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Flipnote Quizzer",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await storage.delete(key: "token");
              Get.offAllNamed('/login');
            },
          ),
        ],
        shape: Border(bottom: BorderSide(color: Colors.grey, width: .25)),
      ),
      body: SafeArea(
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.black,
            child: Icon(Icons.add, color: Colors.white),
            onPressed: () async{
              await Get.toNamed("/quiz/create");
              controller.fetchQuizzes();
            },
          ),
          body: SingleChildScrollView(
            child: Column(children: [MyQuizzesWidget()]),
          ),
        ),
      ),
    );
  }
}
