import 'package:flutter/material.dart';
import 'package:project/api/api.dart';
import 'package:project/components/app_bar.dart';
import 'package:project/components/black_button.dart';
import 'package:project/components/input_text_field.dart';
import 'package:project/components/manage_questions.dart';
import 'package:project/models/quiz.dart';
import 'package:project/validators/validators.dart';

class CreateQuizPage extends StatefulWidget {
  CreateQuizPage({super.key});

  @override
  State<CreateQuizPage> createState() => _CreateQuizPageState();
}

class _CreateQuizPageState extends State<CreateQuizPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ApiClient apiClient = ApiClient();
  bool isPublic = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Create New Quiz",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
                  ),
                ),
                SizedBox(height: 20),
                // Quiz Title
                InputTextField(
                  controller: _titleController,
                  hintText: "Enter Quiz Title",
                  title: "Quiz Title",
                  lastItem: false,
                  isObscureText: false,
                  other: {
                    "validators": [notNullOrEmpty],
                  },
                ),
                // Quiz Description
                InputTextField(
                  controller: _descriptionController,
                  hintText: "Enter Quiz Description ",
                  title: "Quiz Description (Optional)",
                  lastItem: false,
                  isObscureText: false,
                ),
                Row(
                  spacing: 5,
                  children: [
                    Switch(
                      value: isPublic,
                      activeColor: Colors.black,
                      inactiveThumbColor: Colors.grey,
                      onChanged: (bool value) {
                        setState(() {
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
                ManageQuestions(questions: []),
                BlackButton(
                  text: "Save",
                  onPressed: () async{
                    if (_formKey.currentState!.validate()) {
                      Map<String, dynamic> newQuiz = QuizModel(
                        title: _titleController.text,
                        description: _descriptionController.text,
                        isPrivate: isPublic,
                      ).toMap();
                      await apiClient.createQuiz(newQuiz).then((response){
                          if (response.statusCode == 201) {
                            Navigator.pop(context);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Failed to create quiz. Please try again."),
                                backgroundColor: Colors.black,
                              ),
                            );
                          }
                        },
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
