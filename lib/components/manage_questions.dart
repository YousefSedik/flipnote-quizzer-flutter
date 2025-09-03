import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:project/api/api.dart';
import 'package:project/components/black_button.dart';
import 'package:project/components/input_text_field.dart';
import 'package:project/utils.dart';

class ManageQuestions extends StatefulWidget {
  ManageQuestions({super.key, required this.questions});
  final List<Map<String, String>> questions;
  final TextEditingController _writtenQuestionsController =
      TextEditingController();
  final TextEditingController _writtenAnswersController =
      TextEditingController();

  @override
  State<ManageQuestions> createState() => _ManageQuestionsState();
}

class _ManageQuestionsState extends State<ManageQuestions> {
  final ApiClient _dio = ApiClient();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20),
        Column(
          children: [
            // Add Question
            AddQuestion(),
            // Upload PDF
            uploadPDF(),
          ],
        ),
        SizedBox(height: 20),
        // questions list
        Column(
          children: List.generate(widget.questions.length, (index) {
            final question = widget.questions[index];
            return ListTile(
              title: Text(question['question'] ?? ''),
              subtitle: Text(question['answer'] ?? ''),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit_outlined),
                    onPressed: () {
                      // TODO: implement delete question  
                      _dio.deleteQuestion(12, "das").then((response) {
                        if (response.statusCode == 200) {
                          print("Question deleted successfully");
                        } else {
                          print("Failed to delete question");
                        }
                        setState(() {
                          widget.questions.removeAt(index);
                        });
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete_outline_outlined),
                    onPressed: () {},
                  ),
                ],
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget AddQuestion() {
    return SizedBox(
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,

          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.black, width: 3.0),
            borderRadius: BorderRadius.circular(8.0),
          ),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        ),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: showModalBottomSheetBuilder,
          );
        },
        child: SizedBox(
          child: Row(
            spacing: 5,
            children: [
              Icon(Icons.add, size: 16),
              Text(
                "Add Question",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget showModalBottomSheetBuilder(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 16,
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InputTextField(
                controller: widget._writtenQuestionsController,
                hintText: "Question",
                title: 'Question',
                lastItem: false,
                isObscureText: false,
              ),
              InputTextField(
                controller: widget._writtenAnswersController,
                hintText: "Answer",
                title: 'Answer',
                lastItem: true,
                isObscureText: false,
              ),
              BlackButton(text: "Save", onPressed: addQuestion),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  void addQuestion() {
    setState(() {
      widget.questions.add({
        'type': 'written',
        'question': widget._writtenQuestionsController.text,
        'answer': widget._writtenAnswersController.text,
      });
      widget._writtenQuestionsController.clear();
      widget._writtenAnswersController.clear();
      print(widget.questions);
    });
    Navigator.pop(context);
  }

  Widget uploadPDF() {
    return SizedBox(
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,

          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.black, width: 3.0),
            borderRadius: BorderRadius.circular(8.0),
          ),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        ),

        onPressed: () async {
          FilePickerResult? result = await FilePicker.platform.pickFiles(
            type: FileType.custom,
            allowedExtensions: ['pdf'],
          );
          if (result != null) {
            print("hey");
            String content = await pickAndReadPdf(result.paths[0]!);
            print(content);
          } else {}
          print("Upload PDF Button Pressed");
        },

        child: Row(
          spacing: 5,
          children: [
            Icon(Icons.upload_file, size: 16),
            Text(
              "Generate From PDF",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
