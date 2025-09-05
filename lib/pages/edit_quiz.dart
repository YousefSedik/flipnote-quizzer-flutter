import 'package:flutter/material.dart';
import 'package:project/api/api.dart';
import 'package:project/components/app_bar.dart';
import 'package:project/components/black_button.dart';
import 'package:project/components/input_text_field.dart';
import 'package:project/components/manage_questions.dart';
import 'package:project/models/quizModel.dart';
import 'package:get/get.dart';
class EditQuizPage extends StatefulWidget {
  EditQuizPage({super.key});

  @override
  State<EditQuizPage> createState() => _EditQuizPageState();
}

class _EditQuizPageState extends State<EditQuizPage> {
  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _descriptionController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ApiClient apiClient = ApiClient();

  bool isPublic = false;

  final List<Map<String, String>> _questions = [
    {
      'question': 'What is a StatefulWidget?',
      'answer': 'A widget that has mutable state.',
    },
    {
      'question': 'What is the main function in Dart?',
      'answer': 'The entry point of a Dart application.',
    },
    {
      'question': 'What is an async function?',
      'answer':
          'A function that performs asynchronous operations and returns a Future.',
    },
    {
      'question': 'What is a Future in Dart?',
      'answer':
          'An object representing a potential value or error that will be available at some time in the future.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    isPublic = args['isPrivate'];
    return Scaffold(
      appBar: getAppBar(title: "Edit Quiz"),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(16.0),
          child: Form(
            child: SingleChildScrollView(
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
                  InputTextField(
                    controller: _titleController,
                    hintText: "Enter Quiz Title",
                    title: "Quiz Title",
                    lastItem: false,
                    isObscureText: false,
                    defaultValue: args['title'] ?? "",
                  ),
                  InputTextField(
                    controller: _descriptionController,
                    hintText: "Enter Quiz Description ",
                    title: "Quiz Description (Optional)",
                    lastItem: false,
                    isObscureText: false,
                    defaultValue: args['description'] ?? "",
                  ),
                  Row(
                    spacing: 10,
                    children: [
                      Switch(
                        value: isPublic,
                        activeColor: Colors.black,
                        inactiveThumbColor: Colors.grey,
                        onChanged: (bool value) {
                          setState(() {
                            print(
                              "Current Value $isPublic to be changed to $value",
                            );
                            isPublic = value;
                          });
                        },
                      ),
                      Text(
                        "Make the Quiz Public",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  ManageQuestions(questions: _questions),
                  BlackButton(
                    text: "Save Changes",
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        Map<String, dynamic> newQuiz = QuizModel(
                          title: _titleController.text,
                          description: _descriptionController.text,
                          isPrivate: isPublic,
                        ).toMap();
                        await apiClient.createQuiz(newQuiz).then((response) {
                          if (response.statusCode == 201) {
                            Get.back();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "Failed to create quiz. Please try again.",
                                ),
                                backgroundColor: Colors.black,
                              ),
                            );
                          }
                        });
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
