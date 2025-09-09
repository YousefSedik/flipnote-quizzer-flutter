import 'package:flutter/material.dart';
import 'package:project/modules/create_quiz/create_quiz_controller.dart';
import 'package:project/widgets/app_bar.dart';
import 'package:project/widgets/black_button.dart';
import 'package:project/widgets/input_text_field.dart';
import 'package:project/widgets/manage_questions_create.dart';
import 'package:project/validators/validators.dart';
import 'package:get/get.dart';

class CreateQuizPage extends StatelessWidget {
  CreateQuizPage({super.key});

  QuizController controller = Get.find<QuizController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(16.0),
            child: Form(
              key: controller.formKey,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Create New Quiz",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  // Quiz Title
                  InputTextField(
                    controller: controller.titleController,
                    hintText: "Enter Quiz Title",
                    title: "Quiz Title",
                    lastItem: false,
                    isObscureText: false,
                    other: {
                      "validators": [notNullOrEmpty],
                      "onSaved": (v) {
                        controller.quiz.title = v;
                      },
                    },
                  ),
                  // Quiz Description
                  InputTextField(
                    controller: controller.descriptionController,
                    hintText: "Enter Quiz Description ",
                    title: "Quiz Description (Optional)",
                    lastItem: false,
                    isObscureText: false,
                    other: {
                      "onSaved": (v) {
                        controller.quiz.description = v;
                      },
                    },
                  ),
                  Row(
                    spacing: 5,
                    children: [
                      GetBuilder(
                        builder: (QuizController controller) {
                          return Switch(
                            value: controller.quiz.isPublic,
                            activeColor: Colors.black,
                            inactiveThumbColor: Colors.grey,
                            onChanged: (bool value) {
                              if (value) {
                                controller.makePublic();
                              } else {
                                controller.makePrivate();
                              }
                            },
                          );
                        },
                      ),
                      Text(
                        "Make the Quiz Public",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  ManageQuestionsCreate(),
                  BlackButton(
                    text: "Create",
                    onPressed: () {
                      if (controller.formKey.currentState!.validate()) {
                        controller.formKey.currentState!.save();
                        controller.createQuiz();
                        Get.offAllNamed("/home");
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
