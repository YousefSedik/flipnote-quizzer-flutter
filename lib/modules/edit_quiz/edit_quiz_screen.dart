import 'package:flutter/material.dart';
import 'package:project/modules/edit_quiz/edit_quiz_controller.dart';
import 'package:project/widgets/app_bar.dart';
import 'package:project/widgets/black_button.dart';
import 'package:project/widgets/input_text_field.dart';
import 'package:project/widgets/manage_questions_edit.dart';
import 'package:project/validators/validators.dart';
import 'package:get/get.dart';

class EditQuizPage extends StatelessWidget {
  EditQuizPage({super.key});
  EditQuizController controller = Get.find<EditQuizController>();

  @override
  Widget build(BuildContext context) {
    controller.quiz.id = Get.arguments['id'];
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
                      "Edit Quiz",
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
                        builder: (EditQuizController controller) {
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
                  ManageQuestionsEdit(),
                  BlackButton(
                    text: "Save",
                    onPressed: () async {
                      if (controller.formKey.currentState!.validate()) {
                        controller.formKey.currentState!.save();
                        // update title, description, is_public
                        await controller.updateQuiz();
                        print("Quiz Saved: ${controller.quiz.toMap()}");
                        // update questions
                        await controller.updateQuestions();
                        print(controller.quiz.writtenQuestions);
                        print(controller.quiz.MCQQuestions);
                        for (var q in controller.quiz.writtenQuestions){
                          print(q.toJson());
                        }
                        for (var q in controller.quiz.MCQQuestions) {
                          print(q.toJson());
                        }

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
