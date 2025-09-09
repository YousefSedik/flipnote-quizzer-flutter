import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:project/modules/create_quiz/create_quiz_controller.dart';
import 'package:project/widgets/black_button.dart';
import 'package:project/widgets/input_text_field.dart';
import 'package:project/utils.dart';
import 'package:get/get.dart';

class ManageQuestionsCreate extends StatelessWidget {
  QuizController controller = Get.find<QuizController>();
  @override
  Widget build(BuildContext context) {
    // print(controller.quiz.fetchQuestions())
    return Column(
      children: [
        SizedBox(height: 20),
        Column(
          children: [
            // Add Question
            AddQuestion(context),
            // Upload PDF
            uploadPDF(),
          ],
        ),
        SizedBox(height: 20),
        // MCQ Questions List
        GetBuilder(
          builder: (QuizController controller) {
            return Column(
              children: List.generate(controller.quiz.MCQQuestions.length, (
                index,
              ) {
                final question = controller.quiz.MCQQuestions[index];
                print("MCQ Question: ${question.toJson()}");
                return ListTile(
                  title: Text(question.question),
                  subtitle: Text(
                    "options: '${question.options.join(', ')}' correct answer: '${question.answer}'",
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit_outlined),
                        onPressed: () {
                          // TODO: implement delete question
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete_outline_outlined),
                        onPressed: () {
                          controller.removeMCQQuestion(index);
                        },
                      ),
                    ],
                  ),
                );
              }),
            );
          },
        ),
        // Written Questions
        GetBuilder(
          builder: (QuizController controller) {
            return Column(
              children: List.generate(controller.quiz.writtenQuestions.length, (
                index,
              ) {
                final question = controller.quiz.writtenQuestions[index];
                return ListTile(
                  title: Text(question.question),
                  subtitle: Text("Answer: ${question.answer}"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit_outlined),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(Icons.delete_outline_outlined),
                        onPressed: () {
                          controller.removeWrittenQuestion(index);
                        },
                      ),
                    ],
                  ),
                );
              }),
            );
          },
        ),
      ],
    );
  }

  Widget AddQuestion(BuildContext context) {
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
            builder: QuestionTypeModalBottomSheetBuilder,
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

  Widget QuestionTypeModalBottomSheetBuilder(BuildContext context) {
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
            spacing: 12,
            children: [
              Text("Question Type"),
              BlackButton(
                text: "Multiple Choice Question",
                onPressed: () {
                  // Get.back();
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: MCQModalBottomSheetBuilder,
                  );
                },
              ),
              BlackButton(
                text: "Written Question",
                onPressed: () {
                  // Get.back();
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: writtenQuestionModalBottomSheetBuilder,
                  );
                },
              ),

              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  Widget writtenQuestionModalBottomSheetBuilder(BuildContext context) {
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
                controller: controller.questionController,
                hintText: "Question",
                title: 'Question',
                lastItem: false,
                isObscureText: false,
                other: {
                  "onChanged": (v) {
                    // controller.quiz = questionTypes.Written;
                  },
                },
              ),
              InputTextField(
                controller: controller.answerController,
                hintText: "Answer",
                title: 'Answer',
                lastItem: true,
                isObscureText: false,
                other: {
                  "onChanged": (v) {
                    // controller.quiz = questionTypes.Written;
                  },
                },
              ),
              BlackButton(
                text: "Add",
                onPressed: controller.addWrittenQuestion,
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  Widget MCQModalBottomSheetBuilder(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 16,
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InputTextField(
                  controller: controller.questionController,
                  hintText: "Question",
                  title: 'Question',
                  lastItem: false,
                  isObscureText: false,
                  other: {
                    "onChanged": (v) {
                      // controller.quiz = questionTypes.MCQ;
                    },
                  },
                ),
                GetBuilder(
                  builder: (QuizController controller) {
                    return Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: controller.options.length,
                          itemBuilder: (context, index) {
                            final option = controller.options[index];
                            return ListTile(
                              leading: Radio<int>(
                                value: index,
                                groupValue: controller.options.indexWhere(
                                  (o) => o.isCorrect == true,
                                ),
                                onChanged: (_) =>
                                    controller.selectCorrectAnswer(index),
                              ),
                              title: TextField(
                                decoration: InputDecoration(
                                  hintText: "Option ${index + 1}",
                                ),
                                onChanged: (val) =>
                                    controller.updateOption(index, val),
                              ),
                              trailing: IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () => controller.removeOption(index),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                          ),
                          onPressed: controller.addOption,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [Icon(Icons.add), Text("Add Option")],
                          ),
                        ),
                      ],
                    );
                  },
                ),
                BlackButton(text: "Add", onPressed: controller.addMCQQuestion),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
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
            String content = await pickAndReadPdf(result.paths[0]!);
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
