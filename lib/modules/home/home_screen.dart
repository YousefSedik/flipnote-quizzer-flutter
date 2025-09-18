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
    
    return GetBuilder(
      builder: (HomeController controller) {
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
                  await controller.logout();
                },
              ),
              IconButton(
                icon: Icon(Icons.person),
                onPressed: () async {
                  controller.toProfile();
                },
              ),
            ],
            shape: Border(bottom: BorderSide(color: Colors.grey, width: .25)),
          ),
          bottomNavigationBar: NavigationBar(
            onDestinationSelected: (int index) {
              controller.currentPageIndex = index;
              controller.update();
            },
            backgroundColor: Colors.white,
            indicatorColor: Color.fromARGB(255, 170, 169, 172),
            selectedIndex: controller.currentPageIndex,
            destinations: const <Widget>[
              NavigationDestination(
                selectedIcon: Icon(Icons.home),
                icon: Icon(Icons.home_outlined),
                label: 'Home',
              ),
              NavigationDestination(icon: Icon(Icons.search), label: 'Search'),
            ],
          ),
          body: [
            myQuizzesAndCreateQuizWidget(),
            SearchWidget(),
          ][controller.currentPageIndex],
        );
      },
    );
  }

  Widget SearchWidget() {
    return Container();
  }

  SafeArea myQuizzesAndCreateQuizWidget() {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          child: Icon(Icons.add, color: Colors.white),
          onPressed: () async {
            await Get.toNamed("/quiz/create");
            controller.fetchQuizzes();
          },
        ),
        body: SingleChildScrollView(
          child: Column(children: [MyQuizzesWidget()]),
        ),
      ),
    );
  }
}
