import 'package:flutter/material.dart';
import 'package:project/components/app_bar.dart';
import 'package:project/components/input_text_field.dart';
import 'package:project/components/switch_button.dart';

class EditQuizPage extends StatelessWidget {
  EditQuizPage({super.key});
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    print("EditQuizPage args: $args");
    return Scaffold(
      appBar: getAppBar(title: "Edit Quiz"),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(16.0),
          child: Form(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Edit Quiz",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
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
                    SwitchButton(),
                    Text(
                      "Make the Quiz Public",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                    ),
                    onPressed: () {
                      print("Create Quiz Button Pressed");
                    },
                    child: Text(
                      "Save",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
