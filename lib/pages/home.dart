import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:project/components/my_quizzes.dart';
import 'package:flutter/material.dart';
import 'package:project/api/api.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ApiClient apiClient = ApiClient();

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
              await storage.deleteAll();
              Get.offAllNamed('/login');
            },
          ),
        ],
        shape: Border(bottom: BorderSide(color: Colors.grey, width: .25)),
      ),
      body: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(children: [MyQuizzesWidget()]),
          ),
        ),
      ),
    );
  }
}
