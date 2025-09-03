import 'package:project/api/api.dart';
import 'package:project/models/question.dart';

class QuizModel {
  String? id;
  String? title;
  String? description;
  bool? isPrivate;
  int viewsCount;
  final String? author;
  final int? questionCount;
  final String? createdAt;
  String? timeSince;
  final ApiClient apiClient = ApiClient();

  List<MultipleChoiceQuestion> MCQQuestions = [];
  List<WrittenQuestion> writtenQuestions = [];

  QuizModel({
    this.id,
    this.title,
    this.description,
    this.isPrivate,
    this.author,
    this.createdAt,
    this.questionCount,
    this.viewsCount = 0,
    this.MCQQuestions = const [],
    this.writtenQuestions = const [],
    this.timeSince,
  });
  Future<void> getData()async {

  }
  Future<void> fetchQuestions(String id) async {
    final response = await apiClient.getQuestions(id);
    if (response.statusCode == 200) {
      final data = response.data as Map;
      for (var question in data["mcq_questions"]) {
        MCQQuestions.add(
          MultipleChoiceQuestion(
            id: question['id'],
            question: question['text'],
            answer: question['correct_answer'],
            options: question['choices'],
          ),
        );
      }
      for (var question in data["written_questions"]) {
        writtenQuestions.add(
          WrittenQuestion(
            id: question['id'],
            question: question['text'],
            answer: question['answer'],
          ),
        );
      }
    } else {
      print("Failed to load questions");
    }
  }

  factory QuizModel.fromJson(Map<String, dynamic> quizJson) {
    return QuizModel(
      id: quizJson['id'],
      title: quizJson['title'],
      description: quizJson['description'],
      author: quizJson['owner_username'] ?? 'Unknown',
      questionCount: quizJson['question_count'] ?? 0,
      createdAt: quizJson['created_at'] ?? '',
      isPrivate: !quizJson['is_public'],
      viewsCount: quizJson['views_count'] ?? 0,
      timeSince: quizJson['time_since'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'is_private': isPrivate,
      'author': author,
      'created_at': createdAt,
      'question_count': questionCount,
      'views_count': viewsCount,
      'time_since': timeSince,
    };
  }
}
