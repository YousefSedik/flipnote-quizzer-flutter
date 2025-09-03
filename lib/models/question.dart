class WrittenQuestion {
  int id;
  String question;
  String answer;

  WrittenQuestion({
    required this.id,
    required this.question,
    required this.answer,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'type': 'written',
    'text': question,
    'answer': answer,
  };

  factory WrittenQuestion.fromJson(Map<String, dynamic> json) {
    return WrittenQuestion(
      question: json['text'],
      answer: json['answer'],
      id: json['id'],
    );
  }
}

class MultipleChoiceQuestion {
  MultipleChoiceQuestion({
    required this.id,
    required this.question,
    required this.answer,
    required this.options,
  });
  int id;
  String question;
  String answer;
  List<String> options;
  Map<String, dynamic> toJson() => {
    'id': id,
    'type': 'mcq',
    'text': question,
    'answer': answer,
    'options': options,
  };
  factory MultipleChoiceQuestion.fromJson(Map<String, dynamic> json) {
    return MultipleChoiceQuestion(
      id: json['id'],
      question: json['text'],
      answer: json['answer'],
      options: List<String>.from(json['options']),
    );
  }
}
