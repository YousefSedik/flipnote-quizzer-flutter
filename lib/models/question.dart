class WrittenQuestion {
  int? id;
  String question;
  String answer;

  WrittenQuestion({
    this.id,
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

  toMap() {}
}

class MultipleChoiceQuestion {
  MultipleChoiceQuestion({
    this.id,
    required this.question,
    required this.answer,
    required this.options,
  });
  int? id;
  String question;
  String answer;
  List<String> options;
  Map<String, dynamic> toJson() => {
    'id': id,
    'type': 'mcq',
    'text': question,
    'correct_answer': answer,
    'choices': options,
  };
  factory MultipleChoiceQuestion.fromJson(Map<String, dynamic> json) {
    return MultipleChoiceQuestion(
      id: json['id'],
      question: json['text'],
      answer: json['correct_answer'],
      options: List<String>.from(json['choices']),
    );
  }
}
