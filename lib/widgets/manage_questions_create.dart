import 'package:flutter/material.dart';
import 'package:project/modules/create_quiz/create_quiz_controller.dart';
import 'package:project/widgets/black_button.dart';
import 'package:project/widgets/input_text_field.dart';
import 'package:get/get.dart';

class ManageQuestionsCreate extends StatelessWidget {
  QuizController controller = Get.find<QuizController>();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20),
        Column(
          children: [
            // Add Question
            AddQuestion(context),
            // Upload PDF
            uploadPDF(context),
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
                  "key": "writtenQuestionField",
                },
              ),
              InputTextField(
                controller: controller.answerController,
                hintText: "Answer",
                title: 'Answer',
                lastItem: true,
                isObscureText: false,
                other: {
                  "key": "writtenAnswerField",
                },
              ),
              BlackButton(
                text: "Add",
                onPressed: () async {
                  if (await controller.addWrittenQuestion()) {
                    Get.back();
                    Get.back();
                  }
                },
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
                    "key": "mcqQuestionField",
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
                                controller: option.controller,
                                decoration: InputDecoration(
                                  hintText: "Option ${index + 1}",
                                ),
                                onChanged: (val) {
                                  controller.updateOption(index, val);
                                },
                              ),
                              trailing: IconButton(
                                icon: Icon(Icons.delete),
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
                          onPressed: () {
                            controller.addOption("");
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [Icon(Icons.add), Text("Add Option")],
                          ),
                        ),
                      ],
                    );
                  },
                ),
                BlackButton(
                  text: "Add",
                  onPressed: () async {
                    controller.addMCQQuestion();
                    
                  },
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget uploadPDF(BuildContext context) {
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
          String content = await controller.getQuestionsFromPDF();
          // ApiClient apiClient = ApiClient();
          // apiClient.extractQuestions(content).then((response) {
          //   if (response.statusCode == 200) {
          //     print(response.data['mcqs'][0]);
          //   }
          // });
          var data = {
            "mcq": [
              {
                "text": "We should keep our savings with banks because",
                "options": [
                  "It is safe",
                  "Earns interest",
                  "Can be withdrawn anytime",
                  "All of above",
                ],
                "answer": "All of above",
              },
              {
                "text": "Bank does not give loan against",
                "options": [
                  "Gold Ornaments",
                  "LIC policy",
                  "Lottery ticket",
                  "NSC",
                ],
                "answer": "Lottery ticket",
              },
            ],
            "written": [],
          };
          for (var question in data['mcq'] as List) {
            controller.options = [];
            for (var option in question['options'] as List) {
              controller.addOption(option);
            }
            controller.questionController.text = question['text'];
            await showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: MCQModalBottomSheetBuilder,
            );
          }
          for (var q in controller.quiz.MCQQuestions) {
            print("mcq q: ${q.question} ${q.answer} ${q.options}");
          }
          // adding written question
          for (var question in data['written'] as List) {
            controller.questionController.text = question['text'];
            controller.answerController.text = question['answer'];
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: writtenQuestionModalBottomSheetBuilder,
            );
          }
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
// Role Based [teacher, student]
// Score System [student =>  10/50 => solve correct for 10 quizs from 50]