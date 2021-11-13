import 'package:equatable/equatable.dart';
import 'package:spike_code_interview/domain/entities/question.dart';

class QuestionResponse extends Equatable {
  final String category;
  final String difficulty;
  final String question;
  final String correctAnswer;
  final List<String> incorrectAnswers;

  const QuestionResponse(
      {required this.category,
      required this.difficulty,
      required this.question,
      required this.correctAnswer,
      required this.incorrectAnswers});

  @override
  List<Object?> get props =>
      [category, difficulty, question, correctAnswer, incorrectAnswers];

  Map<String, dynamic> toMap() {
    return {
      'category': category,
      'difficulty': difficulty,
      'question': question,
      'correctAnswer': correctAnswer,
      'incorrectAnswers': incorrectAnswers,
    };
  }

  factory QuestionResponse.fromMap(Map<String, dynamic> map) {
    return QuestionResponse(
      category: map['category'] as String,
      difficulty: map['difficulty'] as String,
      question: map['question'] as String,
      correctAnswer: map['correct_answer'] as String,
      incorrectAnswers: List<String>.from(map['incorrect_answers'] ?? []),
    );
  }

  Question toEntity() {
    return Question(
      category: category,
      difficulty: difficulty,
      question: question,
      correctAnswer: correctAnswer,
      answers: incorrectAnswers
        ..add(correctAnswer)
        ..shuffle(),
    );
  }
}
